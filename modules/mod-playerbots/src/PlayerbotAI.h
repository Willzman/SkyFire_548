/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Playerbots module - per-bot AI controller.
*
* Phase 3 (foundation): one PlayerbotAI instance drives one bot Player, ticked
* from PlayerScript::OnUpdate. Chat orders (whisper / party / raid) set
* movement and combat modes; combat and follow build on top of those.
* Self-bots keep client movement and only run cast-only combat, unless
* `nc +walk` / `co +walk` is on. Walk takes the keys to loot, to reach the
* right target (tanks peel), and to leave bad ground, then gives them back
* while the bot is idle.
*
* Strategies (AC-style co/nc) are role-gated: tanks never take healer flags,
* healers never take tank flags, etc. Class rotations still run underneath.
*
* Decision loop: BotAiEngine (Trigger → Queue → Multiplier → Action). Spell
* selection stays in rotations/; the engine picks combat/rest/follow/stay/loot.
*/

#ifndef _SF_PLAYERBOT_AI_H
#define _SF_PLAYERBOT_AI_H

#include "engine/BotStrategyEngine.h"
#include "engine/BotTargetValues.h"
#include "BotSpawnIndex.h"
#include "Define.h"
#include <memory>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

class Object;
class Player;
class Unit;
class Creature;
class GameObject;
class BotAiEngine;
class SpellInfo;
class Item;
struct ItemTemplate;
class Quest;
struct MountCapabilityEntry;
enum class BotTestOutcome : uint8;

class PlayerbotAI
{
public:
    // clientControlled: real player keeps WASD; AI only casts (self-bot mode),
    // unless walk is enabled (see IsSelfWalkEnabled).
    explicit PlayerbotAI(Player* bot, bool clientControlled = false);
    ~PlayerbotAI();

    void UpdateAI(uint32 diff);

    // Process a chat order from a real player (whisper or party/raid). Returns
    // true if the text was a recognized command (even if it had no effect).
    // When acknowledge is true the bot whispers a short confirmation back.
    bool HandleChatCommand(Player* from, std::string const& text, bool acknowledge = true);

    // Role filter for "@tank attack" style group orders (tank/heal/dps/ranged).
    bool MatchesRoleFilter(std::string const& filter) const;
    void SetHoldAssist(bool hold) { _holdAssist = hold; }
    bool IsHoldAssist() const { return _holdAssist; }

    // LFG role mask (tank/healer/damage) from the bot's active specialization.
    uint8 ComputeLfgRole();

    // Auto-respond to LFG role checks and proposals. Must run on the world
    // thread (PlayerbotMgr::Update) — UpdateProposal creates groups/teleports
    // and is not safe from Map::Update worker threads.
    void HandleLfg();

    // Dormant bots skip Player::Update, so party invites are accepted here
    // from PlayerbotMgr::Update on the world thread.
    void AcceptPendingInvite() { HandlePendingInvites(); }

    Player* GetBot() const { return _bot; }
    // Relog creates a new Player with the same GUID; keep _bot on the live object.
    void Rebind(Player* bot) { _bot = bot; }
    bool IsClientControlled() const { return _clientControlled; }
    // Self-bot `nc +walk` / `co +walk`: one switch (either prefix sets both).
    // The bot walks to loot, to its target, and out of ground hazards, and
    // releases the character whenever it is not doing that.
    bool IsSelfWalkEnabled() const { return _walk; }
    // True while the server currently owns this character's movement.
    bool IsSelfWalkDriving() const { return _selfWalkDriving; }
    // A movement helper is about to path this character. Takes client control
    // when walk is on. No-op for socket bots and when walk is off.
    void ClaimSelfMovement();
    // Give WASD back and stop any spline the bot started.
    void ReleaseSelfMovement();

    // Copy a real player's MoP phase-id set onto this bot and refresh that
    // player's client visibility of the bot (needed when not in a group).
    void SyncPhaseWithMaster(Unit* master);

    // Revive if dead, then warp to the player. Used by summon orders and .playerbots summon.
    bool TeleportToPlayer(Player* master);

