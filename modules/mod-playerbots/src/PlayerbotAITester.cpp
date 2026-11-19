/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Playerbots module - the play-tester half of PlayerbotAI.
*
* Passive: while a bot quests on its own it watches for server problems (a
* quest that stops advancing, a kill without credit, a spell that never
* casts) and records them in BotFindings.
*
* Directed: StartQuestTest plays one quest from its starter to the turn-in
* and reports pass / fail / skipped, with the step that failed, to BotTestMgr.
*/

#include "PlayerbotAI.h"
#include "PlayerbotMgr.h"
#include "BotFindings.h"
#include "BotSpawnIndex.h"
#include "BotTeleportMaps.h"
#include "BotTestMgr.h"
#include "engine/BotMovement.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "DBCStores.h"
#include "DisableMgr.h"
#include "GameObject.h"
#include "GameObjectAI.h"
#include "GossipDef.h"
#include "Group.h"
#include "Log.h"
#include "MotionMaster.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptMgr.h"
#include "World.h"
#include "WorldSession.h"

#include <cmath>
#include <sstream>

namespace
{
    uint32 const QUEST_WATCH_INTERVAL = 15 * IN_MILLISECONDS;
    // Directed test: time to find, reach and use a starter or ender.
    uint32 const TEST_GIVER_MISSING_MS = 20 * IN_MILLISECONDS;
    uint32 const TEST_GIVER_TIMEOUT_MS = 2 * MINUTE * IN_MILLISECONDS;
    uint32 const TEST_TOTAL_TIMEOUT_MS = 30 * MINUTE * IN_MILLISECONDS;
    // A test walks this far and teleports beyond it.
    float const TEST_WALK_DISTANCE = 150.0f;
    float const GIVER_SEARCH_RANGE = 60.0f;
    uint8 const SPELL_FAIL_LIMIT = 8;
    uint8 const SPELL_HAS_CAST = 0xFF;
    uint32 const TRAVEL_STUCK_MS = 20 * IN_MILLISECONDS;
    uint32 const SOLO_REVIVE_MS = 30 * IN_MILLISECONDS;
    // Turn-in travel: how close counts as arrived, how long to wait there for
    // the ender (AI ticks), and how many trips in a row that bring the bot no
    // closer than ENDER_TRIP_PROGRESS yards to make before giving up. A fight on
    // the way ends a trip, so trips that got closer do not count.
    float const ENDER_ARRIVED_RANGE = 5.0f;
    uint32 const ENDER_WAIT_TICKS = 20;
    uint32 const ENDER_MAX_TRIPS = 3;
    float const ENDER_TRIP_PROGRESS = 10.0f;
    // Failed casts further apart than this are not "in a row".
    uint32 const SPELL_FAIL_WINDOW_MS = 30 * IN_MILLISECONDS;
    // A bot this close to an objective spawn was on site when its quest stalled.
    float const STALL_SITE_RANGE = 150.0f;
    uint32 const TEST_MAX_DEATHS = 3;
    // PlayerbotAI pulls quest mobs from this far (BOT_QUEST_HUNT_RADIUS).
    float const QUEST_HUNT_RADIUS = 40.0f;

    // A kill objective is spawned when its creature, or one that credits it, is.
    bool KillObjectiveHasSpawn(uint32 entry)
    {
        if (sBotSpawnIndex->HasSpawn(entry, false))
            return true;
        for (uint32 source : sBotSpawnIndex->GetKillCreditSources(entry))
            if (sBotSpawnIndex->HasSpawn(source, false))
                return true;
        return false;
    }

    // Quests the player hands in to themselves have no ender creature or object.
    bool IsSelfTurnIn(Quest const* quest)
    {
        return quest->HasFlag(QUEST_FLAGS_AUTOCOMPLETE) || quest->HasFlag(QUEST_FLAGS_PLAYER_CAST_COMPLETE);
    }

    uint64 ObjectiveKey(uint32 questId, uint8 index)
    {
        return (uint64(questId) << 8) | index;
    }

    uint16 ObjectiveNeed(QuestObjective const* objective)
    {
        return uint16(objective->Amount > 0 ? objective->Amount : 1);
    }

    std::string EntryLabel(uint32 entry, bool gameobject)
    {
        std::ostringstream out;
        out << entry;
        if (gameobject)
        {
            if (GameObjectTemplate const* object = sObjectMgr->GetGameObjectTemplate(entry))
                out << " '" << object->name << '\'';
        }
        else if (CreatureTemplate const* creature = sObjectMgr->GetCreatureTemplate(entry))
            out << " '" << creature->Name << '\'';
        return out.str();
    }

    // Why CanTakeQuest refuses, in the order a player would run into it. The
    // quest's own log state and the level can be left out: a test resets the
    // first and may change the second.
    std::string TakeQuestRefusal(Player* bot, Quest const* quest, bool checkStatus = true, bool checkLevel = true)
    {
        if (checkStatus && !bot->SatisfyQuestStatus(quest, false))
            return "the bot already has or has finished the quest";
        if (!bot->SatisfyQuestClass(quest, false))
            return "wrong class";
        if (!bot->SatisfyQuestRace(quest, false))
            return "wrong race or faction";
        if (checkLevel && !bot->SatisfyQuestLevel(quest, false))
        {
            std::ostringstream out;
            out << "wrong level (bot " << uint32(bot->getLevel()) << ", quest needs " << quest->GetMinLevel() << ')';
            return out.str();
        }
        if (!bot->SatisfyQuestPreviousQuest(quest, false))
        {
            std::ostringstream out;
            out << "an earlier quest of the chain is not done";
            if (quest->GetPrevQuestId())
                out << " (quest " << std::abs(quest->GetPrevQuestId()) << ')';
            return out.str();
        }
        if (!bot->SatisfyQuestSkill(quest, false))
            return "missing profession skill";
        if (!bot->SatisfyQuestReputation(quest, false))
            return "missing reputation";
        if (!bot->SatisfyQuestExclusiveGroup(quest, false))
            return "an exclusive alternative of the quest was taken";
        if (!bot->SatisfyQuestNextChain(quest, false) || !bot->SatisfyQuestPrevChain(quest, false))
            return "another quest of the chain is in the way";
        if (!bot->SatisfyQuestDay(quest, false) || !bot->SatisfyQuestWeek(quest, false)
            || !bot->SatisfyQuestMonth(quest, false) || !bot->SatisfyQuestSeasonal(quest, false))
            return "daily, weekly or seasonal quest already done";
        if (!bot->SatisfyQuestConditions(quest, false))
            return "a condition of the quest is not met";
        return std::string();
    }
}

