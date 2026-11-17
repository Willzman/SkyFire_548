/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Playerbots module - quest objectives that are not kills.
*
* Use an object (goober credit), open a chest that holds a quest item, talk
* to an NPC. The bot does what the client opcode handlers do: GameObject::Use
* and the loot it opens, or gossip hello plus the first plain gossip option.
* Modeled on mod-playerbots' quest interaction (NewRpgBaseAction); the code is
* written against SkyFire's 5.4.8 objective data.
*/

#include "PlayerbotAI.h"
#include "PlayerbotMgr.h"
#include "BotFindings.h"
#include "BotSpawnIndex.h"
#include "engine/BotMovement.h"
#include "Creature.h"
#include "CreatureAI.h"
#include "GameObject.h"
#include "GossipDef.h"
#include "LootMgr.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "QuestDef.h"
#include "ScriptMgr.h"
#include "WorldSession.h"

namespace
{
    // Same reach as the pull radius for quest mobs (BOT_QUEST_HUNT_RADIUS).
    float const QUEST_OBJECT_RANGE = 40.0f;
    // An object or NPC just used is left alone this long (cast bars, respawn, scripted events).
    uint32 const QUEST_OBJECT_RETRY_MS = 10 * IN_MILLISECONDS;
    // Uses in a row that changed nothing before the entry is given up on.
    uint8 const QUEST_OBJECT_MAX_TRIES = 3;
    uint8 const QUEST_OBJECT_GIVEN_UP = 0xFF;
    // AI ticks (500 ms) spent walking to one object before it is left alone for a while.
    uint32 const QUEST_OBJECT_APPROACH_TICKS = 60;
    uint32 const QUEST_OBJECT_UNREACHABLE_MS = 2 * MINUTE * IN_MILLISECONDS;

    uint16 ObjectiveNeed(QuestObjective const* objective)
    {
        return uint16(objective->Amount > 0 ? objective->Amount : 1);
    }
}

void PlayerbotAI::CollectQuestInteractTargets(std::vector<QuestInteractTarget>& out) const
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

            QuestInteractTarget target;
            target.questId = questId;
            switch (objective->Type)
            {
                case QUEST_OBJECTIVE_TYPE_GO:
                case QUEST_OBJECTIVE_TYPE_NPC_INTERACT:
                    if (_bot->GetQuestSlotCounter(slot, objective->Index) >= ObjectiveNeed(objective))
                        continue;
                    target.entry = objective->ObjectId;
                    target.gameobject = objective->Type == QUEST_OBJECTIVE_TYPE_GO;
                    out.push_back(target);
                    break;
                case QUEST_OBJECTIVE_TYPE_ITEM:
                    if (_bot->GetItemCount(objective->ObjectId, true) >= ObjectiveNeed(objective))
                        continue;
                    target.gameobject = true;
                    target.container = true;
                    for (uint32 container : sBotSpawnIndex->GetItemContainers(objective->ObjectId))
                    {
                        target.entry = container;
                        out.push_back(target);
                    }
                    break;
                default:
                    break;
            }
        }
    }
}

bool PlayerbotAI::UseQuestObject(GameObject* object)
{
    if (!object || !_bot->GetGameObjectIfCanInteractWith(object->GetGUID(), object->GetGoType()))
        return false;

    uint64 const guid = object->GetGUID();
    object->Use(_bot);

    // A chest opened its loot window: take what the bot may have and close it.
    if (_bot->GetLootGUID() != guid)
        return true;

    Loot* loot = &object->loot;
    uint32 const maxSlot = loot->GetMaxSlotInLootFor(_bot);
    for (uint32 slot = 0; slot < maxSlot; ++slot)
    {
        LootItem* item = loot->LootItemInSlot(slot, _bot);
        if (!item || item->is_blocked)
            continue;
        ItemPosCountVec dest;
        if (_bot->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, item->itemid, item->count) != EQUIP_ERR_OK)
            continue;
        _bot->StoreLootItem(uint8(slot), loot, guid);
    }
    _bot->GetSession()->DoLootRelease(guid);
    return true;
}

bool PlayerbotAI::TalkToQuestNpc(Creature* npc, uint32 questId)
{
    if (!npc || !_bot->PlayerTalkClass || !_bot->GetNPCIfCanInteractWith(npc->GetGUID(), UNIT_NPC_FLAG_NONE))
        return false;
    Quest const* quest = sObjectMgr->GetQuestTemplate(questId);
    if (!quest)
        return false;

    // Gossip hello, as WorldSession::HandleGossipHelloOpcode does it.
    uint32 const before = QuestProgressSignature(quest);
    _bot->PlayerTalkClass->ClearMenus();
    if (!sScriptMgr->OnGossipHello(_bot, npc) && !npc->AI()->OnGossipHello(_bot))
    {
        _bot->TalkedToCreature(npc->GetEntry(), npc->GetGUID());
        _bot->PrepareGossipMenu(npc, npc->GetCreatureTemplate()->GossipMenuId, true);
    }
    if (QuestProgressSignature(quest) != before)
        return true;

    // Credit often sits behind the first conversation option.
    GossipMenu& menu = _bot->PlayerTalkClass->GetGossipMenu();
    for (auto const& kv : menu.GetMenuItems())
    {
        GossipMenuItem const& item = kv.second;
        if (item.OptionType != GOSSIP_OPTION_GOSSIP || item.IsCoded || item.MenuItemIcon == GOSSIP_ICON_TRAINER)
            continue;

        uint32 const listId = kv.first;
        uint32 const menuId = menu.GetMenuId();
        npc->AI()->sGossipSelect(_bot, menuId, listId);
        if (!sScriptMgr->OnGossipSelect(_bot, npc, _bot->PlayerTalkClass->GetGossipOptionSender(listId),
            _bot->PlayerTalkClass->GetGossipOptionAction(listId)))
            _bot->OnGossipSelect(npc, listId, menuId);
        break;
    }
    _bot->PlayerTalkClass->SendCloseGossip();
    return true;
}