    // Re-apply role-default strategies (after init/spec change).
    void ResetStrategiesToRoleDefaults();
    // Re-check which gear set to wear on the next tick (after a re-gear).
    void ResetGearSet() { _gearSetPvp = -1; }
    // The master accepted / turned in a quest: the bot does the same when it
    // can, and whispers the master why when it cannot.
    void MirrorQuestAccept(Player* master, Quest const* quest);
    void MirrorQuestReward(Player* master, Quest const* quest, Object* questGiver);
    bool QuestRewardsFit(Quest const* quest, uint32 rewardItem) const;
    // Skip a spell that just failed to cast so the rotation moves on to its next pick.
    void BackOffSpell(uint32 spellId);
    bool IsSpellBackedOff(uint32 spellId) const;
    // Successful rotation casts, so a debuff the bot cannot see on the target is not recast every GCD.
    void NoteSpellCast(uint32 spellId, uint64 targetGuid);
    bool CastOnRecently(uint32 spellId, uint64 targetGuid, uint32 withinMs) const;
    // After teleport/init: clear stale pathing and restore open-world activity
    // for ungrouped random bots (ResetStrategies alone leaves them on follow).
    void AfterInitRelocate(bool didTeleport);
    // Sync procedural flags after ChangeStrategy from outside the AI.
    void SyncFlagsFromStrategies();

    BotStrategyEngine& GetStrategyEngine() { return _strategies; }
    BotStrategyEngine const& GetStrategyEngine() const { return _strategies; }
    bool HasStrategy(std::string const& name, BotState state) const { return _strategies.Has(name, state); }

    bool IsAoeEnabled() const { return _aoe; }
    bool IsBoostEnabled() const { return _boost; }
    bool IsCcEnabled() const { return _cc; }
    bool IsAvoidAoeEnabled() const { return _avoidAoe; }
    bool IsCombatDebug() const { return _debugCombat; }
    void DebugCombat(std::string const& action);
    // File log (no chat dedup) — use with `debug` while diagnosing hunter rotation.
    void HunterDebugLog(std::string const& line);
    std::string BuildHunterStateSnapshot(Unit* target) const;
    std::string const& GetHunterDebugLogPath() const { return _hunterDebugLogPath; }

    // --- Public hooks for BotAiEngine / Values / Formation ---
    bool RunCombat();
    bool RunCombatCastOnly();
    bool RunRest();
    bool RunHeal();
    void RunFollow();
    void RunStay();
    bool RunLoot();
    void RunWander();
    void RunVendor();
    bool RunTravel();
    bool NeedsVendorWorkPublic() const;
    bool NeedsUrgentVendorPublic() const;
    bool HasQuestsStrategyPublic() const { return _quests; }
    // Grind or auto-quest: allow OOC combat ticks to pull (needed when mobs
    // will not aggro a high-level bot in a starter zone).
    // In a battleground or arena the bot goes for enemy players the same way.
    bool WantsOpenWorldPullsPublic() const { return _grind || _quests || IsInPvpMap(); }
    bool IsInPvpMap() const;
    bool IsGroupInCombatPublic() const;
    bool ShouldFollowPublic() const;
    bool NeedsRestPublic() const;
    // nc +heal: party member below OOC heal threshold while out of combat.
    bool NeedsOocHealPublic() const;
    bool IsForceResting() const { return _forceRest || _resting; }
    // Used by questgiver grid search — skip empty/bugged QUESTGIVER NPCs.
    bool QuestgiverHasUsefulWork(Creature const* npc) const;
    bool IsQuestNpcIgnored(uint32 entry) const;
    void IgnoreQuestNpc(uint32 entry, uint32 durationMs = 0);
    void RebuildAiEngine();

    // Same-map destination travel (chat go / position).
    bool HasTravelDestination() const { return _travel.active; }
    bool SetTravelDestination(uint32 mapId, float x, float y, float z);
    void ClearTravelDestination();
    bool IsTravelArrived(float tol = 3.0f) const;

    // .playerbots state: what the bot did on its last AI tick and why it may be idle.
    std::string DescribeState() const;

    Unit* SelectLowestHpGroupEnemyPublic();
    Unit* SelectAssistTankTargetPublic();
    Unit* SelectTankTargetPublic();
    // 0=tank, 1=healer, 2=damage
    int GetCombatRolePublic() const;
    bool IsRangedClassPublic() const;
    bool ShouldWaitForAttack() const;
    // True when attack / tank attack / pull target is set — engage even while OOC.
    bool HasEngageTarget() const;
    bool HasNearbyLootPublic() const;
    // Safe wrapper: never call IsValidAttackTarget when either side lacks a map
    // (GetMap() asserts) — e.g. mid-teleport bots or stale selected units.
    bool IsSafeAttackTarget(Unit const* target) const;
    BotTargetValues& GetTargetValues() { return _targets; }
    BotTargetValues const& GetTargetValues() const { return _targets; }