// ---------------------------------------------------------------------------
// Quest hand-in / pick-up, as the client opcode handlers do them
// ---------------------------------------------------------------------------

bool PlayerbotAI::AcceptQuest(Quest const* quest, Object* giver)
{
    if (!_bot || !quest || !giver)
        return false;

    uint32 const questId = quest->GetQuestId();
    if (!giver->hasQuest(questId) || !_bot->CanInteractWithQuestGiver(giver))
        return false;
    if (!_bot->CanTakeQuest(quest, false) || !_bot->CanAddQuest(quest, false))
        return false;

    _bot->AddQuest(quest, giver);
    if (_bot->CanCompleteQuest(questId))
        _bot->CompleteQuest(questId);

    if (GameObject* object = giver->ToGameObject())
        object->AI()->QuestAccept(_bot, quest);

    if (_bot->PlayerTalkClass)
        _bot->PlayerTalkClass->SendCloseGossip();
    if (quest->GetSrcSpell() > 0)
        _bot->CastSpell(_bot, quest->GetSrcSpell(), true);

    if (_bot->GetQuestStatus(questId) != QUEST_STATUS_NONE || _bot->IsQuestRewarded(questId))
        return true;

    sBotFindings->Record(BotFindingType::QuestAcceptFailed, questId, 0, _bot,
        "every check passed but the quest did not enter the log");
    // Not offered again this session, or the bot would retry it every tick.
    _abandonedQuests.insert(questId);
    return false;
}

bool PlayerbotAI::TurnInQuest(Quest const* quest, Object* giver)
{
    if (!_bot || !quest || !giver)
        return false;

    uint32 const questId = quest->GetQuestId();
    if (!giver->hasInvolvedQuest(questId) || !_bot->CanInteractWithQuestGiver(giver))
        return false;
    if (_bot->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE)
        return false;

    uint32 const reward = BestRewardItem(quest);
    if (!_bot->CanRewardQuest(quest, reward, false))
        return false;

    _bot->RewardQuest(quest, reward, giver, true);

    // RewardQuest may have despawned the quest giver's quest state; the script
    // hooks still get the object the bot talked to.
    if (Creature* creature = giver->ToCreature())
    {
        if (!sScriptMgr->OnQuestReward(_bot, creature, quest, reward))
            creature->AI()->sQuestReward(_bot, quest, reward);
    }
    else if (GameObject* object = giver->ToGameObject())
    {
        if (!sScriptMgr->OnQuestReward(_bot, object, quest, reward))
            object->AI()->QuestReward(_bot, quest, reward);
    }

    if (_bot->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE)
    {
        _enderTrips.erase(questId);
        _enderWaits.erase(questId);
        _enderBestDist.erase(questId);
        return true;
    }

    sBotFindings->Record(BotFindingType::QuestTurnInFailed, questId, 0, _bot,
        "every check passed but the quest stayed complete in the log");
    if (!IsQuestTesting() && sPlayerbotMgr->ShouldAbandonStalledQuests())
        AbandonQuest(questId);
    return false;
}

void PlayerbotAI::AbandonQuest(uint32 questId)
{
    if (!_bot)
        return;

    for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
    {
        if (_bot->GetQuestSlotQuestId(slot) != questId)
            continue;
        _bot->TakeQuestSourceItem(questId, false);
        if (Quest const* quest = sObjectMgr->GetQuestTemplate(questId))
            if (quest->HasSpecialFlag(QUEST_SPECIAL_FLAGS_TIMED))
                _bot->RemoveTimedQuest(questId);
        _bot->RemoveActiveQuest(questId);
        _bot->SetQuestSlot(slot, 0);
    }

    _abandonedQuests.insert(questId);
    _questWatch.erase(questId);
}

// ---------------------------------------------------------------------------
// Objective lookups
// ---------------------------------------------------------------------------

uint32 PlayerbotAI::QuestProgressSignature(Quest const* quest) const
{
    uint32 signature = uint32(_bot->GetQuestStatus(quest->GetQuestId()));
    uint16 const slot = _bot->FindQuestSlot(quest->GetQuestId());
    for (QuestObjective const* objective : quest->m_questObjectives)
    {
        if (!objective)
            continue;
        uint32 have = 0;
        if (objective->Type == QUEST_OBJECTIVE_TYPE_ITEM)
            have = _bot->GetItemCount(objective->ObjectId, true);
        else if (slot < MAX_QUEST_LOG_SIZE)
            have = _bot->GetQuestSlotCounter(slot, objective->Index);
        signature += have * (uint32(objective->Index) * 131 + 7);
    }
    return signature;
}

std::string PlayerbotAI::DescribeOpenObjective(Quest const* quest, bool& supported, uint32& objectId) const
{
    supported = false;
    objectId = 0;

    uint16 const slot = _bot->FindQuestSlot(quest->GetQuestId());
    QuestObjective const* open = nullptr;
    uint32 openHave = 0;
    for (QuestObjective const* objective : quest->m_questObjectives)
    {
        if (!objective)
            continue;
        uint32 have = 0;
        if (objective->Type == QUEST_OBJECTIVE_TYPE_ITEM)
            have = _bot->GetItemCount(objective->ObjectId, true);
        else if (slot < MAX_QUEST_LOG_SIZE)
            have = _bot->GetQuestSlotCounter(slot, objective->Index);
        if (have >= ObjectiveNeed(objective))
            continue;
        if (!open || objective->Index < open->Index)
        {
            open = objective;
            openHave = have;
        }
    }

    if (!open)
        return "every counted objective is done but the quest is not complete (needs an event, area or script)";

    std::ostringstream out;
    switch (open->Type)
    {
        case QUEST_OBJECTIVE_TYPE_NPC:
            supported = true;
            objectId = open->ObjectId;
            out << "kill " << EntryLabel(open->ObjectId, false);
            break;
        case QUEST_OBJECTIVE_TYPE_ITEM:
            supported = !sBotSpawnIndex->GetItemDroppers(open->ObjectId).empty()
                || !sBotSpawnIndex->GetItemContainers(open->ObjectId).empty();
            out << "collect item " << open->ObjectId;
            if (!supported)
                out << " (no creature drops it and no chest holds it directly)";
            break;
        case QUEST_OBJECTIVE_TYPE_GO:
            supported = true;
            out << "use object " << EntryLabel(open->ObjectId, true);
            break;
        case QUEST_OBJECTIVE_TYPE_NPC_INTERACT:
            supported = true;
            out << "talk to " << EntryLabel(open->ObjectId, false);
            break;
        default:
            out << "objective type " << uint32(open->Type);
            break;
    }
    out << ' ' << openHave << '/' << ObjectiveNeed(open);
    return out.str();
}

