/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

/*
 * Ported from TrinityCore cata_classic instance_razorfen_downs.cpp (GPL v2 or later).
 */

#include "ScriptMgr.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "Map.h"
#include "MotionMaster.h"
#include "razorfen_downs.h"
#include "TemporarySummon.h"

namespace
{

Position const PosSummonTutenkash[15] =
{
    // 7349 Tomb Fiend
    { 2487.339f, 805.9111f, 43.08361f, 2.844887f  },
    { 2485.405f, 804.1145f, 43.68511f, 3.054326f  },
    { 2488.431f, 801.2809f, 42.70374f, 4.29351f   },
    { 2489.914f, 804.7949f, 43.25175f, 1.658063f  },
    { 2541.246f, 907.0941f, 46.64201f, 2.024582f  },
    { 2544.701f, 907.6331f, 46.38007f, 1.605703f  },
    { 2541.49f,  911.1756f, 46.26493f, 4.817109f  },
    { 2544.693f, 912.8887f, 46.39912f, 2.129302f  },
    { 2524.036f, 834.4852f, 48.37031f, 0.8028514f },
    { 2527.017f, 829.9793f, 48.06498f, 0.6981317f },
    // 7351 Tomb Reaver
    { 2542.818f, 904.9359f, 46.80911f, 4.642576f  },
    { 2543.287f, 911.2448f, 46.32785f, 0.6806784f },
    { 2489.083f, 806.5914f, 43.21102f, 3.682645f  },
    { 2486.828f, 802.8737f, 43.19883f, 2.9147f    },
    // 7355 Tuten'kash
    { 2487.939f, 804.2224f, 43.10735f, 1.692969f  }
};

} // namespace

class instance_razorfen_downs : public InstanceMapScript
{
public:
    instance_razorfen_downs() : InstanceMapScript(RFDScriptName, 129) { }

    struct instance_razorfen_downs_InstanceMapScript : public InstanceScript
    {
        instance_razorfen_downs_InstanceMapScript(Map* map) : InstanceScript(map)
        {
            SetBossNumber(EncounterCount);
            goGongGUID = 0;
            gongWave = 0;
            fiendsKilled = 0;
            reaversKilled = 0;
            summonLowRange = 0;
            summonHighRange = 0;
            summonCreature = 0;
        }

        void OnGameObjectCreate(GameObject* gameObject) override
        {
            switch (gameObject->GetEntry())
            {
                case GO_GONG:
                    goGongGUID = gameObject->GetGUID();
                    if (GetBossState(DATA_TUTEN_KASH) == DONE)
                        gameObject->SetFlag(GAMEOBJECT_FIELD_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    break;
                case GO_IDOL_OVEN_FIRE:
                case GO_IDOL_CUP_FIRE:
                case GO_IDOL_MOUTH_FIRE:
                    if (GetBossState(DATA_EXTINGUISHING_THE_IDOL) == DONE)
                        gameObject->Delete();
                    break;
                default:
                    break;
            }
        }

        void SetData(uint32 type, uint32 data) override
        {
            if (type != DATA_WAVE)
                return;

            switch (data)
            {
                case IN_PROGRESS:
                {
                    if (gongWave > 2)
                        break;

                    GameObject* go = instance->GetGameObject(goGongGUID);
                    if (!go)
                        break;

                    go->SetFlag(GAMEOBJECT_FIELD_FLAGS, GO_FLAG_NOT_SELECTABLE);

                    switch (gongWave)
                    {
                        case 0:
                            summonLowRange = 0;
                            summonHighRange = 10;
                            summonCreature = NPC_TOMB_FIEND;
                            break;
                        case 1:
                            summonLowRange = 10;
                            summonHighRange = 14;
                            summonCreature = NPC_TOMB_REAVER;
                            break;
                        case 2:
                            summonLowRange = 14;
                            summonHighRange = 15;
                            summonCreature = NPC_TUTEN_KASH;
                            break;
                    }

                    for (uint8 i = summonLowRange; i < summonHighRange; ++i)
                        if (Creature* creature = go->SummonCreature(summonCreature, PosSummonTutenkash[i]))
                            creature->GetMotionMaster()->MovePoint(0, 2533.479f + float(irand(-5, 5)), 870.020f + float(irand(-5, 5)), 47.678f);

                    ++gongWave;
                    break;
                }
                case NPC_TOMB_FIEND:
                    if (++fiendsKilled == 10)
                    {
                        fiendsKilled = 0;
                        if (GameObject* go = instance->GetGameObject(goGongGUID))
                            go->RemoveFlag(GAMEOBJECT_FIELD_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    }
                    break;
                case NPC_TOMB_REAVER:
                    if (++reaversKilled == 4)
                    {
                        reaversKilled = 0;
                        if (GameObject* go = instance->GetGameObject(goGongGUID))
                            go->RemoveFlag(GAMEOBJECT_FIELD_FLAGS, GO_FLAG_NOT_SELECTABLE);
                    }
                    break;
                default:
                    break;
            }
        }

        uint64 GetData64(uint32 type) const override
        {
            if (type == DATA_GONG)
                return goGongGUID;
            return 0;
        }

        std::string GetSaveData() override
        {
            OUT_SAVE_INST_DATA;

            std::ostringstream saveStream;
            saveStream << "R D " << GetBossSaveData();

            OUT_SAVE_INST_DATA_COMPLETE;
            return saveStream.str();
        }

        void Load(char const* in) override
        {
            if (!in)
            {
                OUT_LOAD_INST_DATA_FAIL;
                return;
            }

            OUT_LOAD_INST_DATA(in);

            char dataHead1, dataHead2;
            std::istringstream loadStream(in);
            loadStream >> dataHead1 >> dataHead2;

            if (dataHead1 == 'R' && dataHead2 == 'D')
            {
                for (uint32 i = 0; i < EncounterCount; ++i)
                {
                    uint32 tmpState;
                    loadStream >> tmpState;
                    if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                        tmpState = NOT_STARTED;
                    SetBossState(i, EncounterState(tmpState));
                }

                // The gong is only clickable again after Tuten'kash's wave if he is still alive.
                if (GetBossState(DATA_TUTEN_KASH) == DONE)
                    gongWave = 3;
            }
            else
                OUT_LOAD_INST_DATA_FAIL;

            OUT_LOAD_INST_DATA_COMPLETE;
        }

    protected:
        uint64 goGongGUID;
        uint16 gongWave;
        uint8  fiendsKilled;
        uint8  reaversKilled;
        uint8  summonLowRange;
        uint8  summonHighRange;
        uint32 summonCreature;
    };

    InstanceScript* GetInstanceScript(InstanceMap* map) const override
    {
        return new instance_razorfen_downs_InstanceMapScript(map);
    }
};

void AddSC_instance_razorfen_downs()
{
    new instance_razorfen_downs();
}
