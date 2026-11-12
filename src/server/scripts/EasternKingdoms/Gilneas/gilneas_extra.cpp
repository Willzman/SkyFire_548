/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

// Later Gilneas quests, ported from upstream SkyFire (gilneas branch, based on Legends of Azeroth).
// Only the scripts for content that gilneas.cpp does not already cover are kept here; the
// classes live in an unnamed namespace so they cannot clash with gilneas.cpp.

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedEscortAI.h"
#include "PassiveAI.h"
#include "Vehicle.h"
#include "DBCStores.h"
#include "EventProcessor.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "SharedDefines.h"
#include "SpellMgr.h"
#include "SpellScript.h"
#include "Util.h"
#include <functional>
#include <list>

namespace
{

template<class AI>
class gilneas_creature_script : public CreatureScript
{
public:
    gilneas_creature_script(char const* name) : CreatureScript(name) { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new AI(creature);
    }
};

template<class Spell>
class gilneas_spell_script : public SpellScriptLoader
{
public:
    gilneas_spell_script(char const* name) : SpellScriptLoader(name) { }

    SpellScript* GetSpellScript() const override
    {
        return new Spell();
    }
};

class GilneasDelayedEvent : public BasicEvent
{
public:
    explicit GilneasDelayedEvent(std::function<void()> callback) : _callback(callback) { }

    bool Execute(uint64 /*eventTime*/, uint32 /*updateTime*/) override
    {
        _callback();
        return true;
    }

private:
    std::function<void()> _callback;
};

template<class Callable>
void AddGilneasDelayedEvent(Unit* owner, uint32 delay, Callable callback)
{
    owner->m_Events.AddEvent(new GilneasDelayedEvent(std::function<void()>(callback)), owner->m_Events.CalculateTime(delay));
}

static int32 irand(int32 min, int32 max)
{
    if (max <= min)
        return min;

    return min + int32(rand32() % uint32(max - min + 1));
}

static uint32 urand(uint32 min, uint32 max)
{
    if (max <= min)
        return min;

    return min + rand32() % (max - min + 1);
}

void MoveGilneasPointPath(Creature* creature, uint32 pointId, Position const* path, uint32 count, bool generatePath = false)
{
    if (!creature || !path || !count)
        return;

    creature->GetMotionMaster()->MovePoint(pointId, path[count - 1], generatePath);
}

enum Gilneas
{
    SPELL_PING_GILNEAN_CROW = 93275,
    SPELL_SUMMON_RAVENOUS_WORGEN_1 = 66836,
    SPELL_SUMMON_RAVENOUS_WORGEN_2 = 66925,
    SPELL_SHOOT_INSTAKILL = 67593, // Visual problem
    SPELL_COSMETIC_ATTACK = 69873,
    SPELL_PULL_TO = 67357,
    SPELL_GET_SHOT = 67349,

    EVENT_START_TALK_WITH_CITIZEN = 1,
    EVENT_TALK_WITH_CITIZEN_1 = 2,
    EVENT_TALK_WITH_CITIZEN_2 = 3,
    EVENT_TALK_WITH_CITIZEN_3 = 4,

    EVENT_START_DIALOG = 1,
    EVENT_START_TALK_TO_GUARD = 2,
    EVENT_TALK_TO_GUARD_1 = 3,
    EVENT_TALK_TO_GUARD_2 = 4,
    EVENT_RESET_DIALOG = 5,

    PRINCE_LIAM_GREYMANE_TEXT_00 = 0,
    PRINCE_LIAM_GREYMANE_TEXT_01 = 1,
    PRINCE_LIAM_GREYMANE_TEXT_02 = 2,

    EVENT_JUMP_TO_PRISON = 1,
    EVENT_AGGRO_PLAYER = 2,
    EVENT_FORCE_DESPAWN = 3,

    EVENT_COSMETIC_ATTACK = 1,
    EVENT_JUMP_TO_PLAYER = 2,
    EVENT_SHOOT_JOSIAH = 3,

    PHASE_ROOF = 0,
    PHASE_COMBAT = 1,

    WORGEN_ID_ROOF_1 = 0,
    WORGEN_ID_ROOF_2 = 1,
    WORGEN_ID_ROOF_3 = 2,
    WORGEN_ID_ROOF_4 = 3,
    WORGEN_ID_ROOF_5 = 4,
    WORGEN_ID_ROOF_6 = 5,
    WORGEN_ID_ROOF_7 = 6,

    WORGEN_ID_CATHEDRAL_1 = 7,
    WORGEN_ID_CATHEDRAL_2 = 8,
    WORGEN_ID_CATHEDRAL_3 = 9,
    WORGEN_ID_CATHEDRAL_4 = 10,
    WORGEN_ID_CATHEDRAL_5 = 11,
    WORGEN_ID_CATHEDRAL_6 = 12,
    WORGEN_ID_CATHEDRAL_7 = 13,
    WORGEN_ID_CATHEDRAL_8 = 14,
    WORGEN_ID_CATHEDRAL_9 = 15,

    NPC_PANICKED_CITIZEN_GATE = 44086,
    NPC_WORGEN_RUNT = 35456,
    NPC_WORGEN_RUNT_2 = 35188,
    NPC_WORGEN_ALPHA = 35170,
    NPC_WORGEN_ALPHA_2 = 35167,
    NPC_LORNA_CROWLEY = 35378,
    NPC_GENERIC_TRIGGER_LAB = 35374,

    SAY_JOSIAH_AVERY_1 = 0,
    SAY_JOSIAH_AVERY_2 = 1,
    SAY_JOSIAH_AVERY_3 = 2,
    SAY_JOSIAH_AVERY_4 = 3,
    SAY_JOSIAH_AVERY_5 = 4,
    SAY_JOSIAH_AVERY_6 = 5,

    QUEST_FROM_THE_SHADOWS = 14204,

    NPC_GILNEAS_MASTIFF = 35631,
    NPC_BLOODFANG_LURKER = 35463,

    SPELL_SUMMON_MASTIFF = 67807,
    SPELL_ATTACK_LURKER = 67805,
    SPELL_SHADOWSTALKER_STEALTH = 5916,
    SPELL_UNDYING_FRENZY = 80515,
    SPELL_ENRAGE = 8599,