void PlayerbotAI::CollectQuestKillEntries(std::unordered_set<uint32>& out) const
{
    if (!_bot)
        return;

    for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
    {
        uint32 const questId = _bot->GetQuestSlotQuestId(slot);
        if (!questId || (_test.questId && questId != _test.questId))
            continue;
        if (_bot->GetQuestStatus(questId) != QUEST_STATUS_INCOMPLETE)
            continue;
        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            continue;

        for (QuestObjective const* objective : quest->m_questObjectives)
        {
            if (!objective)
                continue;
            if (objective->Type == QUEST_OBJECTIVE_TYPE_NPC)
            {
                if (_bot->GetQuestSlotCounter(slot, objective->Index) >= ObjectiveNeed(objective))
                    continue;
                out.insert(objective->ObjectId);
                for (uint32 source : sBotSpawnIndex->GetKillCreditSources(objective->ObjectId))
                    out.insert(source);
            }
            else if (objective->Type == QUEST_OBJECTIVE_TYPE_ITEM)
            {
                if (_bot->GetItemCount(objective->ObjectId, true) >= ObjectiveNeed(objective))
                    continue;
                for (uint32 dropper : sBotSpawnIndex->GetItemDroppers(objective->ObjectId))
                    out.insert(dropper);
            }
        }
    }
}

bool PlayerbotAI::FindObjectiveSpawn(Quest const* quest, BotSpawn& out) const
{
    uint16 const slot = _bot->FindQuestSlot(quest->GetQuestId());
    if (slot >= MAX_QUEST_LOG_SIZE)
        return false;

    // Entry, and whether it is a gameobject.
    std::vector<std::pair<uint32, bool>> entries;
    for (QuestObjective const* objective : quest->m_questObjectives)
    {
        if (!objective)
            continue;
        if (objective->Type == QUEST_OBJECTIVE_TYPE_ITEM)
        {
            if (_bot->GetItemCount(objective->ObjectId, true) >= ObjectiveNeed(objective))
                continue;
            for (uint32 dropper : sBotSpawnIndex->GetItemDroppers(objective->ObjectId))
                entries.push_back(std::make_pair(dropper, false));
            for (uint32 container : sBotSpawnIndex->GetItemContainers(objective->ObjectId))
                entries.push_back(std::make_pair(container, true));
            continue;
        }

        if (objective->Type != QUEST_OBJECTIVE_TYPE_NPC && objective->Type != QUEST_OBJECTIVE_TYPE_GO
            && objective->Type != QUEST_OBJECTIVE_TYPE_NPC_INTERACT)
            continue;
        if (_bot->GetQuestSlotCounter(slot, objective->Index) >= ObjectiveNeed(objective))
            continue;
        entries.push_back(std::make_pair(objective->ObjectId, objective->Type == QUEST_OBJECTIVE_TYPE_GO));
        if (objective->Type == QUEST_OBJECTIVE_TYPE_NPC)
            for (uint32 source : sBotSpawnIndex->GetKillCreditSources(objective->ObjectId))
                entries.push_back(std::make_pair(source, false));
    }

    bool found = false;
    bool foundSameMap = false;
    float bestDist = 0.0f;
    for (auto const& entry : entries)
    {
        BotSpawn spawn;
        if (!sBotSpawnIndex->FindNearest(entry.first, entry.second, _bot->GetMapId(), _bot->GetPositionX(),
            _bot->GetPositionY(), _bot->GetPositionZ(), false, spawn))
            continue;

        bool const sameMap = spawn.mapId == _bot->GetMapId();
        float const dist = sameMap ? _bot->GetExactDist(spawn.x, spawn.y, spawn.z) : 0.0f;
        if (found && foundSameMap && (!sameMap || dist >= bestDist))
            continue;
        if (found && !foundSameMap && !sameMap)
            continue;
        out = spawn;
        found = true;
        foundSameMap = sameMap;
        bestDist = dist;
    }
    return found;
}

bool PlayerbotAI::FindQuestGiverSpawn(Quest const* quest, bool ender, uint32& entry, bool& isObject,
    BotSpawn& out, bool& anyRelation) const
{
    uint32 const questId = quest->GetQuestId();
    std::vector<std::pair<uint32, bool>> givers;
    if (ender)
    {
        QuestRelationReverseBounds const creatures = sObjectMgr->GetCreatureQuestInvolvedRelationReverseBounds(questId);
        for (auto itr = creatures.first; itr != creatures.second; ++itr)
            givers.push_back(std::make_pair(itr->second, false));
        QuestRelationReverseBounds const objects = sObjectMgr->GetGOQuestInvolvedRelationReverseBounds(questId);
        for (auto itr = objects.first; itr != objects.second; ++itr)
            givers.push_back(std::make_pair(itr->second, true));
    }
    else
    {
        for (uint32 creature : sBotSpawnIndex->GetCreatureStarters(questId))
            givers.push_back(std::make_pair(creature, false));
        for (uint32 object : sBotSpawnIndex->GetGameObjectStarters(questId))
            givers.push_back(std::make_pair(object, true));
    }

    anyRelation = !givers.empty();
    entry = givers.empty() ? 0 : givers.front().first;
    isObject = !givers.empty() && givers.front().second;

    FactionTemplateEntry const* botFaction = _bot->GetFactionTemplateEntry();
    bool found = false;
    bool foundSameMap = false;
    float bestDist = 0.0f;
    for (auto const& giver : givers)
    {
        // A quest both factions can do has a giver on each side.
        if (!giver.second && botFaction)
        {
            CreatureTemplate const* creature = sObjectMgr->GetCreatureTemplate(giver.first);
            FactionTemplateEntry const* faction = creature ? sFactionTemplateStore.LookupEntry(creature->faction_A) : nullptr;
            if (faction && botFaction->IsHostileTo(*faction))
                continue;
        }

        BotSpawn spawn;
        if (!sBotSpawnIndex->FindNearest(giver.first, giver.second, _bot->GetMapId(), _bot->GetPositionX(),
            _bot->GetPositionY(), _bot->GetPositionZ(), false, spawn))
            continue;

        bool const sameMap = spawn.mapId == _bot->GetMapId();
        float const dist = sameMap ? _bot->GetExactDist(spawn.x, spawn.y, spawn.z) : 0.0f;
        if (found && foundSameMap && (!sameMap || dist >= bestDist))
            continue;
        if (found && !foundSameMap && !sameMap)
            continue;
        out = spawn;
        entry = giver.first;
        isObject = giver.second;
        found = true;
        foundSameMap = sameMap;
        bestDist = dist;
    }
    return found;
}

