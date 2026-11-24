/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Rated PvP, ported from Legends of Azeroth Pandaria 5.4.8 (GPL v2); see RatedPvp.h.
*/

#include "RatedPvp.h"
#include "Battleground.h"
#include "BattlegroundQueue.h"
#include "DatabaseEnv.h"
#include "Group.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"
#include "Config.h"
#include "DBCStores.h"
#include "Item.h"
#include "Mail.h"
#include "ObjectMgr.h"
#include "Util.h"

#include <algorithm>
#include <cmath>
#include <map>
#include <set>
#include <sstream>
#include <string>

// ---------------------------------------------------------------- store

void RatedPvpMgr::LoadFromDB()
{
    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    for (uint8 i = 0; i < PVP_SLOT_MAX; ++i)
        m_store[i].clear();

    uint32 const season = sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID);

    //                                                    0       1       2        3              4                5            6            7             8              9              10                11               12
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RATED_PVP_INFO);
    stmt->setUInt16(0, uint16(season));
    if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
    {
        do
        {
            Field* fields = result->Fetch();
            uint8 slot = fields[1].GetUInt8();
            if (slot >= PVP_SLOT_MAX)
                continue;

            uint64 guid = MAKE_NEW_GUID(fields[0].GetUInt32(), 0, HIGHGUID_PLAYER);
            std::shared_ptr<RatedPvpInfo>& info = m_store[slot][guid];
            info.reset(new RatedPvpInfo());
            info->Guid = guid;
            info->Slot = slot;
            info->Rank = fields[2].GetUInt32();
            info->Rating = fields[3].GetUInt32();
            info->MatchmakerRating = fields[4].GetUInt32();
            info->WeekBest = fields[5].GetUInt32();
            info->WeekGames = fields[6].GetUInt32();
            info->WeekWins = fields[7].GetUInt32();
            info->SeasonBest = fields[8].GetUInt32();
            info->SeasonGames = fields[9].GetUInt32();
            info->SeasonWins = fields[10].GetUInt32();
            info->LastWeekBest = fields[11].GetUInt32();
            info->WinStreak = fields[12].GetUInt32();
            ++count;
        }
        while (result->NextRow());
    }

    SF_LOG_INFO("server.loading", ">> Loaded %u rated PvP ratings (season %u) in %u ms", count, season, GetMSTimeDiffToNow(oldMSTime));
}

RatedPvpInfo* RatedPvpMgr::GetInfo(RatedPvpSlot slot, uint64 guid) const
{
    if (slot >= PVP_SLOT_MAX)
        return NULL;

    RatedPvpInfoMap::const_iterator itr = m_store[slot].find(guid);
    return itr != m_store[slot].end() ? itr->second.get() : NULL;
}

RatedPvpInfo* RatedPvpMgr::GetOrCreateInfo(RatedPvpSlot slot, uint64 guid)
{
    if (slot >= PVP_SLOT_MAX)
        return NULL;

    if (RatedPvpInfo* info = GetInfo(slot, guid))
        return info;

    std::shared_ptr<RatedPvpInfo>& info = m_store[slot][guid];
    info.reset(new RatedPvpInfo());
    info->Guid = guid;
    info->Slot = slot;
    info->Rating = sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_START_PERSONAL_RATING);
    info->MatchmakerRating = sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_START_MATCHMAKER_RATING);
    info->Rank = uint32(m_store[slot].size());

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_RATED_PVP_INFO);
    stmt->setUInt32(0, GUID_LOPART(guid));
    stmt->setUInt8(1, uint8(slot));
    stmt->setUInt16(2, uint16(sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID)));
    stmt->setUInt16(3, uint16(info->Rating));
    stmt->setUInt16(4, uint16(info->MatchmakerRating));
    CharacterDatabase.Execute(stmt);
    return info.get();
}

