/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

/* ScriptData
SDName: Razorfen_Downs
SD%Complete: 100
SDComment: Support for Henry Stern(2 recipes), quest 3525 "Extinguishing the Idol", Tuten'kash's gong
SDCategory: Razorfen Downs
EndScriptData */

/* ContentData
npc_henry_stern
npc_belnistrasz
npc_idol_room_spawner
npc_tomb_creature
go_gong
EndContentData */

/*
 * npc_belnistrasz, npc_idol_room_spawner, npc_tomb_creature and go_gong are ported from
 * TrinityCore cata_classic razorfen_downs.cpp (GPL v2 or later).
 */

#include "ScriptMgr.h"
#include "GameObject.h"
#include "InstanceScript.h"
#include "MotionMaster.h"
#include "Player.h"
#include "razorfen_downs.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "ScriptSystem.h"
#include "TemporarySummon.h"

/*###
# npc_henry_stern
####*/

enum Spells
{
    SPELL_TEACHING_GOLDTHORN_TEA                = 13029,
    SPELL_TEACHING_MIGHTY_TROLLS_BLOOD_POTION   = 13030
};

enum Gossips
{
    GOSSIP_COOKING_SKILL_HIGH                   = 1444,
    GOSSIP_COOKING_SKILL_LOW                    = 1501,
    GOSSIP_ALCHEMY_SKILL_HIGH                   = 1442,
    GOSSIP_ALCHEMY_SKILL_LOW                    = 1502
};

class npc_henry_stern : public CreatureScript
{
public:
    npc_henry_stern() : CreatureScript("npc_henry_stern") { }

    struct npc_henry_sternAI : public ScriptedAI
    {
        npc_henry_sternAI(Creature* creature) : ScriptedAI(creature) { }