// ---------------------------------------------------------------------------
// Travel
// ---------------------------------------------------------------------------

bool PlayerbotAI::TravelToSpawn(BotSpawn const& spawn)
{
    if (!_bot || _clientControlled || _pendingTeleport.active)
        return false;

    bool const sameMap = spawn.mapId == _bot->GetMapId();
    float const dist = sameMap ? _bot->GetExactDist(spawn.x, spawn.y, spawn.z) : 0.0f;
    float const teleportBeyond = IsQuestTesting() ? TEST_WALK_DISTANCE : sPlayerbotMgr->GetQuestTeleportDistance();

    if (sameMap && (teleportBeyond <= 0.0f || dist <= teleportBeyond))
        return SetTravelDestination(spawn.mapId, spawn.x, spawn.y, spawn.z);

    // A grouped bot stays with its party: it walks, or does not go.
    if (teleportBeyond <= 0.0f || _bot->GetGroup())
        return sameMap && SetTravelDestination(spawn.mapId, spawn.x, spawn.y, spawn.z);
    if (!IsQuestTesting() && !BotTeleportMaps::CanBotTeleportTo(_bot, spawn.mapId))
        return false;
    if (_bot->IsInCombat() || _bot->IsInFlight() || !_bot->IsAlive())
        return false;

    // Map changes are not safe from a map thread: PlayerbotMgr::Update finishes it.
    ClearTravelDestination();
    _pendingTeleport.mapId = spawn.mapId;
    _pendingTeleport.x = spawn.x;
    _pendingTeleport.y = spawn.y;
    _pendingTeleport.z = spawn.z;
    _pendingTeleport.active = true;
    return true;
}

void PlayerbotAI::ProcessPendingTeleport()
{
    if (!_pendingTeleport.active)
        return;
    _pendingTeleport.active = false;

    if (!_bot || !_bot->IsInWorld() || !_bot->IsAlive() || _bot->IsInCombat() || _bot->IsBeingTeleported())
        return;

    TryDismount();
    if (!BotTeleportMaps::TeleportToSpawn(_bot, _pendingTeleport.mapId, _pendingTeleport.x,
        _pendingTeleport.y, _pendingTeleport.z))
    {
        std::ostringstream note;
        note << "a spawn point on map " << _pendingTeleport.mapId << " the bot could not be teleported to";
        sBotFindings->RecordAt(BotFindingType::BadPosition, _bot, _pendingTeleport.x, _pendingTeleport.y,
            _pendingTeleport.z, note.str(), int32(_pendingTeleport.mapId));
        if (IsQuestTesting())
            FinishQuestTest(BotTestOutcome::Fail, std::string(GetTestStepName()) + ": " + note.str());
        return;
    }

    _followGuid = 0;
    _chaseGuid = 0;
    _lootGuid = 0;
    EnsureVisiblePhases();
}

bool PlayerbotAI::TravelToQuestEnder()
{
    if (!_bot || HasTravelDestination() || _pendingTeleport.active)
        return false;

    for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
    {
        uint32 const questId = _bot->GetQuestSlotQuestId(slot);
        if (!questId || _bot->GetQuestStatus(questId) != QUEST_STATUS_COMPLETE)
            continue;
        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            continue;

        uint32 entry = 0;
        bool isObject = false;
        bool anyRelation = false;
        BotSpawn spawn;
        if (!FindQuestGiverSpawn(quest, true, entry, isObject, spawn, anyRelation))
        {
            if (!anyRelation && IsSelfTurnIn(quest))
            {
                uint32 const reward = BestRewardItem(quest);
                if (_bot->CanRewardQuest(quest, reward, false))
                {
                    _bot->RewardQuest(quest, reward, _bot, true);
                    return true;
                }
                continue;
            }

            // Once per bot and quest: without abandoning, the quest stays complete in the log.
            if (_abandonedQuests.insert(questId).second)
            {
                if (!anyRelation)
                    sBotFindings->Record(BotFindingType::QuestNoEnder, questId, 0, _bot);
                else
                    sBotFindings->Record(BotFindingType::QuestEnderNoSpawn, questId, entry, _bot);
            }
            if (sPlayerbotMgr->ShouldAbandonStalledQuests())
            {
                AbandonQuest(questId);
                return false;
            }
            continue;
        }

        // Only creatures are handed in to by HandleQuestNpcs.
        if (isObject || IsQuestAbandoned(questId))
            continue;

        // Standing at the spawn point (the tolerance travel arrives with) and the
        // quest is still complete: the ender is not there to take it.
        float const dx = _bot->GetPositionX() - spawn.x;
        float const dy = _bot->GetPositionY() - spawn.y;
        bool const atSpawn = spawn.mapId == _bot->GetMapId() && dx * dx + dy * dy <= ENDER_ARRIVED_RANGE * ENDER_ARRIVED_RANGE;
        bool giveUp = false;
        if (atSpawn)
        {
            if (++_enderWaits[questId] < ENDER_WAIT_TICKS)
                return true;
            sBotFindings->Record(BotFindingType::QuestEnderMissing, questId, entry, _bot);
            giveUp = true;
        }
        else if (_enderTrips[questId] >= ENDER_MAX_TRIPS)
        {
            sBotFindings->RecordAt(BotFindingType::PathFailed, _bot, spawn.x, spawn.y, spawn.z,
                "quest ender " + EntryLabel(entry, false), int32(spawn.mapId));
            giveUp = true;
        }

        if (giveUp)
        {
            // Not gone back to this session, so the bot gets on with its other quests.
            _enderTrips.erase(questId);
            _enderWaits.erase(questId);
            _enderBestDist.erase(questId);
            _abandonedQuests.insert(questId);
            if (sPlayerbotMgr->ShouldAbandonStalledQuests())
                AbandonQuest(questId);
            continue;
        }

        if (TravelToSpawn(spawn))
        {
            // Closer than at the start of every earlier trip: the last one was cut
            // short (a fight, a rest), not blocked, so it is not held against the bot.
            if (spawn.mapId == _bot->GetMapId())
            {
                float const dist = std::sqrt(dx * dx + dy * dy);
                auto const best = _enderBestDist.find(questId);
                if (best == _enderBestDist.end() || dist + ENDER_TRIP_PROGRESS <= best->second)
                {
                    _enderBestDist[questId] = dist;
                    _enderTrips[questId] = 0;
                }
            }
            ++_enderTrips[questId];
            return true;
        }
    }
    return false;
}

