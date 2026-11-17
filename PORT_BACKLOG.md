# Port backlog

What is left to bring over from the AzerothCore playerbots module, in the order
it is worth doing for play-testing a SkyFire 5.4.8 server. `PORTING.md` records
what is done; this file is the to-do list and the notes a new session needs to
pick an item up.

## Before porting anything else

The play-tester, object-objective and battleground commits compile against the
core but have **never run on a live server**, and only the first of them had an
independent review. Exercise them on the dev realm first and fix what turns up:

1. `.playerbots test quest <id>` on a few plain kill, collect, use-object and
   talk-to quests; then `.playerbots test zone` in a starter zone.
2. Leave `Playerbots.Tester.ActiveBots` bots running for an hour and read
   `.playerbots findings`. Expect false positives to tune (see "Known soft
   spots").
3. `Playerbots.RandomBotJoinBG = 1`, queue a battleground, check that bots
   enter on both sides, fight, respawn, and leave when it ends.
4. `Playerbots.RandomBotJoinArena = 1`, queue a 2v2 with a bot partner.

## How to work on this repo

* **Reference**: the AC module is `willzman/mod-ac-playerbots` (paths below are
  under its `src/`, as of commit `ecc4a53`). It is WotLK 3.3.5a on a different
  core, so behaviour ports and code mostly does not. Mirror SkyFire's own
  opcode handlers (`src/server/game/Handlers/`) instead of AC's packet code.
  Code that is copied keeps the GPL notice and gets a `Co-authored-by:` trailer
  per original author.
* **Core**: `willzman/skyfire_548`, branch `Development`. The module is dropped
  in as `modules/mod-playerbots`. No core change has been needed since the
  Phase 1 hooks; prefer keeping it that way.
* **Compile check** (no database needed): symlink this repo to
  `modules/mod-playerbots` in a SkyFire checkout, configure with GCC 14 and
  Boost 1.91 headers, `ninja modules`. The core's CMake wants OpenSSL 4.0;
  for a compile-only check `-D_OPENSSL_VERSION=4.0.0` gets past the version
  test with the system OpenSSL. Remove the symlink afterwards (it is untracked
  in the core repo).
* **Unit tests**: `python3 tests/test_*.py`. They extract one function from the
  real source and compile it against stubs; add one when a piece of pure logic
  is worth pinning down.
* **Threading**: bot AI (`PlayerbotAI::UpdateAI` and everything under it) runs
  on map-update threads, several maps at once. `PlayerbotMgr::Update`,
  `BotTestMgr`, `BotBattlegrounds`, `BotFindings::Update` and GM commands run on
  the world thread, never at the same time as map updates. So:
  * no database queries from AI code: use `BotSpawnIndex` (loaded at startup);
  * anything shared that AI code writes needs a lock (`BotFindings::Record`,
    `BotTestMgr::Report`);
  * map changes, LFG, battleground queues and group creation go through the
    world thread (`ProcessPendingTeleport`, `HandleLfg`, `BotBattlegrounds`).
* **Where things live**:
  * `src/PlayerbotAI.cpp`: the main loop, combat, movement, vendors, loot.
  * `src/PlayerbotAITester.cpp`: findings, quest travel, directed quest tests.
  * `src/PlayerbotAIQuestObjects.cpp`: use-object, chest and talk-to objectives.
  * `src/PlayerbotAIBattleground.cpp` / `src/BotBattlegrounds.cpp`: in-match
    behaviour / queues.
  * `src/BotFindings.*`, `src/BotTestMgr.*`, `src/BotSpawnIndex.*`.
* A new kind of problem bots can detect is a new `BotFindingType`: append to the
  enum (the numbers are stored in the database), add a row to `typeInfos` in
  `BotFindings.cpp`, and to the tables in `COMMANDS.md` and
  `sql/characters/playerbots_findings.sql`.

## Backlog, most useful first

### 1. Area triggers and usable quest items

* **Why**: most quests a directed test still reports as SKIPPED need an area
  explored or a quest item clicked.
* **AC**: `Ai/Base/Actions/AreaTriggerAction.*`, `UseItemAction.*`.
* **Here**: `DescribeOpenObjective` in `PlayerbotAITester.cpp` marks objective
  types unsupported; `CollectQuestInteractTargets` in
  `PlayerbotAIQuestObjects.cpp` is where new target kinds go.
* **Notes**: explore objectives are `QUEST_SPECIAL_FLAGS_EXPLORATION_OR_EVENT`
  plus `areatrigger_involvedrelation`; the trigger positions are in
  `AreaTrigger.dbc` (index them like spawns). Item use: the quest's source item
  or an item objective with a `spellid_1`; find the target from the spell's
  conditions / `conditions` table, then cast through the normal item-use path.

### 2. Battleground objectives

* **Why**: bots only fight the nearest enemy today, so matches that are won by
  objectives run to their timer and the scoring code is never exercised.
* **AC**: `Ai/Base/Actions/BattleGroundTactics.*` (very large: per-map waypoint
  paths and objective logic), `Ai/Base/Strategy/BattlegroundStrategy.*`.
* **Here**: `PlayerbotAI::HandleBattleground` in `PlayerbotAIBattleground.cpp`.
* **Notes**: Warsong Gulch, Arathi Basin, Eye of the Storm, Alterac Valley,
  Strand of the Ancients and Isle of Conquest exist in both versions, so their
  tactics and paths are the port. Twin Peaks, Battle for Gilneas, Temple of
  Kotmogu, Silvershard Mines and Deepwind Gorge need new ones. Start with
  Warsong (flag pick-up, carry, return, capture). Do not read the
  `Battleground` object's player list from AI code (world-thread data); use
  the map's own player list as `SelectPvpTarget` does.

### 3. Gameobjects that credit through a cast or a lock

* **Why**: `UseQuestObject` calls `GameObject::Use` directly. Objects that only
  give credit through the client's opening cast show up as false
  `interact-no-credit` findings.
* **AC**: `Ai/Base/Actions/LootAction.*` (`OpenLootAction` casts the opening
  spell for the lock type).
* **Here**: `PlayerbotAI::UseQuestObject`.

### 4. Quest choice rules

* **Why**: bots take every quest a giver offers. Dropping grey quests and ones
  they cannot do keeps them moving through a zone and raises coverage.
* **AC**: `Ai/World/Rpg/NewRpgHelpers.*` (`IsQuestWorthDoing`,
  `IsQuestCapableDoing`), `Ai/World/Rpg/QuestLevelRules.h`,
  `NewRpgBaseAction::OrganizeQuestLog`, `Ai/Base/Actions/DropQuestAction.*`.
* **Here**: `PlayerbotAI::HandleQuestNpcs`, `QuestgiverHasUsefulWork`.

### 5. Flight paths

* **AC**: `Ai/Base/Actions/TaxiAction.*`, `RememberTaxiAction.*`, the taxi
  routing in `Mgr/Travel/TravelMgr.cpp`, `NewRpgBaseAction::SelectRandomFlightTaxiNode`.
* **Here**: `PlayerbotAI::TravelToSpawn` teleports beyond
  `Playerbots.Quest.TeleportDistance`; taking a flight is the alternative when
  both ends have a known node. Tests flight masters and taxi paths.

### 6. Gathering and fishing

* **AC**: `Mgr/GatherNode/GatherNodeMgr.*`, `Ai/World/Rpg/Action/NewRpgDoGather.*`,
  `Ai/Base/Actions/FishingAction.*`.
* **Notes**: tests herb, ore and fishing node spawns, skill-ups and their loot.
  Node spawns can be indexed in `BotSpawnIndex` like chests.

### 7. Mail, bank, vendor buying

* **AC**: `Ai/Base/Actions/MailAction.*`, `CheckMailAction.*`, `BankAction.*`,
  `BuyAction.*`.
* **Here**: vendor selling and repair already exist (`HandleVendor`); these are
  the same shape.

### 8. Guilds

* **AC**: `Mgr/Guild/PlayerbotGuildMgr.*`, `GuildTaskMgr.*`,
  `Ai/Base/Actions/Guild*Action*`.
* **Notes**: MoP adds guild levels, perks and challenges on top.

### 9. Dungeon and raid encounters

* **AC**: `Ai/Dungeon/<name>/` and `Ai/Raid/<name>/` (triggers, actions and
  multipliers per boss). All Classic to WotLK content.
* **Notes**: port the framework (a per-instance strategy with boss triggers and
  "move out", "spread", "tank swap" actions), then write MoP encounters one at
  a time. This, plus a bot that can lead through a dungeon, is what lets a bot
  party clear content without a human.

### 10. Best-in-slot gear lists

* **AC**: `Mgr/Item/BisListMgr.*`. The mechanism ports; the lists are WotLK
  items and would be rebuilt for 5.4.8. `autogear bis` is the missing command.

### Not in AC (build, not port)

* Raid finder fill: extend `PlayerbotMgr::UpdateLfgAutoJoin` (it already joins
  whatever dungeon set the real player picked; check `MaxBots` against a
  25-player raid and the LFR role counts).
* Rated battlegrounds, scenarios, challenge modes, pet battles.

### Low value for testing

Emotes, chat replies, outfits, duel behaviour, RTSC. Port only if wanted for
feel.

## Known soft spots in what is already there

Things to watch on the first live run, most likely first:

* `objective-no-spawn` fires for creatures summoned by scripts or events (they
  are not in the `creature` table). Likely needs an allow-list or a check
  against `creature_summon_groups` / SmartAI summons.
* `interact-no-credit` on objects that need a cast (backlog item 3) and on NPCs
  whose credit is behind a later gossip option (only the first plain option is
  picked in `TalkToQuestNpc`).
* `spell-never-casts` cannot say why a cast failed; 8 failures within 30 s of
  each other without one success may still be range or line of sight.
* Quest travel teleports ignore who is watching; a real player may see a bot
  vanish. `Playerbots.Quest.TeleportDistance = 0` turns it off.
* Arena fill needs bot accounts to hold `RBAC_PERM_JOIN_ARENAS`; without it no
  opposing team forms and nothing is logged.
* Bots in a battleground leave three minutes in if no real player is inside
  (`EMPTY_BG_GRACE_MS`), and have the deserter aura removed.
* Directed test results are in memory only; failures persist as findings.