    // Equips bag items that beat the worn ones (the Need rule); names of what was equipped.
    uint32 EquipBagUpgrades(std::vector<std::string>* equipped = nullptr);
    // A new item reached the bags (loot, roll won, quest reward): check for upgrades soon.
    void QueueEquipUpgrades() { _equipUpgradesPending = true; }

    // --- Play-tester (PlayerbotAITester.cpp) ---
    // A kill that should have advanced a quest objective and did not is a finding.
    void NoteCreatureKill(Creature* killed);
    // Rotation cast outcome. A spell that is picked again and again and never starts is a finding.
    void NoteSpellResult(uint32 spellId, bool started);
    // Accept / turn in the way the client opcode handlers do. False when the quest
    // log did not change as it should have.
    bool AcceptQuest(Quest const* quest, Object* giver);
    bool TurnInQuest(Quest const* quest, Object* giver);
    // Given up on by this bot (stalled or failed a test): not picked up again this session.
    bool IsQuestAbandoned(uint32 questId) const { return _abandonedQuests.count(questId) != 0; }

    // Directed test: play one quest from its starter to the turn-in and report the
    // outcome to BotTestMgr. World thread. prepare lets a random bot be leveled
    // for the quest. False with *error when this bot cannot run it.
    bool StartQuestTest(uint32 questId, uint64 requesterGuid, bool prepare, std::string* error);
    // Drops a running test without a result.
    void CancelQuestTest();
    // World thread: carries out a teleport TravelToSpawn asked for.
    void ProcessPendingTeleport();
    bool IsQuestTesting() const { return _test.questId != 0; }
    uint32 GetTestQuestId() const { return _test.questId; }
    char const* GetTestStepName() const;

private:
    // Coarse combat role used by filters and strategy gating.
    enum class CombatRole { Tank, Healer, Damage };

    struct TravelPoint
    {
        uint32 mapId = 0;
        float x = 0.0f;
        float y = 0.0f;
        float z = 0.0f;
    };

    struct TravelDest : TravelPoint
    {
        bool active = false;
    };

    // Behaviour steps.
    void HandlePendingInvites();
    // Slow activity: invite, finish a drink, teleport to a real leader. No wander.
    void HandleSlowActivity();
    // On join: follow pack (-quests/-grind). On leave (random bots): restore +quests/+grind.
    void SyncPartyStrategies();
    void HandleInteractions();
    bool HandleCombat();
    bool HandleCombatCastOnly();
    // belowPct: only heal allies under this HP% (90 combat healer, 30 offheal, etc).
    bool HandleHealing(float belowPct = 90.0f);
    bool TryAcceptResurrect();
    bool HandleResurrect();
    bool HandleRest();
    bool HandleLoot();
    void HandleFollow();
    void HandleWander();
    void HandleStay();
    void HandleVendor();
    bool HandleQuestNpcs();
    bool HandleAutoQuesting();
    bool TryGossipForVendorOrQuest(Creature* npc, bool wantVendor, bool wantQuest);
    bool SelectGossipOption(Creature* npc, uint32 gossipListId);
    // The reward choice to take, as its item id (what RewardQuest expects), 0 when none.
    uint32 BestRewardItem(Quest const* quest) const;
    bool TravelToVendorHub(bool preferRepair);
    bool TravelToQuestObjective();
    bool TravelToNearbyQuestgiver();
    uint32 CountFreeBagSlots() const;
    bool ShouldVendorDumpItem(Item* item) const;
    bool HasVendorJunk() const;
    uint32 SellVendorJunk(Creature* vendor);
    enum class BotMountKind : uint8 { None = 0, Ground, SwiftGround, Flying, SwiftFlying };
    static BotMountKind ClassifyMountSpell(SpellInfo const* info);
    static BotMountKind ClassifyUnitMount(Unit const* unit);
    static bool MountSpellCanFly(SpellInfo const* info);
    static float GetMountSpellSpeedBonus(SpellInfo const* info);
    static bool MountCapabilityIsFlight(MountCapabilityEntry const* cap);
    static MountCapabilityEntry const* FindBotMountCapability(Player const* bot, uint32 mountType, bool preferFlight);
    uint32 FindMountSpell(BotMountKind preferred) const;
    bool TryMount(BotMountKind preferred = BotMountKind::None);
    void TryDismount();
    void SyncMountWithMaster();
    // MoP visibility uses phase-id sets. FinalizeBotTeleport → UpdateAreaPhase
    // applies the bot's own quest conditions and can desync from nearby players
    // (visible only with .gm on / in a group). Re-align to a nearby real player.
    void EnsureVisiblePhases();
    // True when master is clearly above terrain (not skimming ground on a flyer).
    static bool IsMasterAirborne(Unit const* master);
    void ClampBotToGround();
    // True flight state for clients: CAN_FLY + DISABLE_GRAVITY + FLYING (+ move update).
    bool EnsureFlightMountCapability();
    // Ground SpeedModSpell for the current mount (flyer on the ground included).
    bool EnsureGroundMountCapability();
    void SetBotFlyingMovement(bool enable);
    void TeleportToLeader(Player* leader);
    void StopResting();
    bool StartRefreshment();
    bool HasFoodOrDrinkAura() const;
    static bool MemberHasFoodOrDrinkAura(Player const* player);
    bool CastRefreshmentSpell();
    void ApplyDirectRestRegen();
    void CancelRestConsumables();
    bool PartyNeedsRest() const;
    bool PartyNotAlmostReady() const;
    // True when the group leader is parked nearby — safe to drink / hold for allies.
    // False while the master is moving or far ahead (keep following; no convoy stutter).
    bool IsMasterWaitingForRest() const;
    bool HandleLootRolls();
    static bool IsLootUpgrade(Player* bot, ItemTemplate const* proto);