void PlayerbotAI::NoteTravelProgress(uint32 elapsed)
{
    if (!_bot || !_travel.active)
    {
        _travelStillMs = 0;
        return;
    }

    // Only a bot that is supposed to be walking can be stuck: resting, looting
    // and mounting all pause the trip without a point movement running.
    float const dx = _bot->GetPositionX() - _travelLastX;
    float const dy = _bot->GetPositionY() - _travelLastY;
    if (dx * dx + dy * dy > 4.0f || _bot->IsInCombat() || BotMovement::IsCasting(_bot)
        || _bot->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE
        || _bot->HasUnitState(UNIT_STATE_STUNNED | UNIT_STATE_ROOT | UNIT_STATE_CONFUSED | UNIT_STATE_FLEEING))
    {
        _travelLastX = _bot->GetPositionX();
        _travelLastY = _bot->GetPositionY();
        _travelStillMs = 0;
        return;
    }

    _travelStillMs += elapsed;
    if (_travelStillMs < TRAVEL_STUCK_MS)
        return;

    _travelStillMs = 0;
    std::ostringstream note;
    note << "walking to (" << _travel.x << ", " << _travel.y << ", " << _travel.z << ')';
    sBotFindings->RecordAt(BotFindingType::Stuck, _bot, _bot->GetPositionX(), _bot->GetPositionY(),
        _bot->GetPositionZ(), note.str());
    ClearTravelDestination();
    BotMovement::StopAndIdle(_bot);
}

void PlayerbotAI::HandleSoloDeath(uint32 diff)
{
    if (!_bot || _clientControlled || _bot->IsAlive())
        return;
    // Grouped bots wait for a resurrection or the leader's summon.
    if ((_bot->GetGroup() && !IsQuestTesting()) || _bot->GetMap()->Instanceable())
        return;

    _deadMs += diff;
    if (_deadMs < SOLO_REVIVE_MS)
        return;
    _deadMs = 0;

    _bot->ResurrectPlayer(0.5f, false);
    _bot->SpawnCorpseBones();
    ClearTravelDestination();
    ClearForcedTarget();

    if (IsQuestTesting() && ++_test.deaths >= TEST_MAX_DEATHS)
    {
        std::ostringstream out;
        out << GetTestStepName() << ": the bot died " << _test.deaths << " times";
        FinishQuestTest(BotTestOutcome::Fail, out.str());
    }
}

// ---------------------------------------------------------------------------
// Passive findings
// ---------------------------------------------------------------------------

void PlayerbotAI::NoteCreatureKill(Creature* killed)
{
    if (!_bot || !killed || _clientControlled || !sBotFindings->IsEnabled())
        return;
    if (!killed->isTappedBy(_bot))
        return;

    uint32 const entry = killed->GetEntry();
    for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
    {
        uint32 const questId = _bot->GetQuestSlotQuestId(slot);
        if (!questId)
            continue;
        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            continue;

        for (QuestObjective const* objective : quest->m_questObjectives)
        {
            if (!objective || objective->Type != QUEST_OBJECTIVE_TYPE_NPC || objective->ObjectId != entry)
                continue;

            // Kill credit is given before the kill hook runs.
            uint16 const have = _bot->GetQuestSlotCounter(slot, objective->Index);
            uint64 const key = ObjectiveKey(questId, objective->Index);
            auto const known = _objectiveCounters.find(key);
            bool const credited = known == _objectiveCounters.end() || have > known->second;
            _objectiveCounters[key] = have;

            if (credited || have >= ObjectiveNeed(objective)
                || _bot->GetQuestStatus(questId) != QUEST_STATUS_INCOMPLETE)
                continue;

            sBotFindings->Record(BotFindingType::QuestKillNoCredit, questId, entry, _bot);
            if (_test.questId == questId)
                ++_test.killsWithoutCredit;
        }
    }
}

void PlayerbotAI::NoteSpellResult(uint32 spellId, bool started)
{
    if (!spellId || !_bot)
        return;

    uint8& fails = _spellFails[spellId];
    if (started)
    {
        fails = SPELL_HAS_CAST;
        return;
    }
    if (fails == SPELL_HAS_CAST || fails >= SPELL_FAIL_LIMIT)
        return;

    uint32 const now = getMSTime();
    uint32& lastFail = _spellFailMs[spellId];
    if (fails && getMSTimeDiff(lastFail, now) > SPELL_FAIL_WINDOW_MS)
        fails = 0;
    lastFail = now;
    if (++fails < SPELL_FAIL_LIMIT)
        return;

    std::ostringstream note;
    note << "class " << uint32(_bot->getClass()) << ", level " << uint32(_bot->getLevel());
    sBotFindings->Record(BotFindingType::SpellNeverCasts, spellId,
        _bot->GetTalentSpecialization(_bot->GetActiveSpec()), _bot, note.str());
}