void RatedPvpMgr::SaveToDB(RatedPvpInfo const* info)
{
    uint8 i = 0;
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_RATED_PVP_INFO);
    stmt->setUInt32(i++, info->Rank);
    stmt->setUInt16(i++, uint16(info->Rating));
    stmt->setUInt16(i++, uint16(info->MatchmakerRating));
    stmt->setUInt16(i++, uint16(info->WeekBest));
    stmt->setUInt16(i++, uint16(info->WeekGames));
    stmt->setUInt16(i++, uint16(info->WeekWins));
    stmt->setUInt16(i++, uint16(info->SeasonBest));
    stmt->setUInt16(i++, uint16(info->SeasonGames));
    stmt->setUInt16(i++, uint16(info->SeasonWins));
    stmt->setUInt16(i++, uint16(info->LastWeekBest));
    stmt->setUInt32(i++, info->WinStreak);
    stmt->setUInt32(i++, GUID_LOPART(info->Guid));
    stmt->setUInt8(i++, uint8(info->Slot));
    stmt->setUInt16(i++, uint16(sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID)));
    CharacterDatabase.Execute(stmt);
}

void RatedPvpMgr::ResetWeek()
{
    for (uint8 slot = 0; slot < PVP_SLOT_MAX; ++slot)
    {
        for (RatedPvpInfoMap::iterator itr = m_store[slot].begin(); itr != m_store[slot].end(); ++itr)
        {
            itr->second->LastWeekBest = itr->second->WeekBest;
            itr->second->WeekBest = 0;
            itr->second->WeekGames = 0;
            itr->second->WeekWins = 0;
        }
    }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_RATED_PVP_INFO_WEEKLY);
    stmt->setUInt16(0, uint16(sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID)));
    CharacterDatabase.Execute(stmt);
}

// LoA's ranking: rating, then fewer games, win ratio, MMR, season best
static bool IsHigherRank(RatedPvpInfo const* lhs, RatedPvpInfo const* rhs)
{
    if (lhs->Rating != rhs->Rating)
        return lhs->Rating > rhs->Rating;
    if (lhs->SeasonGames != rhs->SeasonGames)
        return lhs->SeasonGames < rhs->SeasonGames;
    if (lhs->SeasonGames && rhs->SeasonGames)
    {
        uint32 l = lhs->SeasonWins * 100 / lhs->SeasonGames;
        uint32 r = rhs->SeasonWins * 100 / rhs->SeasonGames;
        if (l != r)
            return l > r;
    }
    if (lhs->MatchmakerRating != rhs->MatchmakerRating)
        return lhs->MatchmakerRating > rhs->MatchmakerRating;
    if (lhs->SeasonBest != rhs->SeasonBest)
        return lhs->SeasonBest > rhs->SeasonBest;
    return lhs->Guid > rhs->Guid;
}

void RatedPvpMgr::RecalculateRank(RatedPvpSlot slot)
{
    if (slot >= PVP_SLOT_MAX)
        return;

    std::vector<RatedPvpInfo*> sorted;
    sorted.reserve(m_store[slot].size());
    for (RatedPvpInfoMap::const_iterator itr = m_store[slot].begin(); itr != m_store[slot].end(); ++itr)
        sorted.push_back(itr->second.get());

    std::sort(sorted.begin(), sorted.end(), IsHigherRank);

    for (uint32 i = 0; i < sorted.size(); ++i)
    {
        if (sorted[i]->Rank != i + 1)
        {
            sorted[i]->Rank = i + 1;
            SaveToDB(sorted[i]);
        }
    }
}

// ---------------------------------------------------------------- season end
// Ported from LoA's RatedPvpMgr::CheckSeasonEnd / RewardSeason / SeasonCleanup (RatedPvp.cpp). Config (worldserver.conf):
//   Arena.SeasonReward.RatingThreshold.2x2 / 3x3 / 5x5   rating a player needs (above it) to be ranked; -1 = no rewards
//   Arena.SeasonReward.Rank1..Rank6.Titles / .Achievements / .Items
//       ids separated by spaces, or "2v2 ids; 3v3 ids; 5v5 ids". Ranks 1-3 are places (1-2, 3-4, 5-6; 5v5: 1, 2, 3),
//       ranks 4-6 the top 10 %, 15 % and 20 % of the ranked players.
//   Arena.SeasonReward.Cleanup.Enabled (1), .Titles ("44 43 45"), .Achievements ("2093 2092 2090"),
//       .KeepWithAchievements ("2091"): the seasonal titles and achievements taken away, except from players with these.
// Differences from LoA: nothing happens on the first start (no season stored yet: the current one is only recorded, so a
// new realm doesn't run the cleanup); the reward log goes to the server log; refundable PvP items are left alone.