        void sGossipSelect(Player* player, uint32 /*sender*/, uint32 action) OVERRIDE
        {
            if (action == 0)
            {
                if (player->GetBaseSkillValue(SKILL_COOKING) >= 175)
                {
                    player->PrepareGossipMenu(me, GOSSIP_COOKING_SKILL_HIGH);
                    player->SendPreparedGossip(me);
                    DoCast(player, SPELL_TEACHING_GOLDTHORN_TEA);
                }
                else
                {
                    player->PrepareGossipMenu(me, GOSSIP_COOKING_SKILL_LOW);
                    player->SendPreparedGossip(me);
                }
            }

            if (action == 1)
            {
                if (player->GetBaseSkillValue(SKILL_ALCHEMY) >= 180)
                {
                    player->PrepareGossipMenu(me, GOSSIP_ALCHEMY_SKILL_HIGH);
                    player->SendPreparedGossip(me);
                    DoCast(player, SPELL_TEACHING_MIGHTY_TROLLS_BLOOD_POTION);
                }
                else
                {
                    player->PrepareGossipMenu(me, GOSSIP_ALCHEMY_SKILL_LOW);
                    player->SendPreparedGossip(me);
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_henry_sternAI(creature);
    }
};

namespace
{

/*###
## npc_belnistrasz for Quest 3525 "Extinguishing the Idol"
######*/

Position const PosSummonSpawner[3] =
{
    { 2582.789f, 954.3925f, 52.48214f, 3.787364f  },
    { 2569.42f,  956.3801f, 52.27323f, 5.427974f  },
    { 2570.62f,  942.3934f, 53.7433f,  0.715585f  }
};

enum Belnistrasz
{
    EVENT_CHANNEL                = 1,
    EVENT_IDOL_ROOM_SPAWNER      = 2,
    EVENT_PROGRESS               = 3,
    EVENT_COMPLETE               = 4,
    EVENT_FIREBALL               = 5,
    EVENT_FROST_NOVA             = 6,

    PATH_ESCORT                  = 6973680,
    POINT_REACH_IDOL             = 17,   // 0-based index of the path's last node

    QUEST_EXTINGUISHING_THE_IDOL = 3525,

    SAY_QUEST_ACCEPTED           = 0,
    SAY_EVENT_START              = 1,
    SAY_EVENT_THREE_MIN_LEFT     = 2,
    SAY_EVENT_TWO_MIN_LEFT       = 3,
    SAY_EVENT_ONE_MIN_LEFT       = 4,
    SAY_EVENT_END                = 5,
    SAY_AGGRO                    = 6, // Combat
    SAY_WATCH_OUT                = 7, // on aggro while channeling

    SPELL_ARCANE_INTELLECT       = 13326,
    SPELL_FIREBALL               = 9053,
    SPELL_FROST_NOVA             = 11831,
    SPELL_IDOL_SHUTDOWN_VISUAL   = 12774, // Hits Unit Entry: 8662
    SPELL_IDOM_ROOM_CAMERA_SHAKE = 12816  // Dummy needs scripting
};

struct npc_belnistrasz : public ScriptedAI
{
    npc_belnistrasz(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
        eventInProgress = false;
        channeling = false;
        ritualStarted = false;
        eventProgress = 0;
        spawnerCount = 0;
    }

    // SkyFire walks an evading escortee back to its spawn point; keep him where the fight
    // ended so the path (or the ritual) carries on from there, and restart the ritual
    // channel if the evade cleared it.
    void EnterEvadeMode() override
    {
        if (eventInProgress)
            me->SetHomePosition(*me);

        ScriptedAI::EnterEvadeMode();

        if (eventInProgress && ritualStarted && eventProgress < 3 && !me->GetCurrentSpell(CURRENT_CHANNELED_SPELL))
            DoCastSelf(SPELL_IDOL_SHUTDOWN_VISUAL);
    }

    void Reset() override
    {
        if (!eventInProgress)
        {
            if (!me->HasAura(SPELL_ARCANE_INTELLECT))
                DoCastSelf(SPELL_ARCANE_INTELLECT);

            channeling = false;
            eventProgress = 0;
            spawnerCount  = 0;
            me->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
        }
    }

    void EnterCombat(Unit* who) override
    {
        if (channeling)
            Talk(SAY_WATCH_OUT, who);
        else
        {
            events.ScheduleEvent(EVENT_FIREBALL, 1 * IN_MILLISECONDS);
            events.ScheduleEvent(EVENT_FROST_NOVA, urand(8, 12) * IN_MILLISECONDS);
            if (urand(0, 100) > 40)
                Talk(SAY_AGGRO, who);
        }
    }

    void JustDied(Unit* /*killer*/) override
    {
        // TrinityCore marks the event done here, but its idol state is never stored (see
        // razorfen_downs.h). Failing the escort instead keeps the idol fires lit for a retry.
        if (eventInProgress)
        {
            std::list<Player*> players;
            me->GetPlayerListInGrid(players, 100.0f);
            for (Player* player : players)
                if (player->GetQuestStatus(QUEST_EXTINGUISHING_THE_IDOL) == QUEST_STATUS_INCOMPLETE)
                    player->FailQuest(QUEST_EXTINGUISHING_THE_IDOL);
        }
        me->DespawnOrUnsummon(5 * IN_MILLISECONDS);
    }

    void sQuestAccept(Player* /*player*/, Quest const* quest) override
    {
        if (quest->GetQuestId() == QUEST_EXTINGUISHING_THE_IDOL && !eventInProgress)
        {
            eventInProgress = true;
            Talk(SAY_QUEST_ACCEPTED);
            me->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
            me->setFaction(FACTION_ESCORT_N_NEUTRAL_ACTIVE);
            me->GetMotionMaster()->MovePath(PATH_ESCORT, false);
        }
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == WAYPOINT_MOTION_TYPE && id == POINT_REACH_IDOL)
        {
            channeling = true;
            events.ScheduleEvent(EVENT_CHANNEL, 2 * IN_MILLISECONDS);
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!eventInProgress)
        {
            if (UpdateVictim())
                DoMeleeAttackIfReady();
            return;
        }

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_CHANNEL:
                    Talk(SAY_EVENT_START);
                    ritualStarted = true;
                    DoCastSelf(SPELL_IDOL_SHUTDOWN_VISUAL);
                    events.ScheduleEvent(EVENT_IDOL_ROOM_SPAWNER, 100);
                    events.ScheduleEvent(EVENT_PROGRESS, 120 * IN_MILLISECONDS);
                    break;
                case EVENT_IDOL_ROOM_SPAWNER:
                    if (Creature* creature = me->SummonCreature(NPC_IDOL_ROOM_SPAWNER, PosSummonSpawner[urand(0, 2)], TempSummonType::TEMPSUMMON_TIMED_DESPAWN, 4 * IN_MILLISECONDS))
                        creature->AI()->SetData(0, spawnerCount);
                    if (++spawnerCount < 8)
                        events.ScheduleEvent(EVENT_IDOL_ROOM_SPAWNER, 35 * IN_MILLISECONDS);
                    break;
                case EVENT_PROGRESS:
                {
                    switch (eventProgress)
                    {
                        case 0:
                            Talk(SAY_EVENT_THREE_MIN_LEFT);
                            ++eventProgress;
                            events.ScheduleEvent(EVENT_PROGRESS, MINUTE * IN_MILLISECONDS);
                            break;
                        case 1:
                            Talk(SAY_EVENT_TWO_MIN_LEFT);
                            ++eventProgress;
                            events.ScheduleEvent(EVENT_PROGRESS, MINUTE * IN_MILLISECONDS);
                            break;
                        case 2:
                            Talk(SAY_EVENT_ONE_MIN_LEFT);
                            ++eventProgress;
                            events.ScheduleEvent(EVENT_PROGRESS, MINUTE * IN_MILLISECONDS);
                            break;
                        case 3:
                            events.CancelEvent(EVENT_IDOL_ROOM_SPAWNER);
                            me->InterruptSpell(CURRENT_CHANNELED_SPELL);
                            Talk(SAY_EVENT_END);
                            events.ScheduleEvent(EVENT_COMPLETE, 3 * IN_MILLISECONDS);
                            break;
                    }
                    break;
                }
                case EVENT_COMPLETE:
                {
                    DoCastSelf(SPELL_IDOM_ROOM_CAMERA_SHAKE);
                    me->SummonGameObject(GO_BELNISTRASZS_BRAZIER, 2577.196f, 947.0781f, 53.16757f, 2.356195f, 0.0f, 0.0f, 0.9238796f, 0.3826832f, HOUR);

                    std::list<Player*> players;
                    me->GetPlayerListInGrid(players, 50.0f);
                    for (Player* player : players)
                        if (player->GetQuestStatus(QUEST_EXTINGUISHING_THE_IDOL) == QUEST_STATUS_INCOMPLETE)
                            player->GroupEventHappens(QUEST_EXTINGUISHING_THE_IDOL, me);

                    for (uint32 entry : { GO_IDOL_OVEN_FIRE, GO_IDOL_CUP_FIRE, GO_IDOL_MOUTH_FIRE })
                    {
                        std::list<GameObject*> fires;
                        me->GetGameObjectListWithEntryInGrid(fires, entry, 50.0f);
                        for (GameObject* go : fires)
                            go->Delete();
                    }

                    eventInProgress = false;
                    if (instance)
                        instance->SetBossState(DATA_EXTINGUISHING_THE_IDOL, DONE);
                    me->DespawnOrUnsummon();
                    return;
                }
                case EVENT_FIREBALL:
                    if (me->HasUnitState(UNIT_STATE_CASTING) || !UpdateVictim())
                        return;
                    DoCastVictim(SPELL_FIREBALL);
                    events.ScheduleEvent(EVENT_FIREBALL, 8 * IN_MILLISECONDS);
                    break;
                case EVENT_FROST_NOVA:
                    if (me->HasUnitState(UNIT_STATE_CASTING) || !UpdateVictim())
                        return;
                    DoCastAOE(SPELL_FROST_NOVA);
                    events.ScheduleEvent(EVENT_FROST_NOVA, 15 * IN_MILLISECONDS);
                    break;
            }
        }

        // TrinityCore turns melee off while he channels (SetCanMelee(false)).
        if (!channeling && UpdateVictim())
            DoMeleeAttackIfReady();
    }

private:
    InstanceScript* instance;
    EventMap events;
    bool eventInProgress;
    bool channeling;
    bool ritualStarted;
    uint8 eventProgress;
    uint8 spawnerCount;
};

struct npc_idol_room_spawner : public ScriptedAI
{
    npc_idol_room_spawner(Creature* creature) : ScriptedAI(creature) { }

