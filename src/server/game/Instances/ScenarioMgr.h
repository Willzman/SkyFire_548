/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

#ifndef SKYFIRE_SCENARIOMGR_H
#define SKYFIRE_SCENARIOMGR_H

#include "Common.h"

class Player;

// Wave, medal and timer of a challenge scenario (Proving Grounds) for SMSG_SCENARIO_STATE.
struct ScenarioChallenge
{
    uint32 CurWave;
    uint32 MaxWave;
    uint32 Medal;   // ChallengeMedals
    uint32 Timer;   // seconds

    ScenarioChallenge(uint32 curWave, uint32 maxWave, uint32 medal, uint32 timer) : CurWave(curWave), MaxWave(maxWave), Medal(medal), Timer(timer) { }
};

class ScenarioMgr
{
private:
    ScenarioMgr() { }
    ~ScenarioMgr() { }

public:
    static ScenarioMgr* Instance()
    {
        static ScenarioMgr instance;
        return &instance;
    }

    uint32 GetScenarioIdForMap(uint32 map) const;
    uint32 GetCriteriaIdForScenarioStep(uint32 map, uint32 step, uint32 scenarioId = 0) const;

    // Maps hosting several scenarios (Isle of Thunder) need the criteria tree and scenario passed explicitly.
    void SendScenarioState(Player* player, uint32 map, int32 step, uint32 startTime, uint32 miscCriteriaTreeId = 0, uint32 scenarioId = 0, uint32 bonusData = 0,
        ScenarioChallenge const* challengeData = NULL);
};

#define sScenarioMgr ScenarioMgr::Instance()

#endif