    WORGEN_ENRAGE_EMOTE = 0,

    QUEST_SAVE_KRENNAN_ARANAS = 14293,

    NPC_KRENNAN_ARANAS = 35753,
    NPC_KING_GREYMANES_HORSE = 35905,
    NPC_BLOODFANG_RIPPER = 35505,
    NPC_GILNEAS_CITY_GUARD = 35509,
    NPC_KRENNAN_ARANAS_KILL_CREDIT = 35753,

    TEXT_KRENNAN_ARANAS = 0,
    EMOTE_SAVE_KRENNAN_ARANAS = 0,
    TEXT_SAVED_KRENNAN_ARANAS = 0,

    SPELL_GUARD_SHOOT = 48424,

    SPELL_SAVE_CYNTHIA = 68597,
    SPELL_SAVE_ASHLEY = 68598,
    SPELL_SAVE_JAMES = 68596,

    PLAYER_SAY_CYNTHIA = 0,
    PLAYER_SAY_ASHLEY = 1,
    PLAYER_SAY_JAMES = 2,

    NPC_JAMES = 36289,
    NPC_CYNTHIA = 36287,
    NPC_ASHLEY = 36288,

    EVENT_TALK_TO_PLAYER = 1,
    EVENT_START_RUN = 2,
    EVENT_OPEN_DOOR = 3,
    EVENT_RESUME_RUN = 4,
    EVENT_CRY = 5,

    CHILDREN_TEXT_ID = 0,

    GO_DOOR_TO_THE_BASEMENT = 196411,

    SPELL_CATCH_CAT = 68743,
    SPELL_LUCIUS_SHOOT = 41440,

    NPC_WAHL = 36458,
    NPC_WAHL_WORGEN = 36852,
    NPC_LUCIUS_THE_CRUEL = 36461,

    SAY_THIS_CAT_IS_MINE = 0,
    YELL_DONT_MESS = 0,

    ACTION_SUMMON_LUCIUS = 1,
    ACTION_CHANCE_DESPAWN = 2,
    ACTION_CONTINUE_SCENE = 3,

    POINT_CATCH_CHANCE = 4,

    SPELL_ROUND_UP_HORSE = 68908,
    SPELL_ROPE_CHANNEL = 68940,

    EVENT_CHECK_LORNA = 1,
    EVENT_CHECK_OWNER = 2,

    NPC_LORNA_CROWLEY_2 = 36457,

    QUEST_THE_HUNGRY_ETTIN = 14416,

    QUEST_CREDIT_HORSE = 36560,

    MUSIC_ENTRY_TELESCOPE = 23539,
    PLAY_CINEMATIC_TELESCOPE = 167,

    QUEST_ENTRY_EXODUS = 24438,

    NPC_STAGECOACH_HARNESS = 38755,
    NPC_HARNESS_SUMMONED = 43336,

    EVENT_BOARD_HARNESS_OWNER = 1,

    ACTION_START_WP = 1,

    GO_FIRST_GATE = 196401,
    GO_KINGS_GATE = 196412
};

uint8 const JamesPathLenght = 6;
Position const JamesPath[][JamesPathLenght] =
{
    {
        { -1925.925049f, 2539.176514f, 1.392833f, 0.0f },
        { -1913.658203f, 2545.986328f, 1.465530f, 0.0f },
        { -1904.370728f, 2552.793213f, 1.132485f, 0.0f },
        { -1900.970459f, 2550.849365f, 0.714445f, 0.0f },
        { -1886.868774f, 2540.282471f, 1.706371f, 0.0f },
        { -1882.739746f, 2543.941865f, 1.628683f, 0.0f },
    },
};

uint8 const CynthiaPathLenght = 6;
Position const CynthiaPath[][CynthiaPathLenght] =
{
    {
        { -1947.965088f, 2518.669434f, 1.826697f, 0.0f },
        { -1923.350830f, 2521.841553f, 1.586985f, 0.0f },
        { -1917.197632f, 2520.494385f, 2.297501f, 0.0f },
        { -1890.082031f, 2519.952148f, 1.425827f, 0.0f },
        { -1886.868774f, 2540.282471f, 1.706371f, 0.0f },
        { -1882.739746f, 2543.941865f, 1.628683f, 0.0f },
    },
};

uint8 const AshleyPathLenght = 13;
Position const AshleyPath[][AshleyPathLenght] =
{
    {
        { -1928.023682f, 2558.467285f, 12.733648f, 0.0f },
        { -1928.248901f, 2553.930176f, 12.734390f, 0.0f },
        { -1923.981567f, 2552.113770f, 12.736046f, 0.0f },
        { -1919.301514f, 2563.295166f, 3.579522f, 0.0f },
        { -1930.442017f, 2562.145996f, 3.579824f, 0.0f },
        { -1941.160156f, 2566.118896f, 1.392157f, 0.0f },
        { -1940.852295f, 2543.049072f, 1.392157f, 0.0f },
        { -1919.504517f, 2543.273926f, 1.392157f, 0.0f },
        { -1913.658203f, 2545.986328f, 1.465530f, 0.0f },
        { -1904.370728f, 2552.793213f, 1.132485f, 0.0f },
        { -1900.970459f, 2550.849365f, 0.714445f, 0.0f },
        { -1886.868774f, 2540.282471f, 1.706371f, 0.0f },
        { -1882.739746f, 2543.941865f, 1.628683f, 0.0f },
    },
};

uint8 const childrenBasementPathLenght = 3;
Position const childrenBasementPath[][childrenBasementPathLenght] =
{
    {
        { -1879.062378f, 2546.958984f, -0.130342f, 0.0f },
        { -1873.854980f, 2550.903564f, -5.898719f, 0.0f },
        { -1868.589844f, 2536.521240f, -6.365717f, 0.0f },
    },
};

const std::string PlayerText[3] =
{
    "It's not safe here. Go to the Allens' basement.",
    "Join the others inside the basement next door. Hurry!",
    "Your mother's in the basement next door. Get to her now!",
};

class npc_gilnean_crow : public CreatureScript
{
public:
    npc_gilnean_crow() : CreatureScript("npc_gilneas_crow") {}

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_gilnean_crowAI(creature);
    }

