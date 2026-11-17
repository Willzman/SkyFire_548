/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Playerbots module - play-tester findings.
*
* Bots record the server problems they run into while playing (quests that
* cannot be accepted or finished, objectives with no spawn, kills without
* credit, places they cannot path through, spells that never cast). Each
* problem is one row keyed by (type, subject, detail); meeting it again only
* raises its hit count. Rows live in the characters database table
* `playerbots_findings` and are listed in game with `.playerbots findings`.
*
* Record() is called from bot AI on map threads; everything else runs on the
* world thread.
*/

#ifndef _SF_BOT_FINDINGS_H
#define _SF_BOT_FINDINGS_H

#include "Define.h"
#include <map>
#include <mutex>
#include <string>
#include <tuple>
#include <vector>

class Player;

// Stored in the database: never renumber, only append.
enum class BotFindingType : uint8
{
    None                    = 0,
    QuestNoStarter          = 1,  // subject quest
    QuestStarterNoSpawn     = 2,  // subject quest, detail starter entry
    QuestStarterMissing     = 3,  // subject quest, detail starter entry (spawned in the DB, absent in the world)
    QuestAcceptFailed       = 4,  // subject quest
    QuestObjectiveNoSpawn   = 5,  // subject quest, detail objective creature/gameobject entry
    QuestKillNoCredit       = 6,  // subject quest, detail creature entry
    QuestStalled            = 7,  // subject quest, detail objective object id
    QuestNoEnder            = 8,  // subject quest
    QuestEnderNoSpawn       = 9,  // subject quest, detail ender entry
    QuestEnderMissing       = 10, // subject quest, detail ender entry
    QuestTurnInFailed       = 11, // subject quest
    QuestgiverNoQuests      = 12, // subject creature entry
    PathFailed              = 13, // subject map, detail position cell
    Stuck                   = 14, // subject map, detail position cell
    BadPosition             = 15, // subject map, detail position cell
    SpellNeverCasts         = 16, // subject spell, detail specialization
    QuestInteractNoCredit   = 17, // subject quest, detail object or NPC entry
    Max
};

struct BotFinding
{
    uint32 id = 0;
    BotFindingType type = BotFindingType::None;
    uint32 subject = 0;
    uint32 detail = 0;
    uint32 mapId = 0;
    uint32 zoneId = 0;
    float x = 0.0f;
    float y = 0.0f;
    float z = 0.0f;
    uint32 hits = 0;
    uint32 firstSeen = 0;
    uint32 lastSeen = 0;
    std::string bot;
    std::string note;
};

class BotFindings
{
public:
    static BotFindings* instance();

    // Creates the table when missing and loads the stored rows.
    void Load();
    void SetEnabled(bool enabled) { _enabled = enabled; }
    bool IsEnabled() const { return _enabled; }

    // Thread-safe. The reporter's position and name are stored with a new
    // finding; a repeat only counts.
    void Record(BotFindingType type, uint32 subject, uint32 detail, Player const* reporter,
        std::string const& note = std::string());

    // Position-keyed findings (PathFailed / Stuck / BadPosition): one row per
    // 50-yard cell of a map.
    // 50-yard cell of a map. mapId < 0 = the reporter's map.
    void RecordAt(BotFindingType type, Player const* reporter, float x, float y, float z,
        std::string const& note = std::string(), int32 mapId = -1);

    // World thread: writes changed rows every FLUSH_INTERVAL.
    void Update(uint32 diff);
    void Flush();

    // Copies for the GM commands, most hits first. type None = every type.
    void GetList(std::vector<BotFinding>& out, BotFindingType type = BotFindingType::None) const;
    bool Get(uint32 id, BotFinding& out) const;
    uint32 GetCount() const;
    // id 0 removes everything. Returns the rows removed.
    uint32 Remove(uint32 id);

    static char const* TypeName(BotFindingType type);
    // None when the name is not a type.
    static BotFindingType TypeFromName(std::string const& name);
    // One chat line: what is wrong, with quest / creature / spell names resolved.
    static std::string Describe(BotFinding const& finding);

private:
    BotFindings() = default;

    typedef std::tuple<uint8, uint32, uint32> Key;

    void RecordInternal(BotFindingType type, uint32 subject, uint32 detail, Player const* reporter,
        uint32 mapId, float x, float y, float z, std::string const& note);

    bool _enabled = true;
    uint32 _flushTimer = 0;
    uint32 _nextId = 1;
    mutable std::mutex _lock;
    std::map<Key, BotFinding> _findings;
    std::vector<Key> _dirty;
};

#define sBotFindings BotFindings::instance()

#endif // _SF_BOT_FINDINGS_H