void PlayerbotAI::UpdateQuestWatch(uint32 elapsed)
{
    uint32 const stallMs = sPlayerbotMgr->GetQuestStallMs();
    for (uint8 slot = 0; slot < MAX_QUEST_LOG_SIZE; ++slot)
    {
        uint32 const questId = _bot->GetQuestSlotQuestId(slot);
        if (!questId || _bot->GetQuestStatus(questId) != QUEST_STATUS_INCOMPLETE)
            continue;
        Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
        if (!quest)
            continue;

        // Remember kill counters so the first kill after login can be checked too.
        for (QuestObjective const* objective : quest->m_questObjectives)
            if (objective && objective->Type == QUEST_OBJECTIVE_TYPE_NPC)
                _objectiveCounters[ObjectiveKey(questId, objective->Index)] =
                    _bot->GetQuestSlotCounter(slot, objective->Index);

        QuestWatch& watch = _questWatch[questId];
        uint32 const signature = QuestProgressSignature(quest);
        if (signature != watch.signature)
        {
            watch.signature = signature;
            watch.idleMs = 0;
            continue;
        }

        // The clock runs only for the quest the bot is at (or one with nowhere
        // to go at all), not for the others waiting their turn in the log.
        BotSpawn spawn;
        bool const haveSpawn = FindObjectiveSpawn(quest, spawn);
        if (haveSpawn && (spawn.mapId != _bot->GetMapId()
            || _bot->GetExactDist(spawn.x, spawn.y, spawn.z) > STALL_SITE_RANGE))
            continue;

        watch.idleMs += elapsed;
        if (!stallMs || watch.idleMs < stallMs)
            continue;

        bool supported = false;
        uint32 objectId = 0;
        std::string const objective = DescribeOpenObjective(quest, supported, objectId);
        if (objectId && !KillObjectiveHasSpawn(objectId))
            sBotFindings->Record(BotFindingType::QuestObjectiveNoSpawn, questId, objectId, _bot,
                objective + " (not in the creature table: summoned by a script or event?)");
        else if (supported && haveSpawn)
            sBotFindings->Record(BotFindingType::QuestStalled, questId, objectId, _bot, objective);

        // A quest the bot cannot work on (use an object, explore) is dropped
        // without a finding: that is the bot's limit, not a server problem.
        if (sPlayerbotMgr->ShouldAbandonStalledQuests())
            AbandonQuest(questId);
        else
            watch.idleMs = 0;
        return;
    }
}

void PlayerbotAI::UpdateTester(uint32 elapsed)
{
    if (!_bot || _clientControlled || !sBotFindings->IsEnabled())
        return;

    NoteTravelProgress(elapsed);

    _testerTimer += elapsed;
    if (_testerTimer < QUEST_WATCH_INTERVAL)
        return;
    uint32 const watched = _testerTimer;
    _testerTimer = 0;

    // Only time spent questing alone counts toward a stall.
    if (!_quests || IsQuestTesting() || _bot->GetGroup() || !_bot->IsAlive())
        return;
    UpdateQuestWatch(watched);
}

// ---------------------------------------------------------------------------
// Directed quest test
// ---------------------------------------------------------------------------

char const* PlayerbotAI::GetTestStepName() const
{
    switch (_test.step)
    {
        case TestStep::Accept:     return "accept";
        case TestStep::Objectives: return "objectives";
        case TestStep::TurnIn:     return "turn in";
        default:                   return "idle";
    }
}

bool PlayerbotAI::StartQuestTest(uint32 questId, uint64 requesterGuid, bool prepare, std::string* error)
{
    auto fail = [error](std::string const& reason)
    {
        if (error)
            *error = reason;
        return false;
    };

    Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
    if (!quest)
        return fail("no such quest");
    if (!_bot || !_bot->IsInWorld() || _clientControlled)
        return fail("not a bot that can run tests");
    if (IsQuestTesting())
        return fail("already running a test");
    if (_bot->GetGroup())
        return fail("the bot is in a group");
    if (_bot->GetMap()->Instanceable() || _bot->IsInCombat() || _bot->IsBeingTeleported() || !_bot->IsAlive())
        return fail("the bot is busy (instance, combat, teleport or dead)");
    if (_bot->InBattleground() || _bot->InBattlegroundQueue())
        return fail("the bot is queued for a battleground or arena");
    if (!sBotSpawnIndex->IsLoaded())
        return fail("the spawn index is not loaded yet");

    // Everything that cannot be fixed is checked before the bot is changed.
    bool const random = sPlayerbotMgr->IsRandomBot(_bot->GetGUID());
    bool const hasQuest = _bot->GetQuestStatus(questId) != QUEST_STATUS_NONE || _bot->IsQuestRewarded(questId);
    if (hasQuest && !random)
        return fail("the bot already has or has finished the quest");

    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_QUEST, questId, _bot))
        return fail("the quest is disabled");
    std::string refusal = TakeQuestRefusal(_bot, quest, false, false);
    if (!refusal.empty())
        return fail(refusal);
    if (!_bot->SatisfyQuestTimed(quest, false))
        return fail("the bot is on another timed quest");
    if (_bot->FindQuestSlot(questId) >= MAX_QUEST_LOG_SIZE && !_bot->SatisfyQuestLog(false))
        return fail("the quest log is full");

    bool const wrongLevel = !_bot->SatisfyQuestLevel(quest, false);
    if (wrongLevel && !(prepare && random))
        return fail(TakeQuestRefusal(_bot, quest, false, true));

    // A test starts from a clean log entry so it can be repeated.
    if (hasQuest)
    {
        AbandonQuest(questId);
        _bot->RemoveRewardedQuest(questId);
    }
    _abandonedQuests.erase(questId);

    if (wrongLevel)
    {
        uint32 level = quest->GetMinLevel();
        if (quest->GetQuestLevel() > int32(level))
            level = uint32(quest->GetQuestLevel());
        level = std::max<uint32>(1, std::min<uint32>(level, uint32(sWorld->getIntConfig(WorldIntConfigs::CONFIG_MAX_PLAYER_LEVEL))));
        if (level != _bot->getLevel())
        {
            _bot->GiveLevel(uint8(level));
            _bot->SetUInt32Value(PLAYER_FIELD_XP, 0);
            sPlayerbotMgr->InitializeBot(_bot);
        }
    }

    if (!_bot->CanTakeQuest(quest, false))
    {
        refusal = TakeQuestRefusal(_bot, quest);
        return fail(refusal.empty() ? "the server refuses the quest" : refusal);
    }
    if (!_bot->CanAddQuest(quest, false))
        return fail("the quest log or bags are full");

    _test = QuestTest();
    _test.questId = questId;
    _test.requester = requesterGuid;
    _test.startedMs = getMSTime();
    _test.savedStrategies = _strategies;

    // Quest strategy on, grind off: the bot only fights for the test quest.
    _strategies.ChangeStrategy("+quests,-grind,-follow,-stay", BotState::NonCombat);
    _strategies.Remove("grind", BotState::Combat);
    SyncFlagsFromStrategies();
    ClearTravelDestination();
    ClearForcedTarget();

    std::string failure;
    if (!BeginTestStep(TestStep::Accept, failure))
        FinishQuestTest(BotTestOutcome::Fail, failure);
    return true;
}

void PlayerbotAI::CancelQuestTest()
{
    if (!IsQuestTesting())
        return;

    uint32 const questId = _test.questId;
    _strategies = _test.savedStrategies;
    _test = QuestTest();

    ClearTravelDestination();
    _pendingTeleport.active = false;
    if (_bot && _bot->FindQuestSlot(questId) < MAX_QUEST_LOG_SIZE)
        AbandonQuest(questId);

    SyncFlagsFromStrategies();
}