    struct npc_gilnean_crowAI : public ScriptedAI
    {
        npc_gilnean_crowAI(Creature* creature) : ScriptedAI(creature) {}

        uint32 tSpawn;
        bool Move;

        void Reset()
        {
            Move = false;
            tSpawn = 0;
            me->SetPosition(me->GetCreatureData()->posX, me->GetCreatureData()->posY, me->GetCreatureData()->posZ, me->GetCreatureData()->orientation);
        }

        void SpellHit(Unit* /*caster*/, const SpellInfo* spell)
        {
            if (spell->Id == SPELL_PING_GILNEAN_CROW)
            {
                if (!Move)
                {
                    me->SetUInt32Value(UNIT_FIELD_NPC_EMOTESTATE, EMOTE_ONESHOT_NONE); // Change our emote state to allow flight
                    me->SetDisableGravity(true);
                    Move = true;
                }
            }
        }

        void UpdateAI(const uint32 diff)
        {
            if (!Move)
                return;

            if (tSpawn <= diff)
            {
                me->GetMotionMaster()->MovePoint(0, (me->GetPositionX() + irand(-15, 15)), (me->GetPositionY() + irand(-15, 15)), (me->GetPositionZ() + irand(5, 15)));
                tSpawn = urand(500, 1000);
            }
            else tSpawn -= diff;

            if ((me->GetPositionZ() - me->GetCreatureData()->posZ) >= 20.0f)
            {
                me->DisappearAndDie();
                me->RemoveCorpse(true);
                Move = false;
            }
        }
    };
};

struct npc_gilneas_city_guard_gate : public ScriptedAI
{
    npc_gilneas_city_guard_gate(Creature* creature) : ScriptedAI(creature) { }

    EventMap m_events;
    uint8 m_say;
    uint8 m_emote;
    ObjectGuid m_citizenGUID;

    void Reset() override
    {
        if (me->GetDistance2d(-1430.47f, 1345.55f) < 10.0f)
            m_events.ScheduleEvent(EVENT_START_TALK_WITH_CITIZEN, urand(10000, 30000));
    }

    void UpdateAI(uint32 diff) override
    {
        m_events.Update(diff);

        while (uint32 eventId = m_events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_START_TALK_WITH_CITIZEN:
            {
                m_citizenGUID = GetRandomCitizen();
                m_emote = RAND(EMOTE_ONESHOT_COWER, EMOTE_STATE_TALK, EMOTE_ONESHOT_CRY, EMOTE_ONESHOT_BEG, EMOTE_ONESHOT_EXCLAMATION, EMOTE_ONESHOT_POINT);
                m_say = 0;

                if (Creature* npc = ObjectAccessor::GetCreature(*me, m_citizenGUID))
                    npc->HandleEmoteCommand(m_emote);

                m_events.ScheduleEvent(EVENT_TALK_WITH_CITIZEN_1, urand(2200, 3000));
                break;
            }
            case EVENT_TALK_WITH_CITIZEN_1:
            {
                if (Creature* npc = ObjectAccessor::GetCreature(*me, m_citizenGUID))
                    npc->AI()->Talk(m_say);

                m_events.ScheduleEvent(EVENT_TALK_WITH_CITIZEN_2, 5000);
                break;
            }
            case EVENT_TALK_WITH_CITIZEN_2:
            {
                Talk(m_say);
                m_events.ScheduleEvent(EVENT_TALK_WITH_CITIZEN_3, 5000);
                break;
            }
            case EVENT_TALK_WITH_CITIZEN_3:
            {
                if (Creature* npc = ObjectAccessor::GetCreature(*me, m_citizenGUID))
                    npc->HandleEmoteCommand(EMOTE_STATE_NONE);

                m_events.ScheduleEvent(EVENT_START_TALK_WITH_CITIZEN, urand(5000, 30000));
                break;
            }
            }
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }

    void FillCitizenList()
    {
        listOfCitizenGUID.clear();
        std::list<Creature*> listOfCitizen;
        me->GetCreatureListWithEntryInGrid(listOfCitizen, NPC_PANICKED_CITIZEN_GATE, 35.0f);

        for (std::list<Creature*>::iterator itr = listOfCitizen.begin(); itr != listOfCitizen.end(); ++itr)
            listOfCitizenGUID.push_back((*itr)->GetGUID());
    }

    ObjectGuid GetRandomCitizen()
    {
        if (listOfCitizenGUID.empty())
            FillCitizenList();

        uint8 rol = urand(0, listOfCitizenGUID.size() - 1);
        std::list<ObjectGuid>::iterator itr = listOfCitizenGUID.begin();
        std::advance(itr, rol);
        return (*itr);
    }

private:
    std::list<ObjectGuid> listOfCitizenGUID;
};

struct npc_prince_liam_greymane : public ScriptedAI
{
    npc_prince_liam_greymane(Creature* c) : ScriptedAI(c) { }

    EventMap _events;

    void Reset() override
    {
        _events.RescheduleEvent(EVENT_START_DIALOG, 1000);
    }