bool PlayerbotAI::HandleQuestObjects()
{
    if (!_bot || _clientControlled || !_bot->IsAlive())
        return false;
    if (_bot->IsInCombat() || !_bot->getAttackers().empty() || BotMovement::IsCasting(_bot))
        return false;

    std::vector<QuestInteractTarget> targets;
    CollectQuestInteractTargets(targets);
    if (targets.empty())
        return false;

    uint32 const now = getMSTime();
    if (_questObjectRetry.size() > 200)
        _questObjectRetry.clear();

    WorldObject* best = nullptr;
    QuestInteractTarget bestTarget;
    float bestDist = QUEST_OBJECT_RANGE;
    for (QuestInteractTarget const& target : targets)
    {
        auto const tries = _questInteractTries.find(target.entry);
        if (tries != _questInteractTries.end() && tries->second.tries == QUEST_OBJECT_GIVEN_UP)
            continue;

        WorldObject* object = nullptr;
        if (target.gameobject)
        {
            GameObject* go = _bot->FindNearestGameObject(target.entry, QUEST_OBJECT_RANGE);
            if (go && go->isSpawned() && go->getLootState() == LootState::GO_READY && go->ActivateToQuest(_bot))
                object = go;
        }
        else
            object = _bot->FindNearestCreature(target.entry, QUEST_OBJECT_RANGE, true);
        if (!object)
            continue;

        auto const retry = _questObjectRetry.find(object->GetGUID());
        if (retry != _questObjectRetry.end() && int32(retry->second - now) > 0)
            continue;

        float const dist = _bot->GetDistance(object);
        if (dist >= bestDist)
            continue;
        bestDist = dist;
        best = object;
        bestTarget = target;
    }
    if (!best)
        return false;

    if (!_bot->IsWithinDistInMap(best, INTERACTION_DISTANCE))
    {
        // Behind a door, up a ledge: stop trying for a while instead of standing there.
        if (_questApproachGuid != best->GetGUID())
        {
            _questApproachGuid = best->GetGUID();
            _questApproachTicks = 0;
        }
        if (++_questApproachTicks > QUEST_OBJECT_APPROACH_TICKS)
        {
            _questApproachGuid = 0;
            _questObjectRetry[best->GetGUID()] = now + QUEST_OBJECT_UNREACHABLE_MS;
            sBotFindings->RecordAt(BotFindingType::PathFailed, _bot, best->GetPositionX(), best->GetPositionY(),
                best->GetPositionZ(), "quest object or NPC the bot could not walk to");
            return false;
        }
        if (_bot->GetMotionMaster()->GetCurrentMovementGeneratorType() != POINT_MOTION_TYPE)
            MoveToPosition(best->GetPositionX(), best->GetPositionY(), best->GetPositionZ());
        return true;
    }

    Quest const* quest = sObjectMgr->GetQuestTemplate(bestTarget.questId);
    if (!quest)
        return false;

    // The last use of this entry is judged now: scripted credit can arrive late.
    QuestInteractTries& state = _questInteractTries[bestTarget.entry];
    uint32 const signature = QuestProgressSignature(quest);
    if (bestTarget.container)
        state.tries = 0;
    else if (state.tries && state.signature == signature)
    {
        if (state.tries >= QUEST_OBJECT_MAX_TRIES)
        {
            state.tries = QUEST_OBJECT_GIVEN_UP;
            sBotFindings->Record(BotFindingType::QuestInteractNoCredit, bestTarget.questId, bestTarget.entry, _bot,
                bestTarget.gameobject ? "used the object" : "talked to the NPC");
            return false;
        }
    }
    else
        state.tries = 0;

    _questApproachGuid = 0;
    TryDismount();
    BotMovement::StopAndIdle(_bot);
    _bot->SetFacingToObject(best);

    bool const done = bestTarget.gameobject ? UseQuestObject(best->ToGameObject())
        : TalkToQuestNpc(best->ToCreature(), bestTarget.questId);
    _questObjectRetry[best->GetGUID()] = now + QUEST_OBJECT_RETRY_MS;
    if (!done)
        return false;

    ++state.tries;
    state.signature = signature;
    ClearTravelDestination();
    return true;
}