void PlayerbotAI::FinishQuestTest(BotTestOutcome outcome, std::string const& message)
{
    if (!IsQuestTesting())
        return;

    BotTestResult result;
    result.questId = _test.questId;
    result.outcome = outcome;
    result.bot = _bot ? _bot->GetName() : std::string();
    result.message = message;
    result.seconds = getMSTimeDiff(_test.startedMs, getMSTime()) / IN_MILLISECONDS;
    result.requester = _test.requester;

    CancelQuestTest();
    sBotTestMgr->Report(result);
}

bool PlayerbotAI::BeginTestStep(TestStep step, std::string& failure)
{
    Quest const* quest = sObjectMgr->GetQuestTemplate(_test.questId);
    if (!quest)
    {
        failure = "the quest template is gone";
        return false;
    }

    _test.step = step;
    _test.stepMs = 0;
    _test.idleMs = 0;
    _test.signature = QuestProgressSignature(quest);
    ClearTravelDestination();

    if (step == TestStep::Objectives)
        return true;

    bool const ender = step == TestStep::TurnIn;
    bool anyRelation = false;
    if (!FindQuestGiverSpawn(quest, ender, _test.giverEntry, _test.giverIsObject, _test.giverSpawn, anyRelation))
    {
        std::ostringstream out;
        if (!anyRelation && ender && IsSelfTurnIn(quest))
        {
            // Handed in from the quest log, with the player as the quest giver.
            uint32 const reward = BestRewardItem(quest);
            if (_bot->CanRewardQuest(quest, reward, false))
            {
                _bot->RewardQuest(quest, reward, _bot, true);
                _test.giverEntry = 0;
                return true;
            }
            failure = "turn in: the reward cannot be given (bags full, or the quest items are missing)";
            return false;
        }
        if (!anyRelation)
        {
            sBotFindings->Record(ender ? BotFindingType::QuestNoEnder : BotFindingType::QuestNoStarter,
                _test.questId, 0, _bot);
            out << (ender ? "turn in: no creature or object ends the quest"
                : "accept: no creature or object starts the quest");
            if (!ender && quest->GetSrcItemId())
                out << " (it starts from item " << quest->GetSrcItemId() << ')';
        }
        else
        {
            sBotFindings->Record(ender ? BotFindingType::QuestEnderNoSpawn : BotFindingType::QuestStarterNoSpawn,
                _test.questId, _test.giverEntry, _bot);
            out << (ender ? "turn in: ender " : "accept: starter ")
                << EntryLabel(_test.giverEntry, _test.giverIsObject) << " has no spawn the bot can use";
        }
        failure = out.str();
        return false;
    }

    // Already next to it (the usual case for a turn-in at the starter).
    if (_test.giverSpawn.mapId == _bot->GetMapId()
        && _bot->GetExactDist(_test.giverSpawn.x, _test.giverSpawn.y, _test.giverSpawn.z) <= INTERACTION_DISTANCE)
        return true;

    if (!TravelToSpawn(_test.giverSpawn))
    {
        std::ostringstream out;
        out << GetTestStepName() << ": cannot travel to " << EntryLabel(_test.giverEntry, _test.giverIsObject)
            << " on map " << _test.giverSpawn.mapId;
        failure = out.str();
        return false;
    }
    return true;
}

Object* PlayerbotAI::FindTestGiver() const
{
    if (_test.giverIsObject)
        return _bot->FindNearestGameObject(_test.giverEntry, GIVER_SEARCH_RANGE);
    return _bot->FindNearestCreature(_test.giverEntry, GIVER_SEARCH_RANGE, true);
}