    void UpdateAI(uint32 diff) override
    {
        _events.Update(diff);

        while (uint32 eventId = _events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_START_DIALOG:
            {
                _events.ScheduleEvent(EVENT_RESET_DIALOG, 120000);
                _events.ScheduleEvent(EVENT_START_TALK_TO_GUARD, 1000);
                break;
            }
            case EVENT_START_TALK_TO_GUARD:
            {
                Talk(PRINCE_LIAM_GREYMANE_TEXT_00);
                _events.ScheduleEvent(EVENT_TALK_TO_GUARD_1, 15000);
                break;
            }
            case EVENT_TALK_TO_GUARD_1:
            {
                Talk(PRINCE_LIAM_GREYMANE_TEXT_01);
                _events.ScheduleEvent(EVENT_TALK_TO_GUARD_2, 18000);
                break;
            }
            case EVENT_TALK_TO_GUARD_2:
            {
                Talk(PRINCE_LIAM_GREYMANE_TEXT_02);
                break;
            }
            case EVENT_RESET_DIALOG:
            {
                Reset();
                break;
            }
            }
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

class npc_king_genn_greymane : public CreatureScript
{
public:
    npc_king_genn_greymane() : CreatureScript("npc_king_genn_greymane") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest)
    {
        if (quest->GetQuestId() == QUEST_SAVE_KRENNAN_ARANAS)
        {
            float x, y;
            creature->GetNearPoint2D(x, y, 2.0f, player->GetOrientation() + M_PI / 2);

            if (Creature* horse = player->SummonCreature(NPC_KING_GREYMANES_HORSE, x, y, creature->GetPositionZ(), creature->GetOrientation()))
            {
                if (npc_escortAI* escort = CAST_AI(npc_escortAI, horse->AI()))
                {
                    escort->AddWaypoint(1, -1799.37f, 1400.21f, 19.8951f);
                    escort->AddWaypoint(2, -1798.23f, 1396.9f, 19.8993f);
                    escort->AddWaypoint(3, -1795.03f, 1388.01f, 19.8898f);
                    escort->AddWaypoint(4, -1790.16f, 1378.7f, 19.8016f);
                    escort->AddWaypoint(5, -1786.41f, 1372.97f, 19.8406f);
                    escort->AddWaypoint(6, -1779.72f, 1364.88f, 19.8131f);
                    escort->AddWaypoint(7, -1774.43f, 1359.87f, 19.7021f);
                    escort->AddWaypoint(8, -1769.0f, 1356.76f, 19.7439f);
                    escort->AddWaypoint(9, -1762.64f, 1356.02f, 19.7979f);
                    escort->AddWaypoint(10, -1758.91f, 1356.08f, 19.8635f);
                    escort->AddWaypoint(11, -1751.95f, 1356.8f, 19.8273f);
                    escort->AddWaypoint(12, -1745.66f, 1357.21f, 19.7993f);
                    escort->AddWaypoint(13, -1738.7f, 1356.64f, 19.7822f);
                    escort->AddWaypoint(14, -1731.79f, 1355.51f, 19.7149f);
                    escort->AddWaypoint(15, -1724.89f, 1354.29f, 19.8661f);
                    escort->AddWaypoint(16, -1718.03f, 1352.93f, 19.7824f);
                    escort->AddWaypoint(17, -1707.68f, 1351.16f, 19.7811f); // Jump
                    escort->AddWaypoint(18, -1673.04f, 1344.91f, 15.1353f, 2000);
                    escort->AddWaypoint(19, -1673.04f, 1344.91f, 15.1353f);
                    escort->AddWaypoint(20, -1669.32f, 1346.55f, 15.1353f);
                    escort->AddWaypoint(21, -1666.45f, 1349.89f, 15.1353f);
                    escort->AddWaypoint(22, -1665.61f, 1353.85f, 15.1353f);
                    escort->AddWaypoint(23, -1666.04f, 1358.01f, 15.1353f);
                    escort->AddWaypoint(24, -1669.79f, 1360.71f, 15.1353f);
                    escort->AddWaypoint(25, -1673.1f, 1362.11f, 15.1353f);
                    escort->AddWaypoint(26, -1677.12f, 1361.57f, 15.1353f);
                    escort->AddWaypoint(27, -1679.9f, 1360.1f, 15.1353f);
                    escort->AddWaypoint(28, -1682.79f, 1357.56f, 15.1353f);
                    escort->AddWaypoint(29, -1682.79f, 1357.56f, 15.1353f);
                    escort->AddWaypoint(30, -1689.07f, 1352.39f, 15.1353f);
                    escort->AddWaypoint(31, -1691.91f, 1351.83f, 15.1353f);
                    escort->AddWaypoint(32, -1703.81f, 1351.82f, 19.7604f);
                    escort->AddWaypoint(33, -1707.26f, 1352.38f, 19.7826f);
                    escort->AddWaypoint(34, -1712.25f, 1353.55f, 19.7826f);
                    escort->AddWaypoint(35, -1718.2f, 1356.51f, 19.7164f);
                    escort->AddWaypoint(36, -1741.5f, 1372.04f, 19.9569f);
                    escort->AddWaypoint(37, -1746.23f, 1375.8f, 19.9817f);
                    escort->AddWaypoint(38, -1751.06f, 1380.53f, 19.8424f);
                    escort->AddWaypoint(39, -1754.97f, 1386.34f, 19.8474f);
                    escort->AddWaypoint(40, -1760.77f, 1394.37f, 19.9282f);
                    escort->AddWaypoint(41, -1765.11f, 1402.07f, 19.8816f);
                    escort->AddWaypoint(42, -1768.24f, 1410.2f, 19.7833f);
                    escort->AddWaypoint(43, -1772.26f, 1420.48f, 19.9029f);
                    escort->AddWaypoint(44, -1776.98f, 1436.13f, 19.632f);
                    player->EnterVehicle(horse, 0);
                }
            }
        }

        return true;
    }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_king_genn_greymaneAI(creature);
    }

    struct npc_king_genn_greymaneAI : public ScriptedAI
    {
        npc_king_genn_greymaneAI(Creature* creature) : ScriptedAI(creature), _talkTimer(urand(15000, 35000))
        {
        }

        void UpdateAI(uint32 diff) override
        {
            if (_talkTimer <= diff)
            {
                Talk(0);
                _talkTimer = urand(15000, 35000);
            }
            else
                _talkTimer -= diff;
        }

    private:
        uint32 _talkTimer;
    };
};

