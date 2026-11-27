/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

// Reports from the Bug Report addon, shipped with the launcher. The addon
// whispers itself with the SFBUG prefix; ChatHandler hands those messages here
// and the answer goes back the same way. Messages (addon -> server):
//
//   PING                              answered ON, or OFF when BugReport.Enable is 0
//   TOKEN                             asks for a launcher upload token
//   R:<nonce>:<seq>:<total>:<data>    one piece of a report (seq 1..total)
//
// and the answers (server -> addon):
//
//   ON / OFF
//   TOKEN:<64 hex>                    a new upload token (only its SHA-256 is kept)
//   OK:<nonce>:<id>                   the report was saved as BUG-<id>
//   ERR:<nonce>:<reason>              OFF, SHORT, RATE, BAD or DB
//
// An addon message carries at most 255 bytes, so the addon cuts a report into
// pieces, all with the same nonce. Joined, they are "key=value" fields split
// by ";", with no control characters: in values, a newline is sent as \n and
// "\" and ";" as \\ and \;. "cat" and "desc" are the category and
// description; every other field is kept, one per line, as client_context. The server adds what it knows itself: account, character,
// map, position, target and time.
//
// The table is in auth so that all realms share one list (see
// sql/pending_updates/auth/bug_reports.sql).

#include "BugReportHandler.h"

#include "Config.h"
#include "CryptoHash.h"
#include "CryptoRandom.h"
#include "DatabaseEnv.h"
#include "Log.h"
#include "ObjectDefines.h"
#include "Player.h"
#include "SystemConfig.h"
#include "Util.h"
#include "World.h"
#include "WorldSession.h"

#include <deque>
#include <mutex>
#include <unordered_map>
#include <vector>

namespace
{
    constexpr uint32 MaxPieces = 32;               // 32 * ~240 bytes: about 7.5 KB a report
    constexpr size_t MaxDescriptionBytes = 4000;
    constexpr size_t MaxContextBytes = 3000;
    constexpr time_t PieceTimeout = 60;            // a report not complete by then is dropped

    struct PendingReport
    {
        std::string nonce;
        std::vector<std::string> pieces;
        uint32 received = 0;
        time_t started = 0;
    };

    // By character (low guid). Only the world thread uses these (the addon
    // whisper opcode is PROCESS_THREADUNSAFE); the lock is there in case that
    // ever changes.
    std::mutex Lock;
    std::unordered_map<uint32, PendingReport> Pending;
    std::unordered_map<uint32, std::deque<time_t>> Sent;

    bool IsCategory(std::string const& name)
    {
        return name == "quest" || name == "creature" || name == "spell"
            || name == "item" || name == "zone" || name == "other";
    }

    void Reply(Player* player, std::string const& text)
    {
        player->WhisperAddon(text, BUG_REPORT_ADDON_PREFIX, player);
    }

    // Splits at the first `count` separators; the last part keeps the rest.
    std::vector<std::string> SplitFirst(std::string const& text, char separator, size_t count)
    {
        std::vector<std::string> parts;
        size_t start = 0;
        while (parts.size() < count)
        {
            size_t end = text.find(separator, start);
            if (end == std::string::npos)
                break;
            parts.push_back(text.substr(start, end - start));
            start = end + 1;
        }
        parts.push_back(text.substr(start));
        return parts;
    }

    // Splits the report at each ";" that isn't escaped. The fields keep their escapes.
    std::vector<std::string> SplitFields(std::string const& payload)
    {
        std::vector<std::string> fields(1);
        for (size_t i = 0; i < payload.size(); ++i)
        {
            char c = payload[i];
            if (c == '\\' && i + 1 < payload.size())
            {
                fields.back() += c;
                fields.back() += payload[++i];
            }
            else if (c == ';')
                fields.emplace_back();
            else
                fields.back() += c;
        }
        return fields;
    }

    std::string Unescape(std::string const& value)
    {
        std::string out;
        out.reserve(value.size());
        for (size_t i = 0; i < value.size(); ++i)
        {
            char c = value[i];
            if (c == '\\' && i + 1 < value.size())
            {
                char next = value[++i];
                out += next == 'n' ? '\n' : next;
            }
            // The client's edit box doubles every "|" the player types.
            else if (c == '|' && i + 1 < value.size() && value[i + 1] == '|')
            {
                out += '|';
                ++i;
            }
            else
                out += c;
        }
        return out;
    }

