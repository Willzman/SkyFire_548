/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

#include "BotSpawnIndex.h"
#include "Creature.h"
#include "DatabaseEnv.h"
#include "DBCStores.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "QuestDef.h"

#include <algorithm>
#include <set>
#include <sstream>

BotSpawnIndex* BotSpawnIndex::instance()
{
    static BotSpawnIndex inst;
    return &inst;
}

void BotSpawnIndex::LoadSpawns(char const* table, RowVec& rows)
{
    rows.clear();
    QueryResult result = WorldDatabase.PQuery("SELECT id, map, position_x, position_y, position_z FROM %s", table);
    if (!result)
        return;

    rows.reserve(size_t(result->GetRowCount()));
    do
    {
        Field* fields = result->Fetch();
        Row row;
        row.entry = fields[0].GetUInt32();
        row.spawn.mapId = fields[1].GetUInt16();
        row.spawn.x = fields[2].GetFloat();
        row.spawn.y = fields[3].GetFloat();
        row.spawn.z = fields[4].GetFloat();
        rows.push_back(row);
    } while (result->NextRow());

    std::stable_sort(rows.begin(), rows.end(), [](Row const& a, Row const& b) { return a.entry < b.entry; });
}

void BotSpawnIndex::LoadItemDroppers()
{
    _itemDroppers.clear();
    _itemContainers.clear();

    std::set<uint32> items;
    for (auto const& kv : sObjectMgr->GetQuestTemplates())
    {
        Quest const* quest = kv.second;
        if (!quest)
            continue;
        for (QuestObjective const* obj : quest->m_questObjectives)
            if (obj && obj->Type == QUEST_OBJECTIVE_TYPE_ITEM && obj->ObjectId)
                items.insert(obj->ObjectId);
    }

    // Direct drops only: reference loot is not followed.
    auto it = items.begin();
    while (it != items.end())
    {
        std::ostringstream ids;
        for (uint32 n = 0; n < 500 && it != items.end(); ++n, ++it)
        {
            if (n)
                ids << ',';
            ids << *it;
        }

        QueryResult result = WorldDatabase.PQuery(
            "SELECT ct.entry, clt.item FROM creature_loot_template clt "
            "JOIN creature_template ct ON ct.lootid = clt.entry "
            "WHERE clt.mincountOrRef > 0 AND clt.item IN (%s)", ids.str().c_str());
        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                _itemDroppers[fields[1].GetUInt32()].push_back(fields[0].GetUInt32());
            } while (result->NextRow());
        }

        // Chests (gameobject type 3) keep their loot id in data1.
        result = WorldDatabase.PQuery(
            "SELECT gt.entry, glt.item FROM gameobject_loot_template glt "
            "JOIN gameobject_template gt ON gt.type = 3 AND gt.data1 = glt.entry "
            "WHERE glt.mincountOrRef > 0 AND glt.item IN (%s)", ids.str().c_str());
        if (result)
        {
            do
            {
                Field* fields = result->Fetch();
                _itemContainers[fields[1].GetUInt32()].push_back(fields[0].GetUInt32());
            } while (result->NextRow());
        }
    }
}