class npc_vehicle_genn_horse : public CreatureScript
{
public:
    npc_vehicle_genn_horse() : CreatureScript("npc_vehicle_genn_horse") { }

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_vehicle_genn_horseAI(creature);
    }

    struct npc_vehicle_genn_horseAI : public npc_escortAI
    {
        npc_vehicle_genn_horseAI(Creature* creature) : npc_escortAI(creature)
        {
            _aranasSaved = false;
            _playerSeated = false;
        }

        bool _playerSeated;
        bool _aranasSaved;

        void AttackStart(Unit* /*who*/) override { }
        void EnterCombat(Unit* /*who*/) override { }
        void EnterEvadeMode() override { }

        void Reset() override
        {
            _playerSeated = false;
        }

        void PassengerBoarded(Unit* who, int8 /*seatId*/, bool apply)
        {
            if (who->GetTypeId() == TypeID::TYPEID_PLAYER)
            {
                _playerSeated = true;

                if (apply)
                {
                    Start(false, true, who->GetGUID());
                    me->SetSpeed(MOVE_WALK, 1.0f, true);
                    me->SetSpeed(MOVE_RUN, 1.3f, true);
                }
            }
            else
            {
                if (apply)
                {
                    SetEscortPaused(false);
                    _aranasSaved = true;
                    me->SetSpeed(MOVE_WALK, 1.0f, true);
                    me->SetSpeed(MOVE_RUN, 1.3f, true);
                }
                else
                    me->DespawnOrUnsummon(1);
            }
        }

        void WaypointReached(uint32 i)
        {
            Player* player = GetPlayerForEscort();

            switch (i)
            {
            case 1:
            {
                if (Unit* passenger = me->GetVehicleKit()->GetPassenger(0))
                {
                    if (Vehicle* vehicle = me->GetVehicleKit())
                        if (Unit* passenger = vehicle->GetPassenger(0))
                            if (Player* player = passenger->ToPlayer())
                                player->SetClientControl(me, 0);
                }
                break;
            }
            case 17:
            {
                if (Unit* passenger = me->GetVehicleKit()->GetPassenger(0))
                {
                    if (Creature* aranas = passenger->FindNearestCreature(NPC_KRENNAN_ARANAS, 50.0f))
                        if (Vehicle* vehicle = me->GetVehicleKit())
                            if (Unit* passenger = vehicle->GetPassenger(0))
                                if (Player* player = passenger->ToPlayer())
                                    aranas->AI()->Talk(TEXT_KRENNAN_ARANAS);

                    me->GetMotionMaster()->MoveJump(-1673.04f, 1344.91f, 15.1353f, 25.0f, 15.0f);

                    AddGilneasDelayedEvent(me, 2000, [this, passenger]()
                        {
                            Talk(EMOTE_SAVE_KRENNAN_ARANAS, passenger);
                        });
                }
                break;
            }
            case 40:
            {
                if (Vehicle* vehicle = me->GetVehicleKit())
                {
                    if (Unit* passenger = vehicle->GetPassenger(0))
                    {
                        if (Player* player = passenger->ToPlayer())
                        {
                            std::list<Creature*> guards;
                            me->GetCreatureListWithEntryInGrid(guards, NPC_GILNEAS_CITY_GUARD, 90.0f);

                            if (!guards.empty())
                                for (std::list<Creature*>::const_iterator itr = guards.begin(); itr != guards.end(); ++itr)
                                    if ((*itr)->IsAlive())
                                        if (Creature* worgen = (*itr)->FindNearestCreature(NPC_BLOODFANG_RIPPER, 90.0f))
                                            (*itr)->CastSpell(worgen, SPELL_GUARD_SHOOT, false);
                        }
                    }
                }
                break;
            }
            case 41:
            {
                me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                me->CombatStop();
                break;
            }
            case 42:
            {
                if (Vehicle* vehicle = me->GetVehicleKit())
                    if (Unit* passenger = vehicle->GetPassenger(0))
                        if (Player* player = passenger->ToPlayer())
                        {
                            player->KilledMonsterCredit(NPC_KRENNAN_ARANAS_KILL_CREDIT, 0);

                            if (Unit* passenger_2 = vehicle->GetPassenger(1))
                                if (Creature* aranas = passenger_2->ToCreature())
                                    aranas->AI()->Talk(TEXT_SAVED_KRENNAN_ARANAS);
                        }
                break;
            }
            case 44:
            {
                if (Unit* passenger = me->GetVehicleKit()->GetPassenger(0))
                {
                    if (Vehicle* vehicle = me->GetVehicleKit())
                    {
                        if (Unit* passenger = vehicle->GetPassenger(0))
                            if (Player* player = passenger->ToPlayer())
                                player->SetClientControl(me, 1);

                        if (Unit* passenger = vehicle->GetPassenger(1))
                            if (Creature* aranas = passenger->ToCreature())
                                aranas->DespawnOrUnsummon();

                        vehicle->RemoveAllPassengers();
                    }
                }
                me->DespawnOrUnsummon(1);
                break;
            }
            }
        }

        void OnCharmed(bool /*apply*/) { }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);
            Player* player = GetPlayerForEscort();

            if (_playerSeated)
            {
                player->SetClientControl(me, 0);
                _playerSeated = false;
            }
        }
    };
};

struct npc_saved_aranas : public ScriptedAI
{
    npc_saved_aranas(Creature* creature) : ScriptedAI(creature)
    {
        me->SetReactState(REACT_PASSIVE);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);

        if (me->IsSummon())
        {
            if (Creature* horse = me->FindNearestCreature(NPC_KING_GREYMANES_HORSE, 20.0f))
                DoCast(horse, 84275, true);

            if (Creature* aranas = me->FindNearestCreature(NPC_KRENNAN_ARANAS, 50.0f))
                aranas->DespawnOrUnsummon();
        }
    }
};

