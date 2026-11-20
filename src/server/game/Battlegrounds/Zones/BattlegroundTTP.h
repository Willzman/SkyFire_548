/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* The Tiger's Peak arena (5.x), ported from Legends of Azeroth Pandaria 5.4.8 (GPL v2),
* src/server/game/Battlegrounds/Zones/BattlegroundTTP.*, written in the style of BattlegroundTV.
*/

#ifndef SF_BATTLEGROUNDTTP_H
#define SF_BATTLEGROUNDTTP_H

#include "Battleground.h"

enum BattlegroundTTPObjectTypes
{
    BG_TTP_OBJECT_DOOR_1 = 0,
    BG_TTP_OBJECT_DOOR_2 = 1,
    BG_TTP_OBJECT_BUFF_1 = 2,
    BG_TTP_OBJECT_BUFF_2 = 3,
    BG_TTP_OBJECT_MAX = 4
};

enum BattlegroundTTPObjects
{
    BG_TTP_OBJECT_TYPE_DOOR_1 = 212921,
    BG_TTP_OBJECT_TYPE_DOOR_2 = 212921,
    BG_TTP_OBJECT_TYPE_BUFF_1 = 184663,
    BG_TTP_OBJECT_TYPE_BUFF_2 = 184664
};

class BattlegroundTTP : public Battleground
{
public:
    BattlegroundTTP();
    ~BattlegroundTTP() { }

    /* inherited from BattlegroundClass */
    void AddPlayer(Player* player) OVERRIDE;
    void StartingEventCloseDoors() OVERRIDE;
    void StartingEventOpenDoors() OVERRIDE;

    void RemovePlayer(Player* player, uint64 guid, uint32 team) OVERRIDE;
    void HandleAreaTrigger(Player* Source, uint32 Trigger) OVERRIDE;
    bool SetupBattleground() OVERRIDE;
    void Reset() OVERRIDE;
    void FillInitialWorldStates(WorldStateBuilder& builder) OVERRIDE;
    void HandleKillPlayer(Player* player, Player* killer) OVERRIDE;
    bool HandlePlayerUnderMap(Player* player) OVERRIDE;
};
#endif