    // AC-style co / nc strategy engine (role-gated).
    bool HandleStrategyCommand(Player* from, std::string const& cmd, bool acknowledge);
    std::string FormatStrategies(bool combat) const;
    bool StrategyAllowed(bool combat, std::string const& name) const;

    // Combat helpers.
    Unit* SelectTarget();
    Unit* SelectGrindTarget();
    Unit* SelectQuestObjectiveTarget();
    Unit* SelectTankTarget();
    Unit* SelectGroupThreatTarget();
    Unit* SelectUntankedBoss();
    bool IsUntankedBoss(Unit const* unit) const;
    bool AvoidedMovingHazardRecently() const;
    Unit* SelectAssistTankTarget();
    Unit* SelectLowestHpGroupEnemy();
    Player* SelectHealTarget(float belowPct = 90.0f);
    Unit* GetForcedTarget() const;
    void SetForcedTarget(Unit* target);
    void ClearForcedTarget();
    CombatRole GetCombatRole() const;
    bool IsRangedClass() const;
    // Mage / Warlock / Elemental / Balance / Priest: cast only — never weapon swing.
    bool IsPureCaster() const;
    // Healer dps that fights in melee: mistweaver, holy paladin, resto catweave.
    bool IsMeleeHealerDps() const;
    // Hunter ranged Auto Shot (spell 75), not melee Attack().
    bool IsHunterRanged() const;
    bool GroupInCombat() const;
    // True when this hostile is currently beating on a non-tank group ally.
    bool IsUrgentTankPeel(Unit* target) const;
    int ScoreTankPeelMember(Player* member) const;
    float HealthPct() const;
    float ManaPct() const;
    bool UsesMana() const;
    bool ShouldThrottleThreat(Unit* target) const;
    uint32 GetFillerSpell() const;
    uint32 GetTauntSpell() const;
    uint32 GetAoeThreatSpell() const;
    uint32 GetPullOpenerSpell(Unit* target) const;
    float GetPullOpenerRange(Unit* target) const;
    // Warrior: Charge (or Leap) first; Heroic Throw only when Charge cannot fire.
    // Returns true if a gap-closer was cast this tick (do not cast Throw afterward).
    bool TryWarriorGapClose(Unit* target);
    // Off-GCD taunt when focus is on someone else. Safe to call after Charge.
    bool TryTankTaunt(Unit* target);
    // After Charge/Leap into a pack, queue one Thunder Clap (or class pack AoE).
    void ArmPullPackAoeIfNeeded(Unit* target);
    bool TryConsumePullPackAoe(Unit* target);
    uint32 GetPullPackAoeSpell() const;
    uint32 CountEnemiesNear(Unit* center, float range) const;
    bool HandlePullSequence();
    void BeginPullSequence(Unit* target);
    void EndPullSequence(bool keepForcedTarget);
    bool TryCombatFlee(Unit* focus);
    // Dungeon + tank: maintain cast range. Solo/open-world: stand ground above 30% HP.
    bool WantsRangedKiting() const;
    bool TryAvoidAoe();
    bool TryAutoMarkRti();
    // Healer/ranged: stand at cast range from focus — never master formation in combat.
    void HoldRangedCombatPosition(Unit* focus, float maxRange);
    Unit* SelectHealerCombatAnchor();
    bool CanOffHealClass() const;
    uint32 GetHealSpell() const;
    void DoRotation(Unit* target);
    // Hunters: arm Auto Shot (75) once; core keeps it firing.
    void StartHunterAutoShot(Unit* target);
    void StopHunterAutoShot();
    // Returns true if this call spent the GCD (caller should skip DoRotation).
    bool DoTankExtras(Unit* target, bool closing = false);