class npc_gilneas_children : public CreatureScript
{
public:
    npc_gilneas_children(const char* scriptName, uint32 spellId, uint8 playerSayId) : CreatureScript(scriptName), _spellId(spellId), _playerSayId(playerSayId) { }

private:
    uint32 _spellId;
    uint8 _playerSayId;

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new creature_script(creature, _spellId, _playerSayId);
    }

    struct creature_script : public ScriptedAI
    {
        creature_script(Creature* creature, uint32 spellId, uint8 playerSayId) : ScriptedAI(creature), _spellId(spellId), _playerSayId(playerSayId) { }

        EventMap events;
        ObjectGuid playerGUID;
        uint32 _spellId;
        uint8 _playerSayId;
        bool activated;

        void Reset() override
        {
            events.Reset();
            playerGUID = 0;
            activated = false;
            me->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);

            if (me->GetEntry() == NPC_CYNTHIA)
                events.ScheduleEvent(EVENT_CRY, 1000);
        }

        void SpellHit(Unit* caster, const SpellInfo* spell)
        {
            if (!activated && spell->Id == _spellId)
            {
                if (Player* player = caster->ToPlayer())
                {
                    activated = true;
                    playerGUID = player->GetGUID();
                    player->Say(PlayerText[_playerSayId], Language::LANG_UNIVERSAL);
                    player->KilledMonsterCredit(me->GetEntry(), 0);
                    me->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);
                    events.ScheduleEvent(EVENT_TALK_TO_PLAYER, 3500);
                }
            }
        }

        void UpdateAI(uint32 diff) override
        {
            events.Update(diff);

            if (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_TALK_TO_PLAYER:
                {
                    events.CancelEvent(EVENT_CRY);

                    if (Player* player = ObjectAccessor::GetPlayer(*me, playerGUID))
                        Talk(CHILDREN_TEXT_ID, player);

                    events.ScheduleEvent(EVENT_START_RUN, 5000);
                }
                break;
                case EVENT_START_RUN:
                {
                    switch (me->GetEntry())
                    {
                    case NPC_JAMES:
                        MoveGilneasPointPath(me, 0, JamesPath[0], JamesPathLenght);
                        break;
                    case NPC_CYNTHIA:
                        MoveGilneasPointPath(me, 0, CynthiaPath[0], CynthiaPathLenght);
                        break;
                    case NPC_ASHLEY:
                        MoveGilneasPointPath(me, 0, AshleyPath[0], AshleyPathLenght);
                        break;
                    default:
                        return;
                    }

                    events.ScheduleEvent(EVENT_OPEN_DOOR, 5000);
                }
                break;
                case EVENT_OPEN_DOOR:
                {
                    if (GameObject* door = me->FindNearestGameObject(GO_DOOR_TO_THE_BASEMENT, 10.0f))
                    {
                        if (door->GetGoState() == GOState::GO_STATE_READY)
                        {
                            door->UseDoorOrButton();
                            events.ScheduleEvent(EVENT_RESUME_RUN, 2000);
                        }
                        else
                            events.ScheduleEvent(EVENT_RESUME_RUN, 0);
                    }
                }
                break;
                case EVENT_RESUME_RUN:
                    MoveGilneasPointPath(me, 0, childrenBasementPath[0], childrenBasementPathLenght);
                    me->DespawnOrUnsummon(5000);
                    break;
                case EVENT_CRY:
                    me->HandleEmoteCommand(EMOTE_ONESHOT_CRY);
                    events.ScheduleEvent(EVENT_CRY, urand(1000, 1500));
                    break;
                }
            }
        }
    };
};

class npc_wahl : public CreatureScript
{
public:
    npc_wahl(const char* ScriptName) : CreatureScript(ScriptName) { }

    struct npc_wahlAI : public npc_escortAI
    {
        npc_wahlAI(Creature* creature) : npc_escortAI(creature)
        {
            creature->SetReactState(REACT_PASSIVE);
            creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
        }

        void DoAction(int32 const action) override
        {
            if (action == ACTION_CONTINUE_SCENE)
            {
                AddGilneasDelayedEvent(me, 4000, [this]()
                    {
                        SetEscortPaused(false);
                    });
            }
        }

        void WaypointReached(uint32 point)
        {
            if (point == 1)
                if (me->IsSummon())
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                    {
                        SetEscortPaused(true);
                        me->SetDisplayId(NPC_WAHL_WORGEN);
                        Talk(YELL_DONT_MESS);
                        me->SetReactState(REACT_AGGRESSIVE);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);

                        AddGilneasDelayedEvent(me, 800, [this, summoner]()
                            {
                                AttackStart(summoner);
                            });
                    }
        }

        void UpdateAI(uint32 diff) override
        {
            npc_escortAI::UpdateAI(diff);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_wahlAI(creature);
    }
};

class npc_lucius_the_cruel : public CreatureScript
{
public:
    npc_lucius_the_cruel(const char* ScriptName) : CreatureScript(ScriptName) { }

    struct npc_lucius_the_cruelAI : public ScriptedAI
    {
        npc_lucius_the_cruelAI(Creature* creature) : ScriptedAI(creature)
        {
            SetCombatMovement(false);
            Catch = false;
            Summon = false;
            uiCatchTimer = 1000;
            uiShootTimer = 500;
            uiPlayerGUID = 0;
            uiSummonTimer = 1500;
            me->SetReactState(REACT_PASSIVE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
        }

        ObjectGuid uiPlayerGUID;
        uint32 uiCatchTimer;
        uint32 uiShootTimer;
        uint32 uiSummonTimer;
        bool Catch;
        bool Summon;

        void EnterEvadeMode() override
        {
            me->DespawnOrUnsummon();
        }

        void JustDied(Unit* /*killer*/) override
        {
            if (Creature* wahl = me->FindNearestCreature(NPC_WAHL, 30.f))
                wahl->AI()->DoAction(ACTION_CONTINUE_SCENE);
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE)
                return;

            if (id == POINT_CATCH_CHANCE)
            {
                me->HandleEmoteCommand(EMOTE_ONESHOT_KNEEL);

                if (me->IsSummon())
                    if (Unit* summoner = me->ToTempSummon()->GetSummoner())
                        if (Creature* chance = summoner->ToCreature())
                        {
                            AddGilneasDelayedEvent(me, 4000, [this, chance]()
                                {
                                    Catch = true;
                                    Summon = true;
                                    chance->AI()->DoAction(ACTION_CHANCE_DESPAWN);
                                });
                        }
            }
        }

        void DoAction(int32 const action) override
        {
            if (action == ACTION_SUMMON_LUCIUS)
            {
                me->GetMotionMaster()->MovePoint(POINT_CATCH_CHANCE, -2106.372f, 2331.106f, 7.360674f);

                AddGilneasDelayedEvent(me, 1000, [this]()
                    {
                        Talk(SAY_THIS_CAT_IS_MINE);
                    });
            }
        }

        void UpdateAI(uint32 diff) override
        {
            if (Catch)
            {
                if (uiCatchTimer <= diff)
                {
                    Catch = false;
                    uiCatchTimer = 1000;
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                    me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_IMMUNE_TO_NPC);
                    me->SetReactState(REACT_AGGRESSIVE);

                    if (Player* player = Unit::GetPlayer(*me, uiPlayerGUID))
                        AttackStart(player);
                }
                else
                    uiCatchTimer -= diff;
            }