namespace
{
    struct SeasonReward
    {
        uint32 UpperPlace = 0;
        float Percent = 0.0f;
        std::vector<uint32> Titles;
        std::vector<uint32> Achievs;
        std::vector<uint32> Items;
    };

    std::vector<uint32> ConfigIds(std::string const& name, uint32 arenaType, std::string const& def = "")
    {
        std::string config = sConfigMgr->GetStringDefault(name.c_str(), def.c_str());
        if (config.find(';') != std::string::npos)
        {
            Tokenizer tok(config, ';');
            uint32 index = arenaType == ARENA_TYPE_2v2 ? 0 : (arenaType == ARENA_TYPE_3v3 ? 1 : 2);
            config = index < tok.size() ? tok[index] : "";
        }

        std::vector<uint32> ids;
        Tokenizer tok(config, ' ');
        for (Tokenizer::const_iterator itr = tok.begin(); itr != tok.end(); ++itr)
            if (uint32 id = uint32(strtoul(*itr, NULL, 10)))
                ids.push_back(id);
        return ids;
    }

    void CheckIds(std::vector<uint32>& ids, std::string const& name, uint8 kind)
    {
        for (std::vector<uint32>::iterator itr = ids.begin(); itr != ids.end();)
        {
            bool ok = kind == 0 ? sCharTitlesStore.LookupEntry(*itr) != NULL
                : (kind == 1 ? sAchievementStore.LookupEntry(*itr) != NULL : sObjectMgr->GetItemTemplate(*itr) != NULL);
            if (ok)
                ++itr;
            else
            {
                SF_LOG_ERROR("server.loading", "%s: id %u not found, skipped", name.c_str(), *itr);
                itr = ids.erase(itr);
            }
        }
    }

    std::vector<SeasonReward> GetSeasonRewards(uint32 arenaType)
    {
        std::vector<SeasonReward> rewards(6);
        for (uint32 i = 0; i < 6; ++i)
        {
            std::string base = "Arena.SeasonReward.Rank" + std::to_string(i + 1);
            rewards[i].Titles = ConfigIds(base + ".Titles", arenaType);
            rewards[i].Achievs = ConfigIds(base + ".Achievements", arenaType);
            rewards[i].Items = ConfigIds(base + ".Items", arenaType);
            CheckIds(rewards[i].Titles, base + ".Titles", 0);
            CheckIds(rewards[i].Achievs, base + ".Achievements", 1);
            CheckIds(rewards[i].Items, base + ".Items", 2);
        }
        bool five = arenaType == ARENA_TYPE_5v5;
        rewards[0].UpperPlace = five ? 1 : 2;
        rewards[1].UpperPlace = five ? 2 : 4;
        rewards[2].UpperPlace = five ? 3 : 6;
        rewards[3].Percent = 10.0f;
        rewards[4].Percent = 15.0f;
        rewards[5].Percent = 20.0f;
        return rewards;
    }

    // last rank of each reward group (LoA's CalculateRanks); 0 = nobody left for that group
    std::vector<uint32> CalculateRankLimits(uint32 size, std::vector<SeasonReward> const& rewards)
    {
        std::vector<uint32> groups(rewards.size());
        for (uint32 i = 0; i < 3; ++i)
            groups[i] = rewards[i].UpperPlace;
        for (uint32 i = 3; i < rewards.size(); ++i)
        {
            uint32 n = uint32(std::ceil(size * rewards[i].Percent / 100.0f));
            n = std::max(groups[i - 1] + 1, n);
            groups[i] = n < size ? n : 0;
        }
        return groups;
    }

    struct PlayerSeasonRewards
    {
        std::set<uint32> Titles;
        std::set<uint32> Achievs;
        std::vector<uint32> Items;
    };

    bool ReadTitles(std::string const& str, std::vector<uint32>& out)
    {
        Tokenizer t(str, ' ');
        if (t.size() != KNOWN_TITLES_SIZE * 2)
            return false;
        out.resize(KNOWN_TITLES_SIZE * 2);
        for (uint32 i = 0; i < KNOWN_TITLES_SIZE * 2; ++i)
            out[i] = uint32(strtoul(t[i], NULL, 10));
        return true;
    }

    std::string WriteTitles(std::vector<uint32> const& titles)
    {
        std::ostringstream ss;
        for (uint32 i = 0; i < titles.size(); ++i)
            ss << titles[i] << ' ';
        return ss.str();
    }