    std::string Trim(std::string const& text)
    {
        size_t first = text.find_first_not_of(" \t\r\n");
        if (first == std::string::npos)
            return "";
        size_t last = text.find_last_not_of(" \t\r\n");
        return text.substr(first, last - first + 1);
    }

    // Cuts to at most `bytes`, never in the middle of a UTF-8 character.
    std::string Cut(std::string text, size_t bytes)
    {
        if (text.size() <= bytes)
            return text;
        size_t end = bytes;
        while (end > 0 && (uint8(text[end]) & 0xC0) == 0x80)
            --end;
        text.resize(end);
        return text;
    }

    void SendToken(Player* player)
    {
        uint32 accountId = player->GetSession()->GetAccountId();
        std::string token = ByteArrayToHexStr(SkyFire::Crypto::GetRandomBytes<32>());
        std::string hash = ByteArrayToHexStr(SkyFire::Crypto::SHA256::GetDigestOf(token));

        SQLTransaction trans = LoginDatabase.BeginTransaction();
        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_FEEDBACK_TOKEN);
        stmt->setString(0, hash);
        stmt->setUInt32(1, accountId);
        trans->Append(stmt);
        stmt = LoginDatabase.GetPreparedStatement(LOGIN_DEL_OLD_FEEDBACK_TOKENS);
        stmt->setUInt32(0, accountId);
        stmt->setUInt32(1, accountId);
        trans->Append(stmt);
        LoginDatabase.CommitTransaction(trans);