    void ReplyTo(Player* from, std::string const& text);
    // Whisper class/spec combat spells the bot actually knows (debug / verify init).
    void ReportClassSpells(Player* from);
    bool BeginTravelTo(float x, float y, float z, Player* from, bool acknowledge);
    bool HandleGoCommand(Player* from, std::string const& args, bool acknowledge);
    bool HandlePositionCommand(Player* from, std::string const& args, bool acknowledge);
    // AC `autogear [reset] [match|<quality>|<item level>]`.
    bool HandleAutoGearCommand(Player* from, std::string const& args, bool acknowledge);
    // AC `quests all|completed|incompleted|summary`: whispers the quest log.
    // False for any other argument (bare `quests` is accept / turn in).
    bool HandleQuestListCommand(Player* from, std::string const& args);

    Creature* FindNearbyLoot();
    Creature* FindNearbyRepairer();
    Creature* FindNearbyVendor();
    Creature* FindNearbyQuestgiver();
    bool NeedsRepair() const;
    bool HasGrayJunk() const;
    uint32 SellGrayJunk(Creature* vendor);
    void MoveToPosition(float x, float y, float z);
    // Socket bots always. Self-bots only while +walk is on.
    bool BotMayMove() const { return !_clientControlled || _walk; }
    // Self-bot +walk, and the player currently has the keys (bot is not pathing).
    bool PlayerKeepsMove() const { return _clientControlled && _walk && !_selfWalkDriving; }
    // After a decision tick: keep control if a path is still running, else release.
    void FinishSelfWalkTick();
    bool SelfWalkMotionActive() const;

    Player* _bot;
    bool _clientControlled;
    uint32 _updateTimer;

    uint64 _chaseGuid;
    // Hunter Auto Shot: GUID we already armed; do not re-cast every tick.
    uint64 _autoShotGuid;
    // Last combat-debug line (avoid spamming the same "Casting: X" every tick).
    std::string _debugLastAction;
    uint32 _debugLastMs;
    std::string _hunterDebugLogPath;
    uint32 _hunterDebugSeq = 0;
    uint64 _followGuid;
    uint64 _lootGuid;
    uint32 _wanderTimer;
    uint32 _strandedCheckTimer = 0;
    // Gear set fully swapped in: 1 PvP, 0 PvE, -1 not settled yet.
    int8 _gearSetPvp = -1;
    // Automatic bag upgrades: requested by a new item, else every Playerbots.AutoEquip.Interval.
    bool _equipUpgradesPending = true;
    uint32 _equipUpgradesTimer = 0;
    // spellId -> getMSTime() until which the rotation skips it.
    std::unordered_map<uint32, uint32> _spellBackoff;
    // spellId -> (target GUID, getMSTime() of the cast).
    std::unordered_map<uint32, std::pair<uint64, uint32>> _lastSpellCast;
    // Corpses skipped after a full-bag loot attempt (still open once for rolls).
    std::unordered_set<uint64> _lootBagFullSkip;
    // Corpses we already opened so group rolls could start.
    std::unordered_set<uint64> _lootRollOpened;