    void SeasonCleanup(SQLTransaction& trans)
    {
        if (!sConfigMgr->GetBoolDefault("Arena.SeasonReward.Cleanup.Enabled", true))
            return;

        std::set<uint32> keep;
        std::vector<uint32> keepAchievs = ConfigIds("Arena.SeasonReward.Cleanup.KeepWithAchievements", ARENA_TYPE_2v2, "2091");
        for (uint32 i = 0; i < keepAchievs.size(); ++i)
            if (QueryResult result = CharacterDatabase.PQuery("SELECT guid FROM character_achievement WHERE achievement = %u", keepAchievs[i]))
            {
                do
                    keep.insert((*result)[0].GetUInt32());
                while (result->NextRow());
            }

        std::vector<uint32> achievs = ConfigIds("Arena.SeasonReward.Cleanup.Achievements", ARENA_TYPE_2v2, "2093 2092 2090");
        for (uint32 i = 0; i < achievs.size(); ++i)
        {
            if (!sAchievementStore.LookupEntry(achievs[i]))
                continue;
            std::ostringstream ss;
            ss << "DELETE FROM character_achievement WHERE achievement = " << achievs[i];
            if (!keep.empty())
            {
                ss << " AND guid NOT IN (";
                for (std::set<uint32>::const_iterator itr = keep.begin(); itr != keep.end(); ++itr)
                    ss << (itr == keep.begin() ? "" : ",") << *itr;
                ss << ")";
            }
            trans->Append(ss.str().c_str());
        }

        std::vector<CharTitlesEntry const*> titles;
        std::vector<uint32> titleIds = ConfigIds("Arena.SeasonReward.Cleanup.Titles", ARENA_TYPE_2v2, "44 43 45");
        for (uint32 i = 0; i < titleIds.size(); ++i)
            if (CharTitlesEntry const* title = sCharTitlesStore.LookupEntry(titleIds[i]))
                titles.push_back(title);
        if (titles.empty())
            return;

        uint32 count = 0;
        if (QueryResult result = CharacterDatabase.Query("SELECT guid, knownTitles FROM characters"))
        {
            do
            {
                uint32 guid = (*result)[0].GetUInt32();
                std::vector<uint32> known;
                if (keep.count(guid) || !ReadTitles((*result)[1].GetString(), known))
                    continue;

                bool changed = false;
                for (uint32 i = 0; i < titles.size(); ++i)
                {
                    uint32 pos = titles[i]->bit_index / 32;
                    uint32 flag = 1 << (titles[i]->bit_index % 32);
                    if (pos < known.size() && (known[pos] & flag))
                    {
                        known[pos] &= ~flag;
                        changed = true;
                        ++count;
                    }
                }
                if (changed)
                    trans->PAppend("UPDATE characters SET knownTitles = '%s' WHERE guid = %u", WriteTitles(known).c_str(), guid);
            }
            while (result->NextRow());
        }
        SF_LOG_INFO("server.loading", "Arena season end: %u seasonal titles removed", count);
    }
}

void RatedPvpMgr::CheckSeasonEnd()
{
    uint32 current = sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID);
    if (!current)
        return;

    uint32 stored = uint32(sWorld->getWorldState(WS_ARENA_SEASON_ID));
    if (stored >= current)
        return;

    if (!stored)
    {
        // first start with this code: record the season, reward nothing
        sWorld->setWorldState(WS_ARENA_SEASON_ID, current);
        SF_LOG_INFO("server.loading", ">> Arena season %u recorded (no earlier season to reward)", current);
        return;
    }

    RewardSeason(stored, current);
}