            if (Summon)
            {
                if (uiSummonTimer <= diff)
                {
                    Summon = false;
                    uiSummonTimer = 1500;

                    if (Creature* wahl = me->SummonCreature(NPC_WAHL, -2098.366f, 2352.075f, 7.160643f))
                    {
                        if (npc_escortAI* npc_escort = CAST_AI(npc_wahl::npc_wahlAI, wahl->AI()))
                        {
                            npc_escort->AddWaypoint(0, -2106.54f, 2342.69f, 6.93668f);
                            npc_escort->AddWaypoint(1, -2106.12f, 2334.90f, 7.36691f);
                            npc_escort->AddWaypoint(2, -2117.80f, 2357.15f, 5.88139f);
                            npc_escort->AddWaypoint(3, -2111.46f, 2366.22f, 7.17151f);
                            npc_escort->Start(false, true);
                        }
                    }
                }
                else
                    uiSummonTimer -= diff;
            }

            if (!UpdateVictim())
                return;

            if (uiShootTimer <= diff)
            {
                uiShootTimer = 1000;

                if (me->GetDistance(me->GetVictim()) > 2.0f)
                    DoCastVictim(SPELL_LUCIUS_SHOOT);
            }
            else
                uiShootTimer -= diff;

            DoMeleeAttackIfReady();
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_lucius_the_cruelAI(creature);
    }
};

struct npc_chance_the_cat : public ScriptedAI
{
    npc_chance_the_cat(Creature* creature) : ScriptedAI(creature)
    {
        Despawn = false;
        uiDespawnTimer = 500;
    }

    uint32 uiDespawnTimer;
    bool Despawn;

    void DoAction(int32 const action) override
    {
        if (action == ACTION_CHANCE_DESPAWN)
            Despawn = true;
    }

    void SpellHit(Unit* caster, const SpellInfo* spell) override
    {
        if (spell->Id == SPELL_CATCH_CAT && caster->GetTypeId() == TypeID::TYPEID_PLAYER)
        {
            me->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_SPELLCLICK);

            if (Creature* lucius = me->SummonCreature(NPC_LUCIUS_THE_CRUEL, -2111.533f, 2329.95f, 7.390349f))
            {
                lucius->AI()->DoAction(ACTION_SUMMON_LUCIUS);
                CAST_AI(npc_lucius_the_cruel::npc_lucius_the_cruelAI, lucius->AI())->uiPlayerGUID = caster->GetGUID();
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (Despawn)
        {
            if (uiDespawnTimer <= diff)
            {
                uiDespawnTimer = 500;
                Despawn = false;
                me->DespawnOrUnsummon();
            }
            else
                uiDespawnTimer -= diff;
        }
    }
};

class npc_mountain_horse : public CreatureScript
{
public:
    npc_mountain_horse(const char* ScriptName) : CreatureScript(ScriptName) { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_THE_HUNGRY_ETTIN) == QUEST_STATUS_INCOMPLETE)
        {
            player->EnterVehicle(creature, 0);
            creature->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            creature->GetMotionMaster()->Clear();
            return true;
        }
        return true;
    }

    struct npc_mountain_horseAI : public ScriptedAI
    {
        npc_mountain_horseAI(Creature* creature) : ScriptedAI(creature) { }

        EventMap events;

        void Reset() override
        {
            if (!me->GetVehicleKit()->GetPassenger(0))
                me->GetMotionMaster()->MoveRandom(8.0f);
        }

        void SpellHit(Unit* caster, SpellInfo const* spell)
        {
            switch (spell->Id)
            {
            case SPELL_ROUND_UP_HORSE:
            {
                if (me->GetVehicleKit()->GetPassenger(0))
                    break;

                me->DespawnOrUnsummon(1);
                break;
            }
            default:
                break;
            }
        }

        void PassengerBoarded(Unit* /*passenger*/, int8 /*SeatId*/, bool apply)
        {
            if (!apply)
            {
                me->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                me->SetWalk(true);
                me->AI()->EnterEvadeMode();
            }
        }

        void OnCharmed(bool apply) { }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_mountain_horseAI(creature);
    }
};

struct npc_mountain_horse_summoned : public ScriptedAI
{
    npc_mountain_horse_summoned(Creature* creature) : ScriptedAI(creature) { }

    EventMap events;

    void IsSummonedBy(Unit* summoner) override
    {
        me->GetMotionMaster()->MoveFollow(summoner, 6.0f, 0);
        me->CastSpell(summoner, SPELL_ROPE_CHANNEL, true);
        me->ClearUnitState(UNIT_STATE_CASTING);
        events.ScheduleEvent(EVENT_CHECK_LORNA, 2000);
        events.ScheduleEvent(EVENT_CHECK_OWNER, 2000);
        me->SetWalk(false);
        me->SetSpeed(MOVE_RUN, 2.0f, true);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
            case EVENT_CHECK_LORNA:
            {
                if (Creature* lornaCrowley = me->FindNearestCreature(NPC_LORNA_CROWLEY_2, 8.0f, true))
                {
                    if (Unit* owner = me->GetCharmerOrOwner())
                    {
                        if (owner->GetTypeId() == TypeID::TYPEID_PLAYER)
                            owner->ToPlayer()->KilledMonsterCredit(QUEST_CREDIT_HORSE);
                    }
                    events.CancelEvent(EVENT_CHECK_LORNA);
                    me->DespawnOrUnsummon(1);
                }
                else
                    events.RescheduleEvent(EVENT_CHECK_LORNA, 2000);
                break;
            }
            case EVENT_CHECK_OWNER:
            {
                if (Unit* owner = me->GetCharmerOrOwner())
                {
                    if (!owner->IsAlive() || !owner->IsInWorld() || !owner->GetVehicleBase())
                        me->DespawnOrUnsummon(1);

                    events.CancelEvent(EVENT_CHECK_OWNER);
                }
                else
                    events.RescheduleEvent(EVENT_CHECK_OWNER, 2000);
                break;
            }
            default:
                break;
            }
        }
    }
};

class spell_gilneas_test_telescope : public SpellScript
{
    PrepareSpellScript(spell_gilneas_test_telescope);