    BotStrategyEngine _strategies;
    std::unique_ptr<BotAiEngine> _aiEngine;
    BotTargetValues _targets;
    time_t _combatStartTime = 0;
    time_t _lastCombatFlee = 0;
    // Last avoid-aoe sidestep. The next dodge will not reverse straight back into the hazard.
    float _lastAvoidAngle = 0.0f;
    uint32 _lastAvoidMs = 0;
    bool _lastAvoidMoving = false;
    time_t _pullStartTime = 0;
    enum class PullPhase : uint8 { None, Reach, Opener };
    PullPhase _pullPhase = PullPhase::None;
    // Set when Charge/Leap into 2+ mobs; cleared after one pack AoE (e.g. Thunder Clap).
    bool _pendingPullAoe = false;

    TravelDest _travel;
    // Step of UpdateAI that ended the last tick, and the tick count so far.
    std::string _lastStep = "none";
    uint32 _ticks = 0;
    uint8 _travelFailCount = 0;
    std::unordered_map<std::string, TravelPoint> _savedPositions;
    bool _forceVendor = false;
    bool _forceSellAll = false;
    bool _forceQuest = false;
    // creature_template.entry → getMSTime() expiry for empty/bugged questgivers.
    std::unordered_map<uint32, uint32> _ignoredQuestNpcEntries;

    // --- Flags synced from _strategies (procedural AI still reads these) ---
    bool _stay;          // nc stay (implies not follow)
    bool _food;          // nc food
    bool _loot;          // nc loot
    bool _quests;        // nc quests (open-world auto-quest)

    bool _passive;       // co/nc passive
    bool _grind;         // co/nc grind

    bool _tankMode;      // tank role: peel + hold threat (off = play as DPS)
    bool _tankAssist;    // tank role: peel allies
    bool _dpsMode;       // damage role marker / tank-as-dps
    bool _dpsAssist;     // damage: assist party (AC dps assist)
    bool _threat;        // damage: throttle when high on threat
    bool _healerDps;     // healer: damage when nobody needs heals
    bool _saveMana;      // healer: efficient heals when low mana
    bool _offHeal;       // DPS hybrid: emergency heal below threshold
    bool _ncHeal;        // healer: top up allies out of combat
    bool _waitForAttack; // non-tanks delay DPS after combat starts
    bool _aoe;           // multi-target rotation branches
    bool _boost;         // trinkets + offensive racials
    bool _cc;            // crowd control utilities
    bool _avoidAoe;      // step out of ground effects, traps, and trigger creatures
    bool _walk;          // self-bot: bot may path (loot, target, avoid); idle = player
    bool _debugCombat;   // say casting / combat actions in chat
    // Server currently owns the self-bot's client (SMSG_CLIENT_CONTROL_UPDATE 0).
    bool _selfWalkDriving = false;
    // A movement helper ran during this decision tick.
    bool _selfWalkClaimed = false;

    bool _forceRest;
    bool _resting;
    bool _holdAssist;    // @tank attack: hold until tank/party engages, then assist
    uint64 _forcedTargetGuid;

    bool _lfgRoleResponded;
    bool _lfgProposalResponded;
    bool _wasGrouped;    // detect invite/leave for strategy packs
    // --- Play-tester state ---
    enum class TestStep : uint8 { None, Accept, Objectives, TurnIn };

    struct QuestTest
    {
        uint32 questId = 0;
        TestStep step = TestStep::None;
        uint64 requester = 0;
        uint32 startedMs = 0;
        // Time spent in the current step, and since the objectives last advanced.
        uint32 stepMs = 0;
        uint32 idleMs = 0;
        uint32 signature = 0;
        uint32 killsWithoutCredit = 0;
        uint32 deaths = 0;
        // Quest giver the current step walks to.
        uint32 giverEntry = 0;
        bool giverIsObject = false;
        BotSpawn giverSpawn;
        // The bot's strategies before the test, put back when it ends.
        BotStrategyEngine savedStrategies;
    };

    struct QuestWatch
    {
        uint32 signature = 0;
        uint32 idleMs = 0;
    };