void RatedPvpMgr::RewardSeason(uint32 oldSeason, uint32 newSeason)
{
    SF_LOG_INFO("server.loading", ">> Arena season %u has ended (now %u): giving the season rewards", oldSeason, newSeason);
    SQLTransaction trans = CharacterDatabase.BeginTransaction();

    SeasonCleanup(trans);

    std::map<uint32, PlayerSeasonRewards> rewardMap;
    uint32 const types[3] = { ARENA_TYPE_2v2, ARENA_TYPE_3v3, ARENA_TYPE_5v5 };
    for (uint32 t = 0; t < 3; ++t)
    {
        uint32 type = types[t];
        std::string name = "Arena.SeasonReward.RatingThreshold." + std::to_string(type) + "x" + std::to_string(type);
        int32 threshold = sConfigMgr->GetIntDefault(name.c_str(), -1);
        if (threshold < 0)
        {
            SF_LOG_INFO("server.loading", "   %ux%u: season rewards disabled", type, type);
            continue;
        }

        // the old season's ranked players above the threshold, best rank first
        std::vector<std::pair<uint32, uint32> > ranked; // rank, guid
        if (QueryResult result = CharacterDatabase.PQuery("SELECT r.rank, r.guid FROM rated_pvp_info r JOIN characters c ON c.guid = r.guid "
            "WHERE r.season = %u AND r.slot = %u AND r.rating > %u AND c.deleteDate IS NULL ORDER BY r.rank", oldSeason, uint32(RatedPvpTeam::GetSlotByType(type)), uint32(threshold)))
        {
            do
                ranked.push_back(std::make_pair((*result)[0].GetUInt32(), (*result)[1].GetUInt32()));
            while (result->NextRow());
        }
        if (ranked.empty())
        {
            SF_LOG_INFO("server.loading", "   %ux%u: nobody above %d rating", type, type, threshold);
            continue;
        }

        std::vector<SeasonReward> rewards = GetSeasonRewards(type);
        std::vector<uint32> limits = CalculateRankLimits(uint32(ranked.size()), rewards);
        uint32 k = 0;
        for (uint32 i = 0; i < rewards.size(); ++i)
        {
            while (k < ranked.size() && ranked[k].first <= limits[i])
            {
                PlayerSeasonRewards& pr = rewardMap[ranked[k].second];
                pr.Titles.insert(rewards[i].Titles.begin(), rewards[i].Titles.end());
                pr.Achievs.insert(rewards[i].Achievs.begin(), rewards[i].Achievs.end());
                pr.Items.insert(pr.Items.end(), rewards[i].Items.begin(), rewards[i].Items.end());
                SF_LOG_INFO("server.loading", "   %ux%u rank %u: player %u gets reward group %u", type, type, ranked[k].first, ranked[k].second, i + 1);
                ++k;
            }
        }
    }

    for (std::map<uint32, PlayerSeasonRewards>::const_iterator itr = rewardMap.begin(); itr != rewardMap.end(); ++itr)
    {
        uint32 guid = itr->first;
        QueryResult result = CharacterDatabase.PQuery("SELECT knownTitles, name FROM characters WHERE guid = %u", guid);
        if (!result)
            continue;

        std::vector<uint32> known;
        if (!itr->second.Titles.empty() && ReadTitles((*result)[0].GetString(), known))
        {
            for (std::set<uint32>::const_iterator t = itr->second.Titles.begin(); t != itr->second.Titles.end(); ++t)
                if (CharTitlesEntry const* title = sCharTitlesStore.LookupEntry(*t))
                    if (title->bit_index / 32 < known.size())
                        known[title->bit_index / 32] |= 1 << (title->bit_index % 32);
            trans->PAppend("UPDATE characters SET knownTitles = '%s' WHERE guid = %u", WriteTitles(known).c_str(), guid);
        }

        for (std::set<uint32>::const_iterator a = itr->second.Achievs.begin(); a != itr->second.Achievs.end(); ++a)
            trans->PAppend("INSERT IGNORE INTO character_achievement (guid, achievement, date) VALUES (%u, %u, %u)", guid, *a, uint32(time(NULL)));

        if (!itr->second.Items.empty())
        {
            std::string playerName = (*result)[1].GetString();
            MailDraft draft("Arena season reward", "Dear " + playerName + ", congratulations on the end of the arena season. Here is your reward.");
            for (uint32 i = 0; i < itr->second.Items.size(); ++i)
                if (Item* item = Item::CreateItem(itr->second.Items[i], 1))
                {
                    item->SaveToDB(trans);
                    draft.AddItem(item);
                }
            draft.SendMailTo(trans, MailReceiver(guid), MailSender(MAIL_NORMAL, 0, MAIL_STATIONERY_GM));
        }
    }

    // the new season starts from zero honor / conquest totals (LoA resets the season and week counts of the same currencies)
    trans->PAppend("UPDATE character_currency SET tracked_quantity = 0, weekly_quantity = 0 WHERE currency IN (%u, %u, %u, %u)",
        uint32(CURRENCY_TYPE_HONOR_POINTS), uint32(CURRENCY_TYPE_CONQUEST_POINTS), uint32(CURRENCY_TYPE_CONQUEST_META_ARENA), uint32(CURRENCY_TYPE_CONQUEST_META_RBG));

    CharacterDatabase.CommitTransaction(trans);
    sWorld->setWorldState(WS_ARENA_SEASON_ID, newSeason);
    SF_LOG_INFO("server.loading", ">> Arena season %u rewards given to %u players", oldSeason, uint32(rewardMap.size()));
}

