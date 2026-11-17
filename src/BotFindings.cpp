/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

#include "BotFindings.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "GameObject.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuestDef.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

#include <algorithm>
#include <cmath>
#include <ctime>
#include <sstream>

namespace
{
    uint32 const FLUSH_INTERVAL = 30 * IN_MILLISECONDS;
    // A broken build can produce findings without end; stop taking new ones here.
    size_t const MAX_FINDINGS = 5000;
    size_t const MAX_NOTE = 250;
    float const POSITION_CELL = 50.0f;

    enum class Subject : uint8 { Quest, Creature, Map, Spell };

    struct TypeInfo
    {
        BotFindingType type;
        char const* name;
        Subject subject;
        char const* text;
    };

    TypeInfo const typeInfos[] =
    {
        { BotFindingType::QuestNoStarter,        "quest-no-starter",     Subject::Quest,    "no creature or object starts it" },
        { BotFindingType::QuestStarterNoSpawn,   "starter-no-spawn",     Subject::Quest,    "its starter has no spawn" },
        { BotFindingType::QuestStarterMissing,   "starter-missing",      Subject::Quest,    "its starter is not at its spawn point" },
        { BotFindingType::QuestAcceptFailed,     "accept-failed",        Subject::Quest,    "could not be accepted from its starter" },
        { BotFindingType::QuestObjectiveNoSpawn, "objective-no-spawn",   Subject::Quest,    "objective has no spawn" },
        { BotFindingType::QuestKillNoCredit,     "kill-no-credit",       Subject::Quest,    "kill gave no objective credit" },
        { BotFindingType::QuestStalled,          "quest-stalled",        Subject::Quest,    "no objective progress" },
        { BotFindingType::QuestNoEnder,          "quest-no-ender",       Subject::Quest,    "no creature or object ends it" },
        { BotFindingType::QuestEnderNoSpawn,     "ender-no-spawn",       Subject::Quest,    "its ender has no spawn" },
        { BotFindingType::QuestEnderMissing,     "ender-missing",        Subject::Quest,    "its ender is not at its spawn point" },
        { BotFindingType::QuestTurnInFailed,     "turnin-failed",        Subject::Quest,    "could not be turned in" },
        { BotFindingType::QuestgiverNoQuests,    "questgiver-no-quests", Subject::Creature, "has the questgiver flag but starts and ends no quest" },
        { BotFindingType::PathFailed,            "path-failed",          Subject::Map,      "no path to the destination" },
        { BotFindingType::Stuck,                 "stuck",                Subject::Map,      "bot stopped making headway" },
        { BotFindingType::BadPosition,           "bad-position",         Subject::Map,      "bot stood where the map has no ground" },
        { BotFindingType::SpellNeverCasts,       "spell-never-casts",    Subject::Spell,    "the rotation picks it but the cast never starts" },
        { BotFindingType::QuestInteractNoCredit, "interact-no-credit",   Subject::Quest,    "using the object or talking to the NPC advanced nothing" },
    };

    TypeInfo const* FindTypeInfo(BotFindingType type)
    {
        for (TypeInfo const& info : typeInfos)
            if (info.type == type)
                return &info;
        return nullptr;
    }

    uint32 PositionCell(float x, float y)
    {
        // 16 bits per axis: the world spans about +-17066 yards.
        uint32 const cx = uint32(int32(std::floor(x / POSITION_CELL)) + 0x8000) & 0xFFFF;
        uint32 const cy = uint32(int32(std::floor(y / POSITION_CELL)) + 0x8000) & 0xFFFF;
        return (cx << 16) | cy;
    }

    std::string EntryName(uint32 entry)
    {
        if (CreatureTemplate const* creature = sObjectMgr->GetCreatureTemplate(entry))
            return creature->Name;
        if (GameObjectTemplate const* object = sObjectMgr->GetGameObjectTemplate(entry))
            return object->name;
        return std::string();
    }

    std::string AreaName(uint32 zoneId)
    {
        if (AreaTableEntry const* area = GetAreaEntryByAreaID(zoneId))
            if (area->m_AreaName)
                return area->m_AreaName;
        return std::string();
    }
}

BotFindings* BotFindings::instance()
{
    static BotFindings inst;
    return &inst;
}

char const* BotFindings::TypeName(BotFindingType type)
{
    TypeInfo const* info = FindTypeInfo(type);
    return info ? info->name : "unknown";
}

BotFindingType BotFindings::TypeFromName(std::string const& name)
{
    for (TypeInfo const& info : typeInfos)
        if (name == info.name)
            return info.type;
    return BotFindingType::None;
}