void BotSpawnIndex::Load()
{
    _loaded = false;
    LoadSpawns("creature", _creatures);
    LoadSpawns("gameobject", _gameobjects);

    _creatureStarters.clear();
    _creatureStarterEntries.clear();
    _gameobjectStarters.clear();
    if (QuestRelations const* relations = sObjectMgr->GetCreatureQuestRelationMap())
        for (auto const& kv : *relations)
        {
            _creatureStarters[kv.second].push_back(kv.first);
            _creatureStarterEntries.push_back(kv.first);
        }
    std::sort(_creatureStarterEntries.begin(), _creatureStarterEntries.end());
    _creatureStarterEntries.erase(std::unique(_creatureStarterEntries.begin(), _creatureStarterEntries.end()),
        _creatureStarterEntries.end());
    if (QuestRelations const* relations = sObjectMgr->GetGOQuestRelationMap())
        for (auto const& kv : *relations)
            _gameobjectStarters[kv.second].push_back(kv.first);

    _killCreditSources.clear();
    if (CreatureTemplateContainer const* templates = sObjectMgr->GetCreatureTemplates())
        for (auto const& kv : *templates)
            for (uint32 credit : kv.second.KillCredit)
                if (credit && credit != kv.first)
                    _killCreditSources[credit].push_back(kv.first);

    LoadItemDroppers();
    _loaded = true;

    SF_LOG_INFO("modules",
        "[mod-playerbots] BotSpawnIndex: %u creature and %u gameobject spawns, quest items: %u dropped by creatures, %u held by chests.",
        uint32(_creatures.size()), uint32(_gameobjects.size()), uint32(_itemDroppers.size()),
        uint32(_itemContainers.size()));
}

bool BotSpawnIndex::HasSpawn(uint32 entry, bool gameobject) const
{
    RowVec const& rows = gameobject ? _gameobjects : _creatures;
    auto const it = std::lower_bound(rows.begin(), rows.end(), entry,
        [](Row const& row, uint32 value) { return row.entry < value; });
    return it != rows.end() && it->entry == entry;
}

bool BotSpawnIndex::FindNearest(uint32 entry, bool gameobject, uint32 mapId, float x, float y, float z,
    bool sameMapOnly, BotSpawn& out) const
{
    RowVec const& rows = gameobject ? _gameobjects : _creatures;
    auto it = std::lower_bound(rows.begin(), rows.end(), entry,
        [](Row const& row, uint32 value) { return row.entry < value; });

    bool found = false;
    bool foundSameMap = false;
    bool foundOpenWorld = false;
    float bestD2 = 0.0f;
    for (; it != rows.end() && it->entry == entry; ++it)
    {
        BotSpawn const& spawn = it->spawn;
        if (spawn.mapId != mapId)
        {
            // A spawn out in the world is worth more than one inside an instance.
            if (!sameMapOnly && !foundSameMap && (!found || !foundOpenWorld))
            {
                MapEntry const* map = sMapStore.LookupEntry(spawn.mapId);
                bool const openWorld = map && !map->Instanceable();
                if (!found || openWorld)
                {
                    out = spawn;
                    found = true;
                    foundOpenWorld = openWorld;
                }
            }
            continue;
        }

        float const dx = spawn.x - x;
        float const dy = spawn.y - y;
        float const dz = spawn.z - z;
        float const d2 = dx * dx + dy * dy + dz * dz;
        if (!foundSameMap || d2 < bestD2)
        {
            bestD2 = d2;
            out = spawn;
            found = true;
            foundSameMap = true;
        }
    }
    return found;
}

std::vector<uint32> const& BotSpawnIndex::Lookup(EntryMap const& map, uint32 key)
{
    static std::vector<uint32> const empty;
    auto const it = map.find(key);
    return it != map.end() ? it->second : empty;
}

std::vector<uint32> const& BotSpawnIndex::GetCreatureStarters(uint32 questId) const
{
    return Lookup(_creatureStarters, questId);
}

std::vector<uint32> const& BotSpawnIndex::GetGameObjectStarters(uint32 questId) const
{
    return Lookup(_gameobjectStarters, questId);
}

std::vector<uint32> const& BotSpawnIndex::GetItemDroppers(uint32 itemId) const
{
    return Lookup(_itemDroppers, itemId);
}

std::vector<uint32> const& BotSpawnIndex::GetKillCreditSources(uint32 objectiveEntry) const
{
    return Lookup(_killCreditSources, objectiveEntry);
}

std::vector<uint32> const& BotSpawnIndex::GetItemContainers(uint32 itemId) const
{
    return Lookup(_itemContainers, itemId);
}