// ---------------------------------------------------------------- match teams

RatedPvpTeam::RatedPvpTeam(RatedPvpSlot slot, Group* group) : m_slot(slot)
{
    if (!group)
        return;

    for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
        if (Player* member = itr->GetSource())
            AddMember(member->GetGUID());

    if (!m_members.empty())
    {
        m_rating /= m_members.size();
        m_matchmakerRating /= m_members.size();
    }
}

RatedPvpTeam::RatedPvpTeam(RatedPvpSlot slot, GroupQueueInfo const* ginfo) : m_slot(slot)
{
    if (!ginfo)
        return;

    for (std::map<uint64, PlayerQueueInfo*>::const_iterator itr = ginfo->Players.begin(); itr != ginfo->Players.end(); ++itr)
        AddMember(itr->first);

    // the queue keeps the values the group joined with
    m_rating = ginfo->ArenaTeamRating;
    m_matchmakerRating = ginfo->ArenaMatchmakerRating;
}

void RatedPvpTeam::AddMember(uint64 guid)
{
    if (RatedPvpInfo* info = sRatedPvpMgr->GetOrCreateInfo(m_slot, guid))
    {
        m_rating += info->Rating;
        m_matchmakerRating += info->MatchmakerRating;
        m_members.push_back(info);
    }
}

RatedPvpInfo* RatedPvpTeam::GetMember(uint64 guid) const
{
    for (std::vector<RatedPvpInfo*>::const_iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
        if ((*itr)->Guid == guid)
            return *itr;
    return NULL;
}

uint8 RatedPvpTeam::GetSlotByType(uint32 arenaType)
{
    switch (arenaType)
    {
        case ARENA_TYPE_2v2: return PVP_SLOT_ARENA_2v2;
        case ARENA_TYPE_3v3: return PVP_SLOT_ARENA_3v3;
        case ARENA_TYPE_5v5: return PVP_SLOT_ARENA_5v5;
        case 0:              return PVP_SLOT_RATED_BG;
        default:             return PVP_SLOT_MAX;
    }
}

uint8 RatedPvpTeam::GetTypeBySlot(uint8 slot)
{
    switch (slot)
    {
        case PVP_SLOT_ARENA_2v2: return ARENA_TYPE_2v2;
        case PVP_SLOT_ARENA_3v3: return ARENA_TYPE_3v3;
        case PVP_SLOT_ARENA_5v5: return ARENA_TYPE_5v5;
        default:                 return 0;
    }
}

float RatedPvpTeam::GetChanceAgainst(uint32 ownRating, uint32 opponentRating)
{
    // Elo: chance to beat a team of the given rating
    return 1.0f / (1.0f + std::exp(std::log(10.0f) * (float(opponentRating) - float(ownRating)) / 400.0f));
}

int32 RatedPvpTeam::GetMatchmakerRatingMod(uint32 ownRating, uint32 opponentRating, bool won)
{
    float mod = ((won ? 1.0f : 0.0f) - GetChanceAgainst(ownRating, opponentRating)) * 32.0f;
    return int32(std::ceil(mod));
}

int32 RatedPvpTeam::GetRatingMod(uint32 ownRating, uint32 opponentRating, bool won)
{
    float const chance = GetChanceAgainst(ownRating, opponentRating);
    float const wonMod = won ? 1.0f : 0.0f;
    float mod;

    // faster climbing below 1300 (LoA / TrinityCore)
    if (won && ownRating < 1300)
    {
        if (ownRating < 1000)
            mod = 96.0f * (wonMod - chance);
        else
            mod = (32.0f + (24.0f * (1300.0f - float(ownRating)) / 300.0f)) * (wonMod - chance);
    }
    else
        mod = 32.0f * (wonMod - chance);

    return int32(std::ceil(mod));
}

int32 RatedPvpTeam::WonAgainst(uint32 ownMMRating, uint32 opponentMMRating, int32& ratingChange)
{
    int32 mod = GetMatchmakerRatingMod(ownMMRating, opponentMMRating, true);
    ratingChange = GetRatingMod(m_rating, opponentMMRating, true);
    m_matchmakerRating += mod;
    return mod;
}

int32 RatedPvpTeam::LostAgainst(uint32 ownMMRating, uint32 opponentMMRating, int32& ratingChange)
{
    int32 mod = GetMatchmakerRatingMod(ownMMRating, opponentMMRating, false);
    ratingChange = GetRatingMod(m_rating, opponentMMRating, false);
    m_matchmakerRating = (int32(m_matchmakerRating) + mod < 0) ? 0 : m_matchmakerRating + mod;
    return mod;
}

void RatedPvpTeam::MemberWon(Player* player, uint32 againstMatchmakerRating, int32 matchmakerRatingChange)
{
    RatedPvpInfo* info = player ? GetMember(player->GetGUID()) : NULL;
    if (!info || m_handled.count(info->Guid))
        return;
    m_handled.insert(info->Guid);

    int32 mod = GetRatingMod(info->Rating, againstMatchmakerRating, true);
    if (int32(info->Rating) + mod < 0)
        mod = -int32(info->Rating);

    info->Rating += mod;
    if (m_slot != PVP_SLOT_RATED_BG)
        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_PERSONAL_RATING, info->Rating, GetTypeBySlot(info->Slot));

    if (info->Rating > info->SeasonBest)
        info->SeasonBest = info->Rating;
    if (info->Rating > info->WeekBest)
        info->WeekBest = info->Rating;

    info->MatchmakerRating = (int32(info->MatchmakerRating) + matchmakerRatingChange < 0) ? 0 : info->MatchmakerRating + matchmakerRatingChange;
    info->WeekGames += 1;
    info->SeasonGames += 1;
    info->WeekWins += 1;
    info->SeasonWins += 1;
    if (info->WinStreak < 10)
        info->WinStreak += 1;

    m_ratingChanges[info->Guid] = mod;
    RatedPvpMgr::SaveToDB(info);
}