        Reply(player, "TOKEN:" + token);
    }

    // Returns the reason to refuse, or an empty string. Records the report as
    // sent when it isn't refused.
    std::string CheckRate(uint32 guidLow, time_t now)
    {
        time_t cooldown = time_t(sConfigMgr->GetIntDefault("BugReport.Cooldown", 60));
        size_t maxPerDay = size_t(std::max(1, sConfigMgr->GetIntDefault("BugReport.MaxPerDay", 20)));

        std::deque<time_t>& sent = Sent[guidLow];
        while (!sent.empty() && sent.front() <= now - DAY)
            sent.pop_front();

        if (!sent.empty() && now - sent.back() < cooldown)
            return "RATE";
        if (sent.size() >= maxPerDay)
            return "RATE";

        sent.push_back(now);
        return "";
    }

    void Save(Player* player, std::string const& nonce, std::string const& payload)
    {
        std::string category;
        std::string description;
        std::string context;
        for (std::string const& line : SplitFields(payload))
        {
            std::vector<std::string> keyValue = SplitFirst(line, '=', 1);
            if (keyValue.size() != 2)
                continue;
            if (keyValue[0] == "cat")
                category = keyValue[1];
            else if (keyValue[0] == "desc")
                description = Trim(Unescape(keyValue[1]));
            else
            {
                context += keyValue[0] + "=" + Unescape(keyValue[1]);
                context += '\n';
            }
        }

        if (!IsCategory(category))
            category = "other";

        std::string forLength = description;
        size_t characters = utf8length(forLength); // 0 for invalid UTF-8
        if (characters < size_t(std::max(1, sConfigMgr->GetIntDefault("BugReport.MinLength", 10))))
        {
            Reply(player, "ERR:" + nonce + ":SHORT");
            return;
        }

        time_t now = time(nullptr);
        std::string refused;
        {
            std::lock_guard<std::mutex> guard(Lock);
            refused = CheckRate(player->GetGUIDLow(), now);
        }
        if (!refused.empty())
        {
            Reply(player, "ERR:" + nonce + ":" + refused);
            return;
        }

        uint64 target = player->GetTarget();
        uint32 targetEntry = (IS_CRE_OR_VEH_GUID(target) || IS_GAMEOBJECT_GUID(target)) ? GUID_ENPART(target) : 0;
        std::string ref = ByteArrayToHexStr(SkyFire::Crypto::GetRandomBytes<8>());

        uint8 index = 0;
        PreparedStatement* stmt = LoginDatabase.GetPreparedStatement(LOGIN_INS_BUG_REPORT);
        stmt->setString(index++, ref);
        stmt->setUInt32(index++, realmID);
        stmt->setUInt32(index++, player->GetSession()->GetAccountId());
        stmt->setUInt32(index++, player->GetGUIDLow());
        stmt->setString(index++, player->GetName());
        stmt->setString(index++, category);
        stmt->setString(index++, Cut(description, MaxDescriptionBytes));
        stmt->setString(index++, Cut(context, MaxContextBytes));
        stmt->setUInt16(index++, uint16(player->GetMapId()));
        stmt->setUInt16(index++, uint16(player->GetZoneId()));
        stmt->setUInt16(index++, uint16(player->GetAreaId()));
        stmt->setUInt32(index++, player->GetInstanceId());
        stmt->setFloat(index++, player->GetPositionX());
        stmt->setFloat(index++, player->GetPositionY());
        stmt->setFloat(index++, player->GetPositionZ());
        stmt->setFloat(index++, player->GetOrientation());
        stmt->setUInt64(index++, target);
        stmt->setUInt32(index++, targetEntry);
        stmt->setUInt8(index++, player->getLevel());
        stmt->setUInt8(index++, player->getClass());
        stmt->setUInt8(index++, player->getRace());
        stmt->setString(index++, SKYFIRE_VER_PRODUCTVERSION_STR);
        LoginDatabase.DirectExecute(stmt);

        stmt = LoginDatabase.GetPreparedStatement(LOGIN_SEL_BUG_REPORT_ID_BY_REF);
        stmt->setString(0, ref);
        PreparedQueryResult result = LoginDatabase.Query(stmt);
        if (!result)
        {
            SF_LOG_ERROR("misc", "BugReport: report from %s (account %u) was not saved",
                player->GetName().c_str(), player->GetSession()->GetAccountId());
            Reply(player, "ERR:" + nonce + ":DB");
            return;
        }

        uint32 id = (*result)[0].GetUInt32();
        SF_LOG_INFO("misc", "BugReport: BUG-%u from %s (account %u), category %s, map %u",
            id, player->GetName().c_str(), player->GetSession()->GetAccountId(), category.c_str(), player->GetMapId());
        Reply(player, "OK:" + nonce + ":" + std::to_string(id));
    }

    // Adds one piece. Returns the whole report once its last piece is in.
    bool AddPiece(Player* player, std::string const& message, std::string& nonce, std::string& payload)
    {
        // R:<nonce>:<seq>:<total>:<data>
        std::vector<std::string> parts = SplitFirst(message, ':', 4);
        if (parts.size() != 5 || parts[1].empty() || parts[1].size() > 8)
            return false;

        nonce = parts[1];
        uint32 seq = uint32(atoi(parts[2].c_str()));
        uint32 total = uint32(atoi(parts[3].c_str()));
        if (total == 0 || total > MaxPieces || seq == 0 || seq > total)
        {
            Reply(player, "ERR:" + nonce + ":BAD");
            return false;
        }

        time_t now = time(nullptr);
        std::lock_guard<std::mutex> guard(Lock);

        for (auto itr = Pending.begin(); itr != Pending.end();)
        {
            if (now - itr->second.started > PieceTimeout)
                itr = Pending.erase(itr);
            else
                ++itr;
        }

        PendingReport& report = Pending[player->GetGUIDLow()];
        if (report.nonce != nonce || report.pieces.size() != total)
        {
            // A new report replaces one that never finished.
            report = PendingReport();
            report.nonce = nonce;
            report.pieces.resize(total);
            report.started = now;
        }

        std::string& piece = report.pieces[seq - 1];
        if (piece.empty() && !parts[4].empty())
            ++report.received;
        piece = parts[4];

        if (report.received < total)
            return false;

        payload.clear();
        for (std::string const& p : report.pieces)
            payload += p;
        Pending.erase(player->GetGUIDLow());
        return true;
    }
}

void BugReport::HandleAddonMessage(Player* sender, std::string const& message)
{
    if (!sConfigMgr->GetBoolDefault("BugReport.Enable", true))
    {
        if (message.compare(0, 2, "R:") == 0)
        {
            std::vector<std::string> parts = SplitFirst(message, ':', 2);
            if (parts.size() == 3 && parts[2].compare(0, 2, "1:") == 0)
                Reply(sender, "ERR:" + parts[1] + ":OFF");
        }
        else
            Reply(sender, "OFF");
        return;
    }

    if (message == "PING")
        Reply(sender, "ON");
    else if (message == "TOKEN")
        SendToken(sender);
    else if (message.compare(0, 2, "R:") == 0)
    {
        std::string nonce;
        std::string payload;
        if (AddPiece(sender, message, nonce, payload))
            Save(sender, nonce, payload);
    }
}