    void UpdateTester(uint32 elapsed);
    void UpdateQuestWatch(uint32 elapsed);
    // Runs the directed test. True when it used this tick.
    bool UpdateQuestTest(uint32 elapsed);
    bool BeginTestStep(TestStep step, std::string& failure);
    void FinishQuestTest(BotTestOutcome outcome, std::string const& message);
    Object* FindTestGiver() const;
    uint32 QuestProgressSignature(Quest const* quest) const;
    // First unfinished objective, described for a result or finding. supported is
    // false when a bot cannot work on it (use an object, cast a spell, explore).
    std::string DescribeOpenObjective(Quest const* quest, bool& supported, uint32& objectId) const;
    // Creature entries worth killing for the bot's open kill and item objectives.
    void CollectQuestKillEntries(std::unordered_set<uint32>& out) const;
    // Nearest place to work on an open objective of the quest.
    bool FindObjectiveSpawn(Quest const* quest, BotSpawn& out) const;
    bool FindQuestGiverSpawn(Quest const* quest, bool ender, uint32& entry, bool& isObject, BotSpawn& out,
        bool& anyRelation) const;
    // Walks to a spot on this map; teleports when it is on another map or far
    // away and teleporting is allowed. False when the bot cannot get there.
    bool TravelToSpawn(BotSpawn const& spawn);
    bool TravelToQuestEnder();
    void AbandonQuest(uint32 questId);

    // --- Battlegrounds and arenas (PlayerbotAIBattleground.cpp) ---
    // Nearest enemy player the bot can see and attack, within range.
    Unit* SelectPvpTarget(float range) const;
    // Waits for the gates, then walks toward the nearest enemy. True when it used this tick.
    bool HandleBattleground(uint32 elapsed);
    // Dead in a battleground: release, then get up at the graveyard. False outside one.
    bool HandleBattlegroundDeath(uint32 diff);

    // --- Objectives that are not kills (PlayerbotAIQuestObjects.cpp) ---
    struct QuestInteractTarget
    {
        uint32 questId = 0;
        uint32 entry = 0;
        bool gameobject = false;
        // A chest that may hold a quest item: an empty one is no problem.
        bool container = false;
    };
    struct QuestInteractTries
    {
        uint32 signature = 0;
        uint8 tries = 0;
    };
    // Objects to use, chests to open and NPCs to talk to for the open objectives.
    void CollectQuestInteractTargets(std::vector<QuestInteractTarget>& out) const;
    // Walks to the nearest of them and uses it. True when it used this tick.
    bool HandleQuestObjects();
    bool UseQuestObject(GameObject* object);
    bool TalkToQuestNpc(Creature* npc, uint32 questId);
    // Nobody resurrects a bot that dies alone: it gets up where it fell after
    // a while, and a directed test gives up after a few deaths.
    void HandleSoloDeath(uint32 diff);
    void NoteTravelProgress(uint32 elapsed);

    uint32 _testerTimer = 0;
    QuestTest _test;
    TravelDest _pendingTeleport;
    std::unordered_map<uint32, QuestWatch> _questWatch;
    std::unordered_set<uint32> _abandonedQuests;
    // (quest id << 8 | objective index) -> counter when it was last looked at.
    std::unordered_map<uint64, uint16> _objectiveCounters;
    // spell id -> casts in a row that did not start; 0xFF once it has cast.
    std::unordered_map<uint32, uint8> _spellFails;
    std::unordered_map<uint32, uint32> _spellFailMs;
    // Complete quest -> trips made to its ender / ticks spent waiting next to it.
    std::unordered_map<uint32, uint32> _enderTrips;
    std::unordered_map<uint32, uint32> _enderWaits;
    // Complete quest -> closest 2D distance to its ender at the start of a trip.
    std::unordered_map<uint32, float> _enderBestDist;
    // Object / NPC GUID -> getMSTime() before which it is not used again.
    std::unordered_map<uint64, uint32> _questObjectRetry;
    // Entry -> uses in a row that did not advance its quest.
    std::unordered_map<uint32, QuestInteractTries> _questInteractTries;
    // The object or NPC being walked to, and for how many AI ticks.
    uint64 _questApproachGuid = 0;
    uint32 _questApproachTicks = 0;
    float _travelLastX = 0.0f;
    float _travelLastY = 0.0f;
    uint32 _travelStillMs = 0;
    uint32 _deadMs = 0;
    bool _pvpReleased = false;
    uint32 _pvpAdvanceMs = 0;
};

#endif // _SF_PLAYERBOT_AI_H
