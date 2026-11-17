/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Playerbots module - in-memory index of world spawns and quest relations.
*
* Loaded once at startup on the world thread and read-only afterwards, so bot
* AI on map threads can look up where a quest objective, starter or ender
* stands without a database query.
*/

#ifndef _SF_BOT_SPAWN_INDEX_H
#define _SF_BOT_SPAWN_INDEX_H

#include "Define.h"
#include <unordered_map>
#include <vector>

struct BotSpawn
{
    uint32 mapId = 0;
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
};

class BotSpawnIndex
{
public:
    static BotSpawnIndex* instance();

    void Load();
    bool IsLoaded() const { return _loaded; }

    bool HasSpawn(uint32 entry, bool gameobject) const;

    // Nearest spawn of the entry. Same-map spawns always win; with
    // sameMapOnly = false a spawn on another map is returned when the entry
    // does not exist on mapId at all. False when there is no such spawn.
    bool FindNearest(uint32 entry, bool gameobject, uint32 mapId, float x, float y, float z,
        bool sameMapOnly, BotSpawn& out) const;

    // Creature / gameobject entries that start the quest (empty when none).
    std::vector<uint32> const& GetCreatureStarters(uint32 questId) const;
    std::vector<uint32> const& GetGameObjectStarters(uint32 questId) const;

    // Creature entries whose own loot table holds the quest objective item.
    std::vector<uint32> const& GetItemDroppers(uint32 itemId) const;

    // Chest gameobject entries whose own loot table holds the quest objective item.
    std::vector<uint32> const& GetItemContainers(uint32 itemId) const;

    // Creature entries that credit a kill objective through creature_template
    // KillCredit (the objective entry itself is not included).
    std::vector<uint32> const& GetKillCreditSources(uint32 objectiveEntry) const;

private:
    BotSpawnIndex() = default;

    struct Row
    {
        uint32 entry;
        BotSpawn spawn;
    };

    typedef std::vector<Row> RowVec;
    typedef std::unordered_map<uint32, std::vector<uint32>> EntryMap;

    static void LoadSpawns(char const* table, RowVec& rows);
    static std::vector<uint32> const& Lookup(EntryMap const& map, uint32 key);
    void LoadItemDroppers();

    bool _loaded = false;
    RowVec _creatures;    // sorted by entry
    RowVec _gameobjects;  // sorted by entry
    EntryMap _creatureStarters;
    EntryMap _gameobjectStarters;
    EntryMap _itemDroppers;
    EntryMap _itemContainers;
    EntryMap _killCreditSources;
};

#define sBotSpawnIndex BotSpawnIndex::instance()

#endif // _SF_BOT_SPAWN_INDEX_H