    void Reset() override { }

    void UpdateAI(uint32 /*diff*/) override { }

    void SetData(uint32 /*type*/, uint32 data) override
    {
        if (data < 7)
        {
            me->SummonCreature(NPC_WITHERED_BATTLE_BOAR, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            if (data > 0 && me->GetOrientation() < 4.0f)
                me->SummonCreature(NPC_WITHERED_BATTLE_BOAR, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
            me->SummonCreature(NPC_DEATHS_HEAD_GEOMANCER, me->GetPositionX() + (std::cos(me->GetOrientation() - (float(M_PI) / 2)) * 2), me->GetPositionY() + (std::sin(me->GetOrientation() - (float(M_PI) / 2)) * 2), me->GetPositionZ(), me->GetOrientation());
            me->SummonCreature(NPC_WITHERED_QUILGUARD, me->GetPositionX() + (std::cos(me->GetOrientation() + (float(M_PI) / 2)) * 2), me->GetPositionY() + (std::sin(me->GetOrientation() + (float(M_PI) / 2)) * 2), me->GetPositionZ(), me->GetOrientation());
        }
        else if (data == 7)
            me->SummonCreature(NPC_PLAGUEMAW_THE_ROTTING, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());
    }
};

enum TombCreature
{
    EVENT_WEB                   = 7,
    SPELL_POISON_PROC           = 3616,
    SPELL_VIRULENT_POISON_PROC  = 12254,
    SPELL_WEB                   = 745
};

struct npc_tomb_creature : public ScriptedAI
{
    npc_tomb_creature(Creature* creature) : ScriptedAI(creature)
    {
        instance = creature->GetInstanceScript();
    }

    void Reset() override
    {
        events.Reset();

        if (!me->HasAura(SPELL_POISON_PROC) && me->GetEntry() == NPC_TOMB_FIEND)
            DoCast(me, SPELL_POISON_PROC);

        if (!me->HasAura(SPELL_VIRULENT_POISON_PROC) && me->GetEntry() == NPC_TOMB_REAVER)
            DoCast(me, SPELL_VIRULENT_POISON_PROC);
    }

    void JustDied(Unit* /*killer*/) override
    {
        if (instance)
            instance->SetData(DATA_WAVE, me->GetEntry());
    }

    void EnterCombat(Unit* /*who*/) override
    {
        events.ScheduleEvent(EVENT_WEB, urand(5, 8) * IN_MILLISECONDS);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_WEB:
                    DoCastVictim(SPELL_WEB);
                    events.ScheduleEvent(EVENT_WEB, urand(7, 16) * IN_MILLISECONDS);
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }

private:
    InstanceScript* instance;
    EventMap events;
};

} // namespace

/*######
## go_gong
######*/

class go_gong : public GameObjectScript
{
public:
    go_gong() : GameObjectScript("go_gong") { }

    bool OnGossipHello(Player* /*player*/, GameObject* go) OVERRIDE
    {
        InstanceScript* instance = go->GetInstanceScript();
        if (!instance)
            return false;

        go->SendCustomAnim(0);
        instance->SetData(DATA_WAVE, IN_PROGRESS);
        return true;
    }
};

void AddSC_razorfen_downs()
{
    new npc_henry_stern();
    RegisterRazorfenDownsCreatureAI(npc_belnistrasz);
    RegisterRazorfenDownsCreatureAI(npc_idol_room_spawner);
    RegisterRazorfenDownsCreatureAI(npc_tomb_creature);
    new go_gong();
}