    void StartCinematic()
    {
        if (Unit* caster = GetCaster())
        {
            if (caster->GetTypeId() == TypeID::TYPEID_PLAYER)
            {
                caster->PlayDirectSound(MUSIC_ENTRY_TELESCOPE, caster->ToPlayer());
                caster->ToPlayer()->SendCinematicStart(PLAY_CINEMATIC_TELESCOPE);
            }
        }
    }

    void Register() override
    {
        AfterHit += SpellHitFn(spell_gilneas_test_telescope::StartCinematic);
    }
};

class npc_stagecoach_carriage_exodus : public CreatureScript
{
public:
    npc_stagecoach_carriage_exodus(const char* ScriptName) : CreatureScript(ScriptName) { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_ENTRY_EXODUS) == QUEST_STATUS_COMPLETE)
        {
            if (player->GetVehicleBase())
                return true;

            if (Creature* harness = player->FindNearestCreature(NPC_STAGECOACH_HARNESS, 30.0f, true))
            {
                Position summonPos(harness->GetPositionX(), harness->GetPositionY(), harness->GetPositionZ(), harness->GetOrientation());
                player->GetMap()->SummonCreature(NPC_HARNESS_SUMMONED, summonPos, sSummonPropertiesStore.LookupEntry(3105), 600000, player);
            }
            return true;
        }

        return true;
    }

    struct npc_stagecoach_carriage_exodusAI : public ScriptedAI
    {
        npc_stagecoach_carriage_exodusAI(Creature* creature) : ScriptedAI(creature)
        {
            events.ScheduleEvent(EVENT_BOARD_HARNESS_OWNER, 1);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
        }

        EventMap events;

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                case EVENT_BOARD_HARNESS_OWNER:
                {
                    if (Unit* harness = me->GetVehicleCreatureBase())
                    {
                        if (Unit* harnessOwner = harness->ToTempSummon()->GetSummoner())
                        {
                            if (harnessOwner->IsAlive() && harnessOwner->IsInWorld())
                            {
                                harnessOwner->EnterVehicle(me, 1);
                                events.CancelEvent(EVENT_BOARD_HARNESS_OWNER);
                                break;
                            }
                        }
                    }
                    events.CancelEvent(EVENT_BOARD_HARNESS_OWNER);
                    break;
                }
                default:
                    break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_stagecoach_carriage_exodusAI(creature);
    }
};

class npc_stagecoach_harness : public CreatureScript
{
public:
    npc_stagecoach_harness(const char* ScriptName) : CreatureScript(ScriptName) { }

    struct npc_stagecoach_harnessAI : public npc_escortAI
    {
        npc_stagecoach_harnessAI(Creature* creature) : npc_escortAI(creature) { }

        void OnCharmed(bool apply) { }

        void IsSummonedBy(Unit* owner)
        {
            DoAction(ACTION_START_WP);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC);
        }

        void DoAction(int32 action)
        {
            switch (action)
            {
            case ACTION_START_WP:
            {
                Start(false, true, NULL, NULL, false, false, true);
                SetDespawnAtEnd(true);

                if (GameObject* gate = me->FindNearestGameObject(GO_FIRST_GATE, 80.0f))
                    gate->UseDoorOrButton(0, false, me);

                me->SetWalk(false);
                me->SetSpeed(MOVE_RUN, 1.34f, true);
                break;
            }
            default:
                break;
            }
        }

        void WaypointReached(uint32 point) override
        {
            switch (point)
            {
            case 16:
            {
                if (GameObject* gate = me->FindNearestGameObject(GO_KINGS_GATE, 80.0f))
                    gate->UseDoorOrButton(0, false, me);
                break;
            }
            case 24:
            {
                if (Unit* caravan = me->GetVehicleKit()->GetPassenger(2))
                {
                    if (Unit* lorna = caravan->GetVehicleKit()->GetPassenger(6))
                    {
                        if (lorna->ToCreature())
                            lorna->ToCreature()->AI()->Talk(0);
                    }
                }
                break;
            }
            case 30:
            {
                if (Unit* caravan = me->GetVehicleKit()->GetPassenger(2))
                {
                    if (Unit* player = caravan->GetVehicleKit()->GetPassenger(1))
                        player->ExitVehicle();
                }
                break;
            }
            default:
                break;
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_stagecoach_harnessAI(creature);
    }
};

struct npc_rampaging_worgen : public ScriptedAI
{
    npc_rampaging_worgen(Creature* creature) : ScriptedAI(creature) { }

    void DamageTaken(Unit* attacker, uint32& damage) override
    {
        if (attacker->GetTypeId() != TypeID::TYPEID_PLAYER && !HealthAbovePct(75))
            damage = 0;

        if (!HealthAbovePct(10) && !me->HasAura(8599))
        {
            Talk(0);
            DoCast(me, 8599);
        }
    }
};

} // namespace

void AddSC_gilneas_extra()
{
    new npc_gilnean_crow();
    new gilneas_creature_script<npc_gilneas_city_guard_gate>("npc_gilneas_city_guard_gate");
    new gilneas_creature_script<npc_prince_liam_greymane>("npc_prince_liam_greymane");
    new npc_king_genn_greymane();
    new npc_vehicle_genn_horse();
    new gilneas_creature_script<npc_saved_aranas>("npc_saved_aranas");
    new npc_gilneas_children("npc_james", SPELL_SAVE_JAMES, PLAYER_SAY_JAMES);
    new npc_gilneas_children("npc_ashley", SPELL_SAVE_ASHLEY, PLAYER_SAY_ASHLEY);
    new npc_gilneas_children("npc_cynthia", SPELL_SAVE_CYNTHIA, PLAYER_SAY_CYNTHIA);
    new npc_wahl("npc_wahl");
    new npc_lucius_the_cruel("npc_lucius_the_cruel");
    new gilneas_creature_script<npc_chance_the_cat>("npc_chance_the_cat");
    new npc_mountain_horse("npc_mountain_horse");
    new gilneas_creature_script<npc_mountain_horse_summoned>("npc_mountain_horse_summoned");
    new gilneas_spell_script<spell_gilneas_test_telescope>("spell_gilneas_test_telescope");
    new npc_stagecoach_carriage_exodus("npc_stagecoach_carriage_exodus");
    new npc_stagecoach_harness("npc_stagecoach_harness");
    new gilneas_creature_script<npc_rampaging_worgen>("npc_rampaging_worgen");
}
