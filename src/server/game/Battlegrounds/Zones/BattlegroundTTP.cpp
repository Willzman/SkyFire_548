/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* The Tiger's Peak arena (5.x), ported from Legends of Azeroth Pandaria 5.4.8 (GPL v2).
*/

#include "BattlegroundTTP.h"
#include "Language.h"
#include "Object.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "WorldPacket.h"

BattlegroundTTP::BattlegroundTTP()
{
    BgObjects.resize(BG_TTP_OBJECT_MAX);

    StartDelayTimes[BG_STARTING_EVENT_FIRST] = BG_START_DELAY_1M;
    StartDelayTimes[BG_STARTING_EVENT_SECOND] = BG_START_DELAY_30S;
    StartDelayTimes[BG_STARTING_EVENT_THIRD] = BG_START_DELAY_15S;
    StartDelayTimes[BG_STARTING_EVENT_FOURTH] = BG_START_DELAY_NONE;
    //we must set messageIds
    StartMessageIds[BG_STARTING_EVENT_FIRST] = LANG_ARENA_ONE_MINUTE;
    StartMessageIds[BG_STARTING_EVENT_SECOND] = LANG_ARENA_THIRTY_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_THIRD] = LANG_ARENA_FIFTEEN_SECONDS;
    StartMessageIds[BG_STARTING_EVENT_FOURTH] = LANG_ARENA_HAS_BEGUN;
}

void BattlegroundTTP::StartingEventCloseDoors()
{
    for (uint32 i = BG_TTP_OBJECT_DOOR_1; i <= BG_TTP_OBJECT_DOOR_2; ++i)
        SpawnBGObject(i, RESPAWN_IMMEDIATELY);

    for (uint32 i = BG_TTP_OBJECT_BUFF_1; i <= BG_TTP_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, RESPAWN_ONE_DAY);
}

void BattlegroundTTP::StartingEventOpenDoors()
{
    for (uint32 i = BG_TTP_OBJECT_DOOR_1; i <= BG_TTP_OBJECT_DOOR_2; ++i)
        DoorOpen(i);

    for (uint32 i = BG_TTP_OBJECT_BUFF_1; i <= BG_TTP_OBJECT_BUFF_2; ++i)
        SpawnBGObject(i, 60);
}

void BattlegroundTTP::AddPlayer(Player* player)
{
    Battleground::AddPlayer(player);
    PlayerScores[player->GetGUID()] = new BattlegroundScore;
    UpdateArenaWorldState();
}

void BattlegroundTTP::RemovePlayer(Player* /*player*/, uint64 /*guid*/, uint32 /*team*/)
{
    if (GetStatus() == STATUS_WAIT_LEAVE)
        return;

    UpdateArenaWorldState();
    CheckArenaWinConditions();
}

void BattlegroundTTP::HandleKillPlayer(Player* player, Player* killer)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    if (!killer)
    {
        SF_LOG_ERROR("bg.battleground", "BattlegroundTTP: Killer player not found");
        return;
    }

    Battleground::HandleKillPlayer(player, killer);

    UpdateArenaWorldState();
    CheckArenaWinConditions();
}

bool BattlegroundTTP::HandlePlayerUnderMap(Player* player)
{
    player->TeleportTo(GetMapId(), 567.313843f, 632.106384f, 380.703339f, player->GetOrientation(), false);
    return true;
}

void BattlegroundTTP::HandleAreaTrigger(Player* player, uint32 trigger)
{
    if (GetStatus() != STATUS_IN_PROGRESS)
        return;

    switch (trigger)
    {
        case 4536:
        case 4537:
            break;
        default:
            Battleground::HandleAreaTrigger(player, trigger);
            break;
    }
}

void BattlegroundTTP::FillInitialWorldStates(WorldStateBuilder& builder)
{
    builder.AppendState(0xE1A, 1);
    UpdateArenaWorldState();
}

void BattlegroundTTP::Reset()
{
    //call parent's class reset
    Battleground::Reset();
}

bool BattlegroundTTP::SetupBattleground()
{
    // gates
    if (!AddObject(BG_TTP_OBJECT_DOOR_1, BG_TTP_OBJECT_TYPE_DOOR_1, 502.414f, 633.099f, 380.706f, 0.0308292f, 0.0f, 0.0f, 0.015414f, 0.999881f, RESPAWN_IMMEDIATELY)
        || !AddObject(BG_TTP_OBJECT_DOOR_2, BG_TTP_OBJECT_TYPE_DOOR_2, 632.891f, 633.059f, 380.705f, 3.12778f, 0.0f, 0.0f, 0.999976f, 0.0069045f, RESPAWN_IMMEDIATELY)
        // buffs
        || !AddObject(BG_TTP_OBJECT_BUFF_1, BG_TTP_OBJECT_TYPE_BUFF_1, 566.788f, 602.743f, 383.68f, 1.5724f, 0.0f, 0.0f, 0.707673f, 0.70654f, 120)
        || !AddObject(BG_TTP_OBJECT_BUFF_2, BG_TTP_OBJECT_TYPE_BUFF_2, 566.661f, 664.311f, 383.681f, 4.66374f, 0.0f, 0.0f, 0.724097f, -0.689698f, 120))
    {
        SF_LOG_ERROR("sql.sql", "BattlegroundTTP: Failed to spawn some object!");
        return false;
    }

    return true;
}