void BotFindings::Load()
{
    CharacterDatabase.DirectExecute(
        "CREATE TABLE IF NOT EXISTS `playerbots_findings` ("
        "  `id` INT UNSIGNED NOT NULL,"
        "  `type` TINYINT UNSIGNED NOT NULL,"
        "  `subject` INT UNSIGNED NOT NULL DEFAULT 0,"
        "  `detail` INT UNSIGNED NOT NULL DEFAULT 0,"
        "  `map` INT UNSIGNED NOT NULL DEFAULT 0,"
        "  `zone` INT UNSIGNED NOT NULL DEFAULT 0,"
        "  `position_x` FLOAT NOT NULL DEFAULT 0,"
        "  `position_y` FLOAT NOT NULL DEFAULT 0,"
        "  `position_z` FLOAT NOT NULL DEFAULT 0,"
        "  `hits` INT UNSIGNED NOT NULL DEFAULT 1,"
        "  `first_seen` INT UNSIGNED NOT NULL DEFAULT 0,"
        "  `last_seen` INT UNSIGNED NOT NULL DEFAULT 0,"
        "  `bot` VARCHAR(12) NOT NULL DEFAULT '',"
        "  `note` VARCHAR(255) NOT NULL DEFAULT '',"
        "  PRIMARY KEY (`id`),"
        "  UNIQUE KEY `finding` (`type`, `subject`, `detail`)"
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8");

    std::lock_guard<std::mutex> guard(_lock);
    _findings.clear();
    _dirty.clear();
    _nextId = 1;

    QueryResult result = CharacterDatabase.Query(
        "SELECT id, type, subject, detail, map, zone, position_x, position_y, position_z, "
        "hits, first_seen, last_seen, bot, note FROM playerbots_findings");
    if (result)
    {
        do
        {
            Field* fields = result->Fetch();
            BotFinding finding;
            finding.id = fields[0].GetUInt32();
            finding.type = BotFindingType(fields[1].GetUInt8());
            finding.subject = fields[2].GetUInt32();
            finding.detail = fields[3].GetUInt32();
            finding.mapId = fields[4].GetUInt32();
            finding.zoneId = fields[5].GetUInt32();
            finding.x = fields[6].GetFloat();
            finding.y = fields[7].GetFloat();
            finding.z = fields[8].GetFloat();
            finding.hits = fields[9].GetUInt32();
            finding.firstSeen = fields[10].GetUInt32();
            finding.lastSeen = fields[11].GetUInt32();
            finding.bot = fields[12].GetString();
            finding.note = fields[13].GetString();

            _nextId = std::max(_nextId, finding.id + 1);
            _findings[Key(uint8(finding.type), finding.subject, finding.detail)] = finding;
        } while (result->NextRow());
    }

    SF_LOG_INFO("modules", "[mod-playerbots] BotFindings: loaded %u finding(s).", uint32(_findings.size()));
}

void BotFindings::Record(BotFindingType type, uint32 subject, uint32 detail, Player const* reporter,
    std::string const& note)
{
    if (!reporter)
        return;
    RecordInternal(type, subject, detail, reporter, reporter->GetMapId(),
        reporter->GetPositionX(), reporter->GetPositionY(), reporter->GetPositionZ(), note);
}

void BotFindings::RecordAt(BotFindingType type, Player const* reporter, float x, float y, float z,
    std::string const& note, int32 mapId)
{
    if (!reporter)
        return;
    uint32 const map = mapId < 0 ? reporter->GetMapId() : uint32(mapId);
    RecordInternal(type, map, PositionCell(x, y), reporter, map, x, y, z, note);
}

void BotFindings::RecordInternal(BotFindingType type, uint32 subject, uint32 detail, Player const* reporter,
    uint32 mapId, float x, float y, float z, std::string const& note)
{
    if (!_enabled || type == BotFindingType::None || type >= BotFindingType::Max)
        return;

    Key const key(uint8(type), subject, detail);
    uint32 const now = uint32(time(nullptr));

    std::lock_guard<std::mutex> guard(_lock);
    auto it = _findings.find(key);
    if (it == _findings.end())
    {
        if (_findings.size() >= MAX_FINDINGS)
            return;

        BotFinding finding;
        finding.id = _nextId++;
        finding.type = type;
        finding.subject = subject;
        finding.detail = detail;
        finding.mapId = mapId;
        finding.zoneId = reporter->IsInWorld() && reporter->GetMapId() == mapId ? reporter->GetZoneId() : 0;
        finding.x = x;
        finding.y = y;
        finding.z = z;
        finding.firstSeen = now;
        it = _findings.emplace(key, finding).first;
    }

    BotFinding& finding = it->second;
    ++finding.hits;
    finding.lastSeen = now;
    finding.bot = reporter->GetName();
    if (!note.empty())
        finding.note = note.substr(0, MAX_NOTE);

    if (std::find(_dirty.begin(), _dirty.end(), key) == _dirty.end())
        _dirty.push_back(key);
}

void BotFindings::Update(uint32 diff)
{
    _flushTimer += diff;
    if (_flushTimer < FLUSH_INTERVAL)
        return;
    _flushTimer = 0;
    Flush();
}

void BotFindings::Flush()
{
    std::vector<BotFinding> rows;
    {
        std::lock_guard<std::mutex> guard(_lock);
        for (Key const& key : _dirty)
        {
            auto const it = _findings.find(key);
            if (it != _findings.end())
                rows.push_back(it->second);
        }
        _dirty.clear();
    }

    for (BotFinding const& row : rows)
    {
        std::string bot = row.bot;
        std::string note = row.note;
        CharacterDatabase.EscapeString(bot);
        CharacterDatabase.EscapeString(note);
        CharacterDatabase.PExecute(
            "REPLACE INTO playerbots_findings (id, type, subject, detail, map, zone, position_x, position_y, "
            "position_z, hits, first_seen, last_seen, bot, note) "
            "VALUES (%u, %u, %u, %u, %u, %u, %f, %f, %f, %u, %u, %u, '%s', '%s')",
            row.id, uint32(row.type), row.subject, row.detail, row.mapId, row.zoneId, row.x, row.y, row.z,
            row.hits, row.firstSeen, row.lastSeen, bot.c_str(), note.c_str());
    }
}

void BotFindings::GetList(std::vector<BotFinding>& out, BotFindingType type) const
{
    out.clear();
    {
        std::lock_guard<std::mutex> guard(_lock);
        for (auto const& kv : _findings)
            if (type == BotFindingType::None || kv.second.type == type)
                out.push_back(kv.second);
    }

    std::sort(out.begin(), out.end(), [](BotFinding const& a, BotFinding const& b)
    {
        if (a.hits != b.hits)
            return a.hits > b.hits;
        return a.id < b.id;
    });
}

bool BotFindings::Get(uint32 id, BotFinding& out) const
{
    std::lock_guard<std::mutex> guard(_lock);
    for (auto const& kv : _findings)
    {
        if (kv.second.id == id)
        {
            out = kv.second;
            return true;
        }
    }
    return false;
}

uint32 BotFindings::GetCount() const
{
    std::lock_guard<std::mutex> guard(_lock);
    return uint32(_findings.size());
}

uint32 BotFindings::Remove(uint32 id)
{
    uint32 removed = 0;
    {
        std::lock_guard<std::mutex> guard(_lock);
        if (!id)
        {
            removed = uint32(_findings.size());
            _findings.clear();
            _dirty.clear();
        }
        else
        {
            for (auto it = _findings.begin(); it != _findings.end(); ++it)
            {
                if (it->second.id != id)
                    continue;
                _dirty.erase(std::remove(_dirty.begin(), _dirty.end(), it->first), _dirty.end());
                _findings.erase(it);
                removed = 1;
                break;
            }
        }
    }

    if (!id)
        CharacterDatabase.Execute("DELETE FROM playerbots_findings");
    else if (removed)
        CharacterDatabase.PExecute("DELETE FROM playerbots_findings WHERE id = %u", id);
    return removed;
}

std::string BotFindings::Describe(BotFinding const& finding)
{
    TypeInfo const* info = FindTypeInfo(finding.type);
    std::ostringstream out;
    out << '#' << finding.id << " [" << (info ? info->name : "unknown") << "] ";

    if (info)
    {
        switch (info->subject)
        {
            case Subject::Quest:
            {
                out << "quest " << finding.subject;
                if (Quest const* quest = sObjectMgr->GetQuestTemplate(finding.subject))
                    out << " '" << quest->GetTitle() << '\'';
                break;
            }
            case Subject::Creature:
            {
                out << "creature " << finding.subject;
                std::string const name = EntryName(finding.subject);
                if (!name.empty())
                    out << " '" << name << '\'';
                break;
            }
            case Subject::Spell:
            {
                out << "spell " << finding.subject;
                if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(finding.subject))
                    if (spell->SpellName)
                        out << " '" << spell->SpellName << '\'';
                break;
            }
            case Subject::Map:
                out << "map " << finding.subject;
                break;
        }
        out << ": " << info->text;

        if (info->subject == Subject::Quest && finding.detail)
        {
            out << " (" << finding.detail;
            std::string const name = EntryName(finding.detail);
            if (!name.empty())
                out << " '" << name << '\'';
            out << ')';
        }
    }

    out << ", x" << finding.hits;
    std::string const area = AreaName(finding.zoneId);
    if (!area.empty())
        out << ", " << area;
    if (!finding.note.empty())
        out << " - " << finding.note;
    return out.str();
}