void RatedPvpTeam::MemberLost(Player* player, uint32 againstMatchmakerRating, int32 matchmakerRatingChange)
{
    if (player)
        OfflineMemberLost(player->GetGUID(), againstMatchmakerRating, matchmakerRatingChange);
}

void RatedPvpTeam::OfflineMemberLost(uint64 guid, uint32 againstMatchmakerRating, int32 matchmakerRatingChange)
{
    RatedPvpInfo* info = GetMember(guid);
    if (!info || m_handled.count(guid))
        return;
    m_handled.insert(guid);

    int32 mod = GetRatingMod(info->Rating, againstMatchmakerRating, false);
    if (int32(info->Rating) + mod < 0)
        mod = -int32(info->Rating);

    info->Rating += mod;
    info->MatchmakerRating = (int32(info->MatchmakerRating) + matchmakerRatingChange < 0) ? 0 : info->MatchmakerRating + matchmakerRatingChange;
    info->WeekGames += 1;
    info->SeasonGames += 1;
    info->WinStreak = 0;

    m_ratingChanges[guid] = mod;
    RatedPvpMgr::SaveToDB(info);
}

void RatedPvpTeam::FinishGame(int32 mod)
{
    for (std::vector<RatedPvpInfo*>::const_iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        RatedPvpInfo* info = *itr;
        if (m_handled.count(info->Guid))
            continue;
        m_handled.insert(info->Guid);

        int32 change = (int32(info->Rating) + mod < 0) ? -int32(info->Rating) : mod;
        info->Rating += change;
        info->WeekGames += 1;
        info->SeasonGames += 1;
        info->WinStreak = 0;
        m_ratingChanges[info->Guid] = change;
        RatedPvpMgr::SaveToDB(info);
    }
}

void RatedPvpTeam::NotifyStatsChanged()
{
    for (std::vector<RatedPvpInfo*>::const_iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
        if (Player* player = ObjectAccessor::FindPlayer((*itr)->Guid))
            player->GetSession()->SendRatedPvpInfo();
}