bool PlayerbotAI::UpdateQuestTest(uint32 elapsed)
{
    if (!IsQuestTesting() || !_bot)
        return false;

    Quest const* quest = sObjectMgr->GetQuestTemplate(_test.questId);
    if (!quest)
    {
        FinishQuestTest(BotTestOutcome::Fail, "the quest template is gone");
        return true;
    }

    if (_bot->GetGroup())
    {
        FinishQuestTest(BotTestOutcome::Skipped, std::string(GetTestStepName()) + ": the bot was invited into a group");
        return true;
    }

    if (getMSTimeDiff(_test.startedMs, getMSTime()) > TEST_TOTAL_TIMEOUT_MS)
    {
        FinishQuestTest(BotTestOutcome::Fail, std::string(GetTestStepName()) + ": the test ran out of time");
        return true;
    }

    // Fighting, traveling and teleports are the normal AI's job.
    if (_pendingTeleport.active || _bot->IsBeingTeleported())
        return true;
    if (_bot->IsInCombat() || !_bot->getAttackers().empty())
        return false;

    _test.stepMs += elapsed;
    std::string failure;

    if (_test.step == TestStep::Objectives)
    {
        QuestStatus const status = _bot->GetQuestStatus(_test.questId);
        if (status == QUEST_STATUS_COMPLETE)
        {
            if (!BeginTestStep(TestStep::TurnIn, failure))
                FinishQuestTest(BotTestOutcome::Fail, failure);
            return true;
        }
        if (status != QUEST_STATUS_INCOMPLETE)
        {
            FinishQuestTest(BotTestOutcome::Fail, "objectives: the quest failed or left the log");
            return true;
        }

        bool supported = false;
        uint32 objectId = 0;
        std::string const objective = DescribeOpenObjective(quest, supported, objectId);
        if (!supported)
        {
            FinishQuestTest(BotTestOutcome::Skipped, "objectives: a bot cannot do this one - " + objective);
            return true;
        }

        uint32 const signature = QuestProgressSignature(quest);
        if (signature != _test.signature)
        {
            _test.signature = signature;
            _test.idleMs = 0;
        }
        else
            _test.idleMs += elapsed;

        // No spawn is not a failure yet: the quest may summon what has to be killed.
        BotSpawn spawn;
        bool const haveSpawn = FindObjectiveSpawn(quest, spawn);

        if (_test.idleMs >= sPlayerbotMgr->GetTestObjectiveTimeoutMs())
        {
            std::ostringstream out;
            out << "objectives: no progress in " << (_test.idleMs / IN_MILLISECONDS) << "s on - " << objective;
            if (!haveSpawn)
                out << " (nothing for it is spawned)";
            if (_test.killsWithoutCredit)
                out << " (" << _test.killsWithoutCredit << " kill(s) gave no credit)";
            sBotFindings->Record(haveSpawn ? BotFindingType::QuestStalled : BotFindingType::QuestObjectiveNoSpawn,
                _test.questId, objectId, _bot, objective);
            FinishQuestTest(BotTestOutcome::Fail, out.str());
            return true;
        }

        // Objects to use and NPCs to talk to that are in reach.
        if (HandleQuestObjects())
            return true;

        // The combat engine pulls objective mobs within its hunt radius; from
        // farther away the test brings the bot to the nearest spawn.
        if (haveSpawn && !HasTravelDestination() && !SelectQuestObjectiveTarget()
            && (spawn.mapId != _bot->GetMapId()
                || _bot->GetExactDist(spawn.x, spawn.y, spawn.z) > QUEST_HUNT_RADIUS))
        {
            if (TravelToSpawn(spawn))
                return true;
        }
        return false;
    }

    // Accept and TurnIn: get to the quest giver and use it.
    bool const ender = _test.step == TestStep::TurnIn;
    if (ender && _bot->GetQuestStatus(_test.questId) != QUEST_STATUS_COMPLETE
        && _bot->FindQuestSlot(_test.questId) >= MAX_QUEST_LOG_SIZE)
    {
        // Self turn-in already rewarded it in BeginTestStep.
        FinishQuestTest(BotTestOutcome::Pass, std::string());
        return true;
    }
    if (HasTravelDestination())
    {
        if (_test.stepMs > TEST_GIVER_TIMEOUT_MS)
        {
            sBotFindings->RecordAt(BotFindingType::PathFailed, _bot, _test.giverSpawn.x, _test.giverSpawn.y,
                _test.giverSpawn.z, "quest giver " + EntryLabel(_test.giverEntry, _test.giverIsObject));
            FinishQuestTest(BotTestOutcome::Fail, std::string(GetTestStepName()) + ": could not walk to "
                + EntryLabel(_test.giverEntry, _test.giverIsObject));
            return true;
        }
        return false;
    }

    Object* giver = FindTestGiver();
    if (!giver)
    {
        bool const atSpawn = _test.giverSpawn.mapId == _bot->GetMapId()
            && _bot->GetExactDist(_test.giverSpawn.x, _test.giverSpawn.y, _test.giverSpawn.z) <= GIVER_SEARCH_RANGE / 2;
        if (!atSpawn && _test.stepMs <= TEST_GIVER_TIMEOUT_MS)
        {
            TravelToSpawn(_test.giverSpawn);
            return true;
        }
        if (atSpawn && _test.stepMs <= TEST_GIVER_MISSING_MS)
            return true;

        if (!atSpawn)
        {
            sBotFindings->RecordAt(BotFindingType::PathFailed, _bot, _test.giverSpawn.x, _test.giverSpawn.y,
                _test.giverSpawn.z, "quest giver " + EntryLabel(_test.giverEntry, _test.giverIsObject));
            FinishQuestTest(BotTestOutcome::Fail, std::string(GetTestStepName()) + ": could not get to the spawn point of "
                + EntryLabel(_test.giverEntry, _test.giverIsObject));
            return true;
        }

        sBotFindings->Record(ender ? BotFindingType::QuestEnderMissing : BotFindingType::QuestStarterMissing,
            _test.questId, _test.giverEntry, _bot);
        FinishQuestTest(BotTestOutcome::Fail, std::string(GetTestStepName()) + ": "
            + EntryLabel(_test.giverEntry, _test.giverIsObject)
            + " is not at its spawn point (dead, despawned, or in a phase the bot is not in)");
        return true;
    }

    WorldObject* giverObject = giver->ToCreature() ? static_cast<WorldObject*>(giver->ToCreature())
        : static_cast<WorldObject*>(giver->ToGameObject());
    if (giverObject && !_bot->IsWithinDistInMap(giverObject, INTERACTION_DISTANCE))
    {
        if (_test.stepMs > TEST_GIVER_TIMEOUT_MS)
        {
            sBotFindings->RecordAt(BotFindingType::PathFailed, _bot, giverObject->GetPositionX(),
                giverObject->GetPositionY(), giverObject->GetPositionZ(),
                "quest giver " + EntryLabel(_test.giverEntry, _test.giverIsObject));
            FinishQuestTest(BotTestOutcome::Fail, std::string(GetTestStepName()) + ": could not reach "
                + EntryLabel(_test.giverEntry, _test.giverIsObject));
            return true;
        }
        MoveToPosition(giverObject->GetPositionX(), giverObject->GetPositionY(), giverObject->GetPositionZ());
        return true;
    }

    if (!ender)
    {
        if (!AcceptQuest(quest, giver))
        {
            std::string reason = "the quest did not enter the log";
            if (!giver->hasQuest(_test.questId))
                reason = "the starter does not offer the quest";
            else if (!_bot->CanInteractWithQuestGiver(giver))
                reason = "the starter cannot be interacted with (hostile, not a quest giver, or out of reach)";
            else if (!_bot->CanTakeQuest(quest, false))
            {
                reason = TakeQuestRefusal(_bot, quest);
                if (reason.empty())
                    reason = "the server refuses the quest";
            }
            sBotFindings->Record(BotFindingType::QuestAcceptFailed, _test.questId, 0, _bot, reason);
            FinishQuestTest(BotTestOutcome::Fail, "accept: " + reason);
            return true;
        }

        if (_bot->FindQuestSlot(_test.questId) >= MAX_QUEST_LOG_SIZE)
        {
            FinishQuestTest(BotTestOutcome::Pass, "completed on accept");
            return true;
        }
        if (!BeginTestStep(TestStep::Objectives, failure))
            FinishQuestTest(BotTestOutcome::Fail, failure);
        return true;
    }

    if (!TurnInQuest(quest, giver))
    {
        std::string reason = "the quest stayed in the log";
        if (!giver->hasInvolvedQuest(_test.questId))
            reason = "the ender does not take the quest";
        else if (!_bot->CanInteractWithQuestGiver(giver))
            reason = "the ender cannot be interacted with (hostile, not a quest giver, or out of reach)";
        else if (!_bot->CanRewardQuest(quest, BestRewardItem(quest), false))
            reason = "the reward cannot be given (bags full, or the quest items are missing)";
        sBotFindings->Record(BotFindingType::QuestTurnInFailed, _test.questId, 0, _bot, reason);
        FinishQuestTest(BotTestOutcome::Fail, "turn in: " + reason);
        return true;
    }

    FinishQuestTest(BotTestOutcome::Pass, std::string());
    return true;
}
