/*
 * This file is part of the Project SkyFire. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/*
 * Ported to Project SkyFire from Legends-of-Azeroth-Pandaria-5.4.8 (src/server/scripts/EasternKingdoms/zone_*.cpp)
 * and from pandaria_5.4.8 by alexkulya (zone_gilneas.cpp: Duskhaven Watchman, Forsaken Catapult, Forsaken Invader), both GPL v2 or later.
 * Scripts SkyFire's world DB had no script for, ported (B21). Mechanical API changes by
 * skyfire_port_plan/tools/loa2sf.ps1, the rest by hand.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "ScriptedGossip.h"
#include "InstanceScript.h"
#include "SpellScript.h"
#include "SpellAuraEffects.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "Spell.h"
#include "Player.h"
#include "Group.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"
#include "CellImpl.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "PassiveAI.h"
#include "CombatAI.h"
#include "Vehicle.h"
#include "MoveSplineInit.h"
#include "TemporarySummon.h"
#include "Containers.h"
#include <random>

namespace
{
namespace tirisfal
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/EasternKingdoms/zone_tirisfal_glades.cpp
enum TirisfalGlades
{
    NPC_ARADNE                              = 50372,
    NPC_RISEN_RECRUIT                       = 50414,
    NPC_DEATHKNELL_GRAVE_TARGET             = 50373,
    NPC_MINDLESS_ZOMBIE                     = 1501,
    SPELL_RAISE_UNDEAD                      = 93446,
    SPELL_SUMMON_RISEN_DEAD                 = 93447,
    SPELL_DIRT_EXPLOSION                    = 89199,
    SPELL_CHURNING_DIRT                     = 92788,
    SPELL_ENRAGE                            = 44427,
    SPELL_RISEN_DEAD_TRANSFORM              = 93460,
    ARADNE_MOVEMENT_POINT_01                = 4,
    ARADNE_MOVEMENT_POINT_02                = 12,
    ARADNE_MOVEMENT_POINT_03                = 15,
    ARADNE_MOVEMENT_POINT_04                = 20,
    ARADNE_MOVEMENT_POINT_05                = 26,
    ARADNE_MOVEMENT_POINT_06                = 31,
    ARADNE_MOVEMENT_POINT_07                = 33,
    ARADNE_MOVEMENT_POINT_08                = 37,
    ARADNE_PHASE_00                         = 0,
    ARADNE_PHASE_01                         = 1,
    ARADNE_PHASE_02                         = 2,
    ARADNE_PHASE_03                         = 3,
    ARADNE_PHASE_04                         = 4,
    GRAVE_TARGET_PHASE_00                   = 0,
    GRAVE_TARGET_PHASE_01                   = 1,
    GRAVE_TARGET_PHASE_02                   = 2,
    GRAVE_TARGET_PHASE_03                   = 3,
    GRAVE_TARGET_PHASE_04                   = 4,
    RISEN_DEAD_PHASE_00                     = 0,
    RISEN_DEAD_PHASE_01                     = 1,
    RISEN_DEAD_PHASE_02                     = 2,
    RISEN_DEAD_PHASE_03                     = 3,
    RISEN_DEAD_PHASE_04                     = 4,
    ARADNE_TEXT_01                          = 0,
    RISEN_DEAD_TEXT_01                      = 0,
    RISEN_DEAD_TEXT_02                      = 1,
    RISEN_DEAD_TEXT_03                      = 2,
    RISEN_DEAD_TEXT_04                      = 3,
    RISEN_DEAD_TEXT_05                      = 4,
    RISEN_DEAD_TEXT_06                      = 5,
    RISEN_DEAD_TEXT_07                      = 6,
    RISEN_DEAD_TEXT_08                      = 7,
    RISEN_DEAD_TEXT_09                      = 8,
    RISEN_DEAD_TEXT_10                      = 9,
    RISEN_DEAD_TEXT_11                      = 10,
    RISEN_DEAD_PATH_01                      = 50374*100,
    RISEN_DEAD_PATH_02                      = 50374*100+01,
    RISEN_DEAD_VISUAL_EQUIP_WEAPON_01       = 10614,
    RISEN_DEAD_VISUAL_EQUIP_WEAPON_02       = 1984,
    UNDERTAKER_MORDO_PHASE_00               = 0,
    UNDERTAKER_MORDO_PHASE_01               = 1,
    UNDERTAKER_MORDO_PHASE_02               = 2,
    UNDERTAKER_MORDO_PHASE_03               = 3,
    UNDERTAKER_MORDO_PHASE_04               = 4,
    UNDERTAKER_MORDO_PHASE_05               = 5,
    UNDERTAKER_MORDO_PHASE_06               = 6,
    UNDERTAKER_MORDO_PHASE_07               = 7,
    UNDERTAKER_MORDO_PHASE_08               = 8,
    UNDERTAKER_MORDO_PHASE_09               = 9,
    UNDERTAKER_MORDO_TEXT_01                = 0,
    UNDERTAKER_MORDO_TEXT_02                = 1,
    RISEN_RECRUIT_TEXT_01                   = 0,
    RISEN_RECRUIT_PATH_01                   = 50414*100,
    RISEN_RECRUIT_PATH_02                   = 50414*100+01,
    MINDLESS_ZOMBIE_ATTACK_EVENT_STEP_01    = 1,
    MINDLESS_ZOMBIE_ATTACK_EVENT_STEP_02    = 2,
    QUEST_THE_SHADOW_GRAVE                  = 28608,
    SPELL_SUMMON_DARNELL                    = 91576,
    NPC_CAPTURED_PUDDLEJUMPER               = 38923,
    NPC_CAPTURED_ORACLE                     = 39078,
    SPELL_MURLOC_LEACH                      = 73108,
    SPELL_SUMMON_PUDDLEJUMPER               = 73110,
    SPELL_SUMMON_ORACLE                     = 73434,
    SPELL_VILE_FIN_GUARDIAN_AURA            = 94266,
    SPELL_LEAPING_RUSH                      = 75002,
    SPELL_LIGHTNING_BOLT                    = 9532,
    SPELL_LIGHTNING_SHIELD                  = 12550,
    NPC_DELIVERED_MURLOC_CREDIT             = 38887,
    QUEST_EVER_SO_LONELY                    = 24974,
    TEXT_CAPTURE_READY                      = 0,
    EVENT_CHECK_PLAYER                      = 999
};

// ===== npc_aradne
struct npc_aradne : public ScriptedAI
{
    npc_aradne(Creature *c) : ScriptedAI(c) { }

    uint32 m_timer;
    uint32 m_phase;

    void Reset() override
    {
        m_timer = 0;
        m_phase = TirisfalGlades::ARADNE_PHASE_00;
    }

    void MovementInform(uint32 type, uint32 id) override
    {
        if (type == MovementGeneratorType::WAYPOINT_MOTION_TYPE)
        {
            switch (id)
            {
                case TirisfalGlades::ARADNE_MOVEMENT_POINT_01:
                    m_phase = TirisfalGlades::ARADNE_PHASE_01;
                    m_timer = 100;
                    break;
                case TirisfalGlades::ARADNE_MOVEMENT_POINT_02:
                    m_phase = TirisfalGlades::ARADNE_PHASE_01;
                    m_timer = 100;
                    break;
                case TirisfalGlades::ARADNE_MOVEMENT_POINT_03:
                    m_phase = TirisfalGlades::ARADNE_PHASE_01;
                    m_timer = 100;
                    break;
                case TirisfalGlades::ARADNE_MOVEMENT_POINT_04:
                    m_phase = TirisfalGlades::ARADNE_PHASE_01;
                    m_timer = 100;
                    break;
                case TirisfalGlades::ARADNE_MOVEMENT_POINT_05:
                    m_phase = TirisfalGlades::ARADNE_PHASE_01;
                    m_timer = 100;
                    break;
                case TirisfalGlades::ARADNE_MOVEMENT_POINT_06:
                    m_phase = TirisfalGlades::ARADNE_PHASE_01;
                    m_timer = 100;
                    break;
                case TirisfalGlades::ARADNE_MOVEMENT_POINT_07:
                    m_phase = TirisfalGlades::ARADNE_PHASE_01;
                    m_timer = 100;
                    break;
                case TirisfalGlades::ARADNE_MOVEMENT_POINT_08:
                    m_phase = TirisfalGlades::ARADNE_PHASE_01;
                    m_timer = 100;
                    break;
            }
        }
    }

    void UpdateAI(const uint32 diff) override
    {
        if (m_timer <= diff)
        {
            m_timer = 1 * TimeConstants::IN_MILLISECONDS;
            StartAnimation();
        }
        else m_timer -= diff;
    }

    void StartAnimation()
    {
        switch (m_phase)
        {
            case TirisfalGlades::ARADNE_PHASE_01:
                if (Creature* npc = me->FindNearestCreature(TirisfalGlades::NPC_DEATHKNELL_GRAVE_TARGET, 15.0f))
                    me->SetFacingToObject(npc);

                m_timer = 500;
                m_phase = TirisfalGlades::ARADNE_PHASE_02;
                break;

            case TirisfalGlades::ARADNE_PHASE_02:
                if (Creature* npc = me->FindNearestCreature(TirisfalGlades::NPC_DEATHKNELL_GRAVE_TARGET, 15.0f))
                    me->CastSpell(npc, TirisfalGlades::SPELL_RAISE_UNDEAD, false);

                m_timer = 2 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::ARADNE_PHASE_03;
                break;
            case TirisfalGlades::ARADNE_PHASE_03:
                Talk(TirisfalGlades::ARADNE_TEXT_01);
                m_timer = 500;
                m_phase = TirisfalGlades::ARADNE_PHASE_04;
                break;
            default:
                m_timer = 0;
                m_phase = TirisfalGlades::ARADNE_PHASE_00;
                break;
        }
    }
};

// ===== npc_deathknell_grave_target
struct npc_deathknell_grave_target : public ScriptedAI
{
    npc_deathknell_grave_target(Creature *c) : ScriptedAI(c) { }

    uint32 m_timer;
    uint32 m_phase;

    void Reset() override
    {
        m_timer = 0;
        m_phase = TirisfalGlades::GRAVE_TARGET_PHASE_00;
    }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        if (spell->Id == TirisfalGlades::SPELL_RAISE_UNDEAD)
        {
            m_timer = 100;
            m_phase = TirisfalGlades::GRAVE_TARGET_PHASE_01;
        }
    }

    void UpdateAI(const uint32 diff) override
    {
        if (m_timer <= diff)
        {
            m_timer = 1 * TimeConstants::IN_MILLISECONDS;
            StartAnimation();
        }
        else m_timer -= diff;
    }

    void StartAnimation()
    {
        switch (m_phase)
        {
            case TirisfalGlades::GRAVE_TARGET_PHASE_01:
                DoCast(me, TirisfalGlades::SPELL_DIRT_EXPLOSION);
                DoCast(me, TirisfalGlades::SPELL_CHURNING_DIRT);
                m_phase = TirisfalGlades::GRAVE_TARGET_PHASE_02;
                break;
            case TirisfalGlades::GRAVE_TARGET_PHASE_02:
                me->CastSpell(me, SPELL_SUMMON_RISEN_DEAD, true);
                m_phase = TirisfalGlades::GRAVE_TARGET_PHASE_03;
                m_timer = 3 * TimeConstants::IN_MILLISECONDS;
                break;
            case TirisfalGlades::GRAVE_TARGET_PHASE_03:
                me->RemoveAllAuras();
                m_phase = TirisfalGlades::GRAVE_TARGET_PHASE_04;
                break;
            case TirisfalGlades::GRAVE_TARGET_PHASE_04:
                m_timer = 0;
                m_phase = TirisfalGlades::GRAVE_TARGET_PHASE_00;
                break;
        }
    }
};

// ===== npc_mindless_zombie
struct npc_mindless_zombie : public ScriptedAI
{
    npc_mindless_zombie(Creature *c) : ScriptedAI(c) { }

    EventMap events;
    bool _crazed;

    void Reset() override
    {
        me->RemoveAllAuras();
        _crazed = false;
        me->GetMotionMaster()->MoveRandom(15.f);

        if (!_crazed && roll_chance_i(20))
        {
            _crazed = true;
            events.ScheduleEvent(TirisfalGlades::MINDLESS_ZOMBIE_ATTACK_EVENT_STEP_01, urand(28, 57) * TimeConstants::IN_MILLISECONDS);
        }
    }

    void UpdateAI(const uint32 diff) override
    {
        events.Update(diff);

        if (!me->IsInCombat())
        {
            if (Player* player = me->SelectNearestPlayer(15.0f))
            {
                if (!player->IsInCombat())
                {
                    while (uint32 eventId = events.ExecuteEvent())
                    {
                        switch (eventId)
                        {
                            case TirisfalGlades::MINDLESS_ZOMBIE_ATTACK_EVENT_STEP_01:
                            {
                                me->SetFacingToObject(player);
                                me->CastSpell(me, TirisfalGlades::SPELL_ENRAGE, true);
                                me->SetWalk(false);
                                me->GetMotionMaster()->MoveFollow(player, 1.0f, 0.0f);
                                events.ScheduleEvent(TirisfalGlades::MINDLESS_ZOMBIE_ATTACK_EVENT_STEP_02, urand(4, 6) * TimeConstants::IN_MILLISECONDS);
                                break;
                            }
                            case TirisfalGlades::MINDLESS_ZOMBIE_ATTACK_EVENT_STEP_02:
                            {
                                me->GetMotionMaster()->Clear();
                                me->GetMotionMaster()->MoveRandom(15.f);
                                me->RemoveAllAuras();
                                break;
                            }
                        }
                    }
                }
            }
        }

        DoMeleeAttackIfReady();
    }
};

// ===== npc_risen_dead
struct npc_risen_dead : public ScriptedAI
{
    npc_risen_dead(Creature *c) : ScriptedAI(c) { }

    uint32 m_timer;
    uint32 m_phase;
    uint32 m_WishToBeDead;

    void Reset() override
    {
        m_timer = 2 * TimeConstants::IN_MILLISECONDS;
        m_phase = TirisfalGlades::RISEN_DEAD_PHASE_00;
        m_WishToBeDead = urand(0, 100);
    }

    void UpdateAI(const uint32 diff) override
    {
        if (m_timer <= diff)
        {
            m_timer = 1 * TimeConstants::IN_MILLISECONDS;
            StartAnimation();
        }
        else m_timer -= diff;
    }

    void StartAnimation()
    {
        if (m_WishToBeDead < 33)
            ShowDeadScene();
        else if (m_WishToBeDead < 66)
            ShowLifeScene();
        else
            ShowRunningScene();
    }

    void ShowDeadScene()
    {
        switch (m_phase)
        {
            case TirisfalGlades::RISEN_DEAD_PHASE_00:
                me->HandleEmoteCommand(Emote::EMOTE_ONESHOT_QUESTION);
                m_timer = 200;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_01;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_01:
                if (Creature* aradne = me->FindNearestCreature(TirisfalGlades::NPC_ARADNE, 20.0f))
                    Talk(TirisfalGlades::RISEN_DEAD_TEXT_08, aradne);

                m_timer = 5 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_02;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_02:
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_03);
                m_timer = 5 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_03;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_03:
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_02);
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_09);
                me->Kill(me);
                m_timer = 5 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_04;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_04:
                m_timer = 0;
                me->DespawnOrUnsummon();
                break;
        }
    }

    void ShowRunningScene()
    {
        switch (m_phase)
        {
            case TirisfalGlades::RISEN_DEAD_PHASE_00:
                me->HandleEmoteCommand(Emote::EMOTE_ONESHOT_QUESTION);
                m_timer = 200;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_01;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_01:
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_01);
                m_timer = 5 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_02;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_02:
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_04);
                m_timer = 5 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_03;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_03:
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_07);
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_10);
                me->UpdateEntry(NPC_MINDLESS_ZOMBIE);
                me->CastSpell(me, TirisfalGlades::SPELL_ENRAGE, true);
                me->GetMotionMaster()->MovePath(RISEN_DEAD_PATH_01, false);
                m_timer = 10 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_04;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_04:
                m_timer = 0;
                me->DespawnOrUnsummon();
                break;
        }
    }

    void ShowLifeScene()
    {
        switch (m_phase)
        {
            case TirisfalGlades::RISEN_DEAD_PHASE_00:
                me->HandleEmoteCommand(EMOTE_ONESHOT_QUESTION);
                m_timer = 200;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_01;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_01:
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_01);
                m_timer = 5 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_02;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_02:
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_06);
                m_timer = 5 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_03;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_03:
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_05);
                Talk(TirisfalGlades::RISEN_DEAD_TEXT_11);
                SetEquipmentSlots(false, RISEN_DEAD_VISUAL_EQUIP_WEAPON_01, RISEN_DEAD_VISUAL_EQUIP_WEAPON_02);
                me->GetMotionMaster()->MovePath(RISEN_DEAD_PATH_02, false);
                m_timer = 40 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::RISEN_DEAD_PHASE_04;
                break;
            case TirisfalGlades::RISEN_DEAD_PHASE_04:
                m_timer = 0;
                me->DespawnOrUnsummon();
                break;
        }
    }
};

// ===== npc_sedrick_calston
struct npc_sedrick_calston : public ScriptedAI
{
    npc_sedrick_calston(Creature* creature) : ScriptedAI(creature) { }

    EventMap m_events;

    void Reset() override
    {
        m_events.Reset();
        m_events.ScheduleEvent(TirisfalGlades::EVENT_CHECK_PLAYER, 1 * IN_MILLISECONDS);
    }

    void UpdateAI(const uint32 diff) override
    {
        m_events.Update(diff);

        while (uint32 eventId = m_events.ExecuteEvent())
        {
            switch (eventId)
            {
                case TirisfalGlades::EVENT_CHECK_PLAYER:
                {
                    if (Player* player = me->FindNearestPlayer(7.0f))
                    {
                        if (player->GetQuestStatus(TirisfalGlades::QUEST_EVER_SO_LONELY) == QUEST_STATUS_INCOMPLETE)
                        {
                            std::list<Creature*> npcs, oracles;
                            GetCreatureListWithEntryInGrid(npcs, me, TirisfalGlades::NPC_CAPTURED_PUDDLEJUMPER, 10.0f);
                            GetCreatureListWithEntryInGrid(oracles, me, TirisfalGlades::NPC_CAPTURED_ORACLE, 10.0f);
                            npcs.splice(npcs.end(), oracles);

                            if (npcs.size() > 0)
                            {
                                player->RemoveAura(TirisfalGlades::SPELL_VILE_FIN_GUARDIAN_AURA);
                                player->KilledMonsterCredit(TirisfalGlades::NPC_DELIVERED_MURLOC_CREDIT);

                                for (std::list<Creature*>::iterator itr = npcs.begin(); itr != npcs.end(); ++itr)
                                    (*itr)->DespawnOrUnsummon(1);
                            }
                        }
                    }

                    m_events.ScheduleEvent(TirisfalGlades::EVENT_CHECK_PLAYER, 1 * IN_MILLISECONDS);
                    break;
                }
            }
        }

        if (!UpdateVictim())
            return;
        else
            DoMeleeAttackIfReady();
    }
};

// ===== npc_undertaker_mordo
struct npc_undertaker_mordo : public ScriptedAI
{
    npc_undertaker_mordo(Creature *c) : ScriptedAI(c) { }

    uint32 m_timer;
    uint32 m_phase;
    Creature* m_npc;

    void Reset() override
    {
        m_timer = urand(30, 45) * TimeConstants::IN_MILLISECONDS;
        m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_00;
        m_npc = nullptr;
    }

    void UpdateAI(const uint32 diff) override
    {
        if (m_timer <= diff)
        {
            m_timer = 1 * TimeConstants::IN_MILLISECONDS;
            StartAnimation();
        }
        else m_timer -= diff;
    }

    void StartAnimation()
    {
        switch (m_phase)
        {
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_00:
                if (Creature* npc_trigger = me->FindNearestCreature(TirisfalGlades::NPC_DEATHKNELL_GRAVE_TARGET, 20.0f))
                    if (m_npc = me->SummonCreature(TirisfalGlades::NPC_RISEN_RECRUIT, npc_trigger->GetPositionX(), npc_trigger->GetPositionY(), npc_trigger->GetPositionZ(), 1.0f, TempSummonType::TEMPSUMMON_TIMED_DESPAWN, Milliseconds(46 * TimeConstants::IN_MILLISECONDS)))
                        m_npc->GetMotionMaster()->MovePath(TirisfalGlades::RISEN_RECRUIT_PATH_01, false);

                m_timer = 5 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_01;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_01:
                Talk(UNDERTAKER_MORDO_TEXT_01);
                //me->HandleEmoteCommand(Emote::EMOTE_ONESHOT_TALK);
                m_timer = 3 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_02;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_02:
                //if (m_npc && m_npc->IsAlive())
                {
                    //m_npc->SetStandState(UnitStandStateType::UNIT_STAND_STATE_KNEEL);
                    //m_npc->SetFacingToObject(me);
                }
                m_timer = 1 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_03;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_03:
                //me->m_Events.Schedule(4 * TimeConstants::IN_MILLISECONDS, [this]() { me->SetUInt32Value(UNIT_FIELD_NPC_EMOTESTATE, Emote::EMOTE_STATE_USE_STANDING); });
                //me->m_Events.Schedule(6 * TimeConstants::IN_MILLISECONDS, [this]() { me->SetUInt32Value(UNIT_FIELD_NPC_EMOTESTATE, Emote::EMOTE_STATE_NONE); });
                m_timer = 7500;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_04;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_04:
                //me->HandleEmoteCommand(Emote::EMOTE_ONESHOT_POINT);
                m_timer = 3500;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_05;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_05:
                Talk(UNDERTAKER_MORDO_TEXT_02);
                //me->HandleEmoteCommandWithDelay(1 * TimeConstants::IN_MILLISECONDS, Emote::EMOTE_ONESHOT_TALK);
                m_timer = 500;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_06;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_06:
                //if (m_npc && m_npc->IsAlive())
                {
                    //m_npc->AddAura(TirisfalGlades::SPELL_RISEN_DEAD_TRANSFORM, m_npc);
                    //m_npc->CastSpell(m_npc, TirisfalGlades::SPELL_RISEN_DEAD_TRANSFORM);
                    //m_npc->SetDisplayId(36775);
                    //m_npc->SetStandState(UnitStandStateType::UNIT_STAND_STATE_STAND);
                }
                m_timer = 2 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_07;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_07:
                //if (m_npc && m_npc->IsAlive())
                {
                    //m_npc->HandleEmoteCommand(Emote::EMOTE_ONESHOT_TALK);
                    //m_npc->AI()->Talk(RISEN_RECRUIT_TEXT_01);
                }
                m_timer = 3 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_08;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_08:
                //if (m_npc && m_npc->IsAlive())
                    //m_npc->HandleEmoteCommand(Emote::EMOTE_ONESHOT_SALUTE);
                m_timer = 2 * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_09;
                break;
            case TirisfalGlades::UNDERTAKER_MORDO_PHASE_09:
                //if (m_npc && m_npc->IsAlive())
                    //m_npc->GetMotionMaster()->MovePath(TirisfalGlades::RISEN_RECRUIT_PATH_02, false);
                m_timer = urand(15, 45) * TimeConstants::IN_MILLISECONDS;
                m_phase = TirisfalGlades::UNDERTAKER_MORDO_PHASE_00;
                break;
        }
    }

    void sQuestAccept(Player* player, Quest const* quest) override
    {
        if (quest->GetQuestId() == TirisfalGlades::QUEST_THE_SHADOW_GRAVE)
            player->CastSpell(player, TirisfalGlades::SPELL_SUMMON_DARNELL);
    }
};

// ===== npc_vile_fin_minor_oracle
struct npc_vile_fin_minor_oracle : public ScriptedAI
{
    npc_vile_fin_minor_oracle(Creature* creature) : ScriptedAI(creature) { }

    uint64 m_playerGUID;
    uint32 m_lightning_bolt_timer;
    uint32 m_lightning_shield_timer;

    void Reset() override
    {
        uint64 m_playerGUID = 0;
        m_lightning_bolt_timer = urand(3400, 4700);
        me->CastSpell(me, TirisfalGlades::SPELL_LIGHTNING_SHIELD);
        m_lightning_shield_timer = 10 * MINUTE * IN_MILLISECONDS;
    }

    void DamageTaken(Unit* attacker, uint32& damage) override
    {
        if (Player* player = attacker->ToPlayer())
        {
            if (me->GetHealthPct() <= 15.0f)
            {
                Talk(TirisfalGlades::TEXT_CAPTURE_READY);
                me->GetMotionMaster()->MoveIdle();
                me->GetMotionMaster()->MoveFleeing(player);
            }
        }
    }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        if (caster->ToPlayer())
        {
            if (spell->Id == TirisfalGlades::SPELL_MURLOC_LEACH)
            {
                me->CastSpell(caster, TirisfalGlades::SPELL_SUMMON_ORACLE, true);
                me->DespawnOrUnsummon(500);
            }
        }
    }

    void UpdateAI(const uint32 diff) override
    {
        if (m_lightning_shield_timer <= diff)
        {
            me->CastSpell(me, TirisfalGlades::SPELL_LIGHTNING_SHIELD);
            m_lightning_shield_timer = 10 * MINUTE * IN_MILLISECONDS;
        }
        else
            m_lightning_shield_timer -= diff;

        if (UpdateVictim())
        {
            if (m_lightning_bolt_timer <= diff)
            {
                DoCastVictim(TirisfalGlades::SPELL_LIGHTNING_BOLT);
                m_lightning_bolt_timer = urand(3400, 4700);
            }
            else
                m_lightning_bolt_timer -= diff;

            DoMeleeAttackIfReady();
        }
    }
};

// ===== npc_vile_fin_puddlejumper
struct npc_vile_fin_puddlejumper : public ScriptedAI
{
    npc_vile_fin_puddlejumper(Creature* creature) : ScriptedAI(creature) { }

    uint64 m_playerGUID;

    void Reset() override
    {
        uint64 m_playerGUID = 0;
    }

    void EnterCombat(Unit* who) override
    {
        me->CastSpell(who, TirisfalGlades::SPELL_LEAPING_RUSH);
    }

    void DamageTaken(Unit* attacker, uint32& damage) override
    { 
        if (Player* player = attacker->ToPlayer())
        {
            if (me->GetHealthPct() <= 15.0f)
            {
                Talk(TirisfalGlades::TEXT_CAPTURE_READY);
                me->GetMotionMaster()->MoveIdle();
                me->GetMotionMaster()->MoveFleeing(player);
            }
        }
    }

    void SpellHit(Unit* caster, SpellInfo const* spell) override
    {
        if (caster->ToPlayer())
        {
            if (spell->Id == TirisfalGlades::SPELL_MURLOC_LEACH)
            {
                me->CastSpell(caster, TirisfalGlades::SPELL_SUMMON_PUDDLEJUMPER, true);
                me->DespawnOrUnsummon(500);
            }
        }
    }

    void UpdateAI(const uint32 diff) override
    {
        if (UpdateVictim())
            DoMeleeAttackIfReady();
    }
};
} // namespace tirisfal

namespace gilneas
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/EasternKingdoms/zone_gilneas.cpp
enum Gilneas
{
    ACTION_START_KOROTH_EVENT               = 1,
    EVENT_KOROTH_THE_HILLBREAKER_2          = 2,
    SAY_KOROTH_THE_HILLBREAKER_1            = 0,
    SAY_KOROTH_THE_HILLBREAKER_2            = 1
};
uint8 const KorothPathLenght = 2;
Position const KorothPath[][KorothPathLenght] =
{
    {
        { -2271.431f, 1963.941f, 99.342613f, 0.0f },
        { -2284.237f, 1963.801f, 95.656654f, 0.0f },
    },
};

// ===== npc_koroth_the_hillbreaker
struct npc_koroth_the_hillbreaker : public ScriptedAI
{
    npc_koroth_the_hillbreaker(Creature* creature) : ScriptedAI(creature) { }

    EventMap m_events;

    void DoAction(int32 const action) override
    {
        switch (action)
        {
            case ACTION_START_KOROTH_EVENT:
                Talk(SAY_KOROTH_THE_HILLBREAKER_1);
                {
                    Movement::MoveSplineInit init(me);
                    for (uint8 i = 0; i < KorothPathLenght; ++i)
                        init.Path().push_back(G3D::Vector3(KorothPath[0][i].GetPositionX(), KorothPath[0][i].GetPositionY(), KorothPath[0][i].GetPositionZ()));
                    init.SetWalk(true);
                    init.Launch();
                }
                //TalkWithDelay(me->GetSplineDuration(), SAY_KOROTH_THE_HILLBREAKER_2);
                m_events.ScheduleEvent(EVENT_KOROTH_THE_HILLBREAKER_2, me->GetSplineDuration());

                me->m_Events.Schedule(me->GetSplineDuration() + 3500, [this]()
                {
                    me->GetMotionMaster()->MoveTargetedHome();
                });
                break;
        }
    }

    void UpdateAI(uint32 const diff) override
    {
        
       m_events.Update(diff);

        while (uint32 eventId = m_events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_KOROTH_THE_HILLBREAKER_2:
                {
                    Talk(SAY_KOROTH_THE_HILLBREAKER_2);
                    break;
                }

            }
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};
} // namespace gilneas

namespace gilneas_pan
{
// from pandaria_5.4.8-git/src/server/scripts/EasternKingdoms/Zones/zone_gilneas.cpp
enum Gilneas
{
    EVENT_SEARCH_INVADER                    = 1,
    EVENT_SEARCH_FOOTSOLDIER                = 2,
    EVENT_SEARCH_WATCHMAN                   = 3,
    NPC_ENTRY_INVADER                       = 34511,
    NPC_ENTRY_FOOTSOLDIER                   = 36236,
    NPC_ENTRY_WATCHMAN                      = 36211,
    EVENT_LAUNCH_BOULDER                    = 1,
    EVENT_DESPAWN_CATAPULT                  = 2,
    EVENT_CHECK_PASSENGER                   = 3,
    SPELL_LAUNCH_BOULDER                    = 68591,
    QUEST_ENTRY_TWO_BY_SEA                  = 14382,
};

// ===== npc_duskhaven_watchman
struct npc_duskhaven_watchman : public ScriptedAI
{
    npc_duskhaven_watchman(Creature* creature) : ScriptedAI(creature)
    {
        events.ScheduleEvent(EVENT_SEARCH_INVADER, 2s);
    }

    EventMap events;

    void DamageTaken(Unit* who, uint32& damage)
    {
        if (who && who->ToCreature() && (who->GetEntry() == NPC_ENTRY_INVADER || who->GetEntry() == NPC_ENTRY_FOOTSOLDIER))
            damage = 0;
    }

    void UpdateAI(uint32 diff)
    {
        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch(eventId)
            {
                case EVENT_SEARCH_INVADER:
                {
                    if (!me->IsInCombat())
                    {
                        if (Creature* invader = me->FindNearestCreature(NPC_ENTRY_INVADER, 15.5f, true))
                            AttackStart(invader);
                    }
                    else
                        events.RescheduleEvent(EVENT_SEARCH_INVADER, randtime(2s, 5s));
                    break;
                }
                case EVENT_SEARCH_FOOTSOLDIER:
                {
                    if (!me->IsInCombat())
                    {
                        if (Creature* footsoldier = me->FindNearestCreature(NPC_ENTRY_FOOTSOLDIER, 15.5f, true))
                            AttackStart(footsoldier);
                    }
                    else
                        events.RescheduleEvent(EVENT_SEARCH_FOOTSOLDIER, randtime(2s, 5s));
                    break;
                }
                default:
                    break;
            }
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

// ===== npc_forsaken_catapult
class npc_forsaken_catapult : public CreatureScript
{
public:
    npc_forsaken_catapult() : CreatureScript("npc_forsaken_catapult") { }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (player->GetQuestStatus(QUEST_ENTRY_TWO_BY_SEA) == QUEST_STATUS_INCOMPLETE)
        {
            if (player->GetVehicleBase())
                return true;

            player->EnterVehicle(creature, 0);
            return true;
        }
        return true;
    }

    struct npc_forsaken_catapultAI : public ScriptedAI
    {
        npc_forsaken_catapultAI(Creature* creature) : ScriptedAI(creature)
        {
            events.ScheduleEvent(EVENT_LAUNCH_BOULDER, randtime(8s, 20s));
            events.ScheduleEvent(EVENT_CHECK_PASSENGER, 5s);
        }

        EventMap events;

        void OnCharmed(bool apply) { }

        void Reset()
        {
            events.ScheduleEvent(EVENT_LAUNCH_BOULDER, randtime(8s, 20s));
            events.ScheduleEvent(EVENT_CHECK_PASSENGER, 5s);
            me->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
            me->setFaction(1735);
            me->SetReactState(REACT_PASSIVE);
        }

        void UpdateAI(uint32 diff)
        {
            events.Update(diff);

            while (uint32 eventId = events.ExecuteEvent())
            {
                switch(eventId)
                {
                    case EVENT_LAUNCH_BOULDER:
                    {
                        if (Unit* passenger = me->GetVehicleKit()->GetPassenger(0))
                        {
                            if (passenger->GetTypeId() != TypeID::TYPEID_PLAYER)
                            {
                                if (!me->HasUnitState(UNIT_STATE_CASTING))
                                {
                                    DoCast(SPELL_LAUNCH_BOULDER);
                                    events.RescheduleEvent(EVENT_LAUNCH_BOULDER, randtime(5s, 12s));
                                }
                                else
                                    events.RescheduleEvent(EVENT_LAUNCH_BOULDER, 1s);
                            }
                        }
                        else
                        {
                            events.CancelEvent(EVENT_LAUNCH_BOULDER);
                            events.ScheduleEvent(EVENT_DESPAWN_CATAPULT, 10s);
                        }
                        break;
                    }
                    case EVENT_DESPAWN_CATAPULT:
                    {
                        Unit* passenger1 = me->GetVehicleKit()->GetPassenger(0);
                        Unit* passenger2 = me->GetVehicleKit()->GetPassenger(1);
                        
                        if (!passenger1 && !passenger2)
                            me->DisappearAndDie();
                        else
                            events.RescheduleEvent(EVENT_DESPAWN_CATAPULT, 2s);
                        break;
                    }
                    case EVENT_CHECK_PASSENGER:
                    {
                        Unit* passenger1 = me->GetVehicleKit()->GetPassenger(0);
                        Unit* passenger2 = me->GetVehicleKit()->GetPassenger(1);
                        
                        if (!passenger1 && !passenger2)
                        {
                            me->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            me->setFaction(35);
                            events.CancelEvent(EVENT_CHECK_PASSENGER);
                        }
                        else
                            events.RescheduleEvent(EVENT_CHECK_PASSENGER, 2500);
                        break;
                    }
                    default:
                        break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_forsaken_catapultAI (creature);
    }
};

// ===== npc_forsaken_invader
struct npc_forsaken_invader : public ScriptedAI
{
    npc_forsaken_invader(Creature* creature) : ScriptedAI(creature)
    {
        events.ScheduleEvent(EVENT_SEARCH_WATCHMAN, 2s);
    }

    EventMap events;

    void DamageTaken(Unit* who, uint32& damage)
    {
        if (who->ToCreature() && who->GetEntry() == NPC_ENTRY_WATCHMAN)
            damage = 0;
    }

    void UpdateAI(uint32 diff)
    {
        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch(eventId)
            {
                case EVENT_SEARCH_WATCHMAN:
                {
                    if (!me->IsInCombat())
                    {
                        if (Creature* watchman = me->FindNearestCreature(NPC_ENTRY_WATCHMAN, 15.5f, true))
                            AttackStart(watchman);
                    }
                    else
                        events.RescheduleEvent(EVENT_SEARCH_WATCHMAN, randtime(2s, 5s));
                    break;
                }
                default:
                    break;
            }
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};
} // namespace gilneas_pan

namespace silverpine
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/EasternKingdoms/zone_silverpine_forest.cpp
enum FenwickThatros
{
    SAY_FENWICK_AGGRO          = 0,
    SPELL_DRINK_HEALING_POTION = 54633,
    SPELL_POTION_OF_STRENGTH   = 80471,
    SPELL_ELIXIR_OF_AGILITY    = 80472,
    SPELL_TONIC_OF_HEALTH      = 80473,
    EVENT_BUFF_STRENGTH        = 1,
    EVENT_BUFF_AGILITY         = 2,
    EVENT_BUFF_STAMINA         = 3,
    EVENT_HEALING              = 4
};

// ===== npc_fenwick_thatros
struct npc_fenwick_thatros : public ScriptedAI
{
    npc_fenwick_thatros(Creature* creature) : ScriptedAI(creature) {}

    void Reset() override
    {
        half_hp_reached_once = false;
        events.Reset();
    }

    void EnterCombat(Unit* /*who*/) override
    {
        Talk(SAY_FENWICK_AGGRO);
        events.ScheduleEvent(EVENT_BUFF_STRENGTH, 3000);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& /*damage*/) override
    {
        if (!half_hp_reached_once && !HealthAbovePct(50))
        {
            half_hp_reached_once = true;
            me->CastSpell(me, SPELL_DRINK_HEALING_POTION);
            events.ScheduleEvent(EVENT_HEALING, 10000);
        }
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
                case EVENT_BUFF_STRENGTH:
                    me->CastSpell(me, SPELL_POTION_OF_STRENGTH);
                    events.ScheduleEvent(EVENT_BUFF_AGILITY, 3000);
                    break;
                case EVENT_BUFF_AGILITY:
                    me->CastSpell(me, SPELL_ELIXIR_OF_AGILITY);
                    events.ScheduleEvent(EVENT_BUFF_STAMINA, 3000);
                    break;
                case EVENT_BUFF_STAMINA:
                    me->CastSpell(me, SPELL_TONIC_OF_HEALTH);
                    break;
                case EVENT_HEALING:
                    if (!HealthAbovePct(50))
                    {
                        me->CastSpell(me, SPELL_DRINK_HEALING_POTION);
                        events.ScheduleEvent(EVENT_HEALING, 10000);
                    }
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
private:
    EventMap events;
    bool half_hp_reached_once = false;
};
} // namespace silverpine

namespace elwynn
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/EasternKingdoms/zone_elwynn_forest.cpp
enum ElwynnForest
{
    INFANTRY_HELP_YELL                      = 0,
    NPC_STORMWIND_INFANTRY                  = 49869,
    SPELL_FORTITUDE                         = 13864,
    SPELL_PENANCE                           = 66097,
    SPELL_FLASH_HEAL                        = 38588,
    SPELL_RENEW                             = 8362,
    SPELL_REVIVE                            = 93799,
    BROTHER_PAXTON_TEXT                     = 0,
    BROTHER_PAXTON_TEXT_PLAYER              = 1,
    BROTHER_PAXTON_HEAL_EVENT_01            = 0,
    BROTHER_PAXTON_HEAL_EVENT_02            = 1,
    BROTHER_PAXTON_HEAL_EVENT_03            = 2,
    BROTHER_PAXTON_HEAL_EVENT_04            = 3,
    HEAL_EVENT_01_STEP_01                   = 1,
    HEAL_EVENT_01_STEP_02                   = 2,
    HEAL_EVENT_01_STEP_03                   = 3,
    HEAL_EVENT_01_STEP_04                   = 4,
    HEAL_EVENT_02_STEP_01                   = 5,
    HEAL_EVENT_02_STEP_02                   = 6,
    HEAL_EVENT_02_STEP_03                   = 7,
    HEAL_EVENT_02_STEP_04                   = 8,
    HEAL_EVENT_03_STEP_01                   = 9,
    HEAL_EVENT_03_STEP_02                   = 10,
    HEAL_EVENT_03_STEP_03                   = 11,
    HEAL_EVENT_03_STEP_04                   = 12,
    HEAL_EVENT_04_STEP_01                   = 13,
    HEAL_EVENT_04_STEP_02                   = 14,
    HEAL_EVENT_04_STEP_03                   = 15,
    HEAL_EVENT_04_STEP_04                   = 16,
    HEAL_EVENT_RESET                        = 17,
    SAY_INTRO                               = 0,
    SAY_SPECIAL_1                           = 1,
    SAY_SPECIAL_2                           = 2,
    SAY_SPECIAL_3                           = 3,
    SAY_SPECIAL_4                           = 4,
    SAY_SPECIAL_5                           = 5,
    SAY_SPECIAL_6                           = 6,
    SAY_SPECIAL_7                           = 7,
    SAY_SPECIAL_8                           = 8,
    SAY_SPECIAL_9                           = 9,
    SAY_SPECIAL_10                          = 10,
    SAY_SPECIAL_11                          = 11,
    SAY_SPECIAL_12                          = 12,
    SAY_SPECIAL_13                          = 13,
    SAY_SPECIAL_14                          = 14,
    SAY_SPECIAL_15                          = 15,
    SAY_SPECIAL_16                          = 16,
    SAY_SPECIAL_17                          = 17,
    SAY_SPECIAL_18                          = 18,
    SAY_SPECIAL_19                          = 19,
    QUEST_ALLIANCE_WAY                      = 30988,
    QUEST_AN_OLD_PIT_FIGHTER                = 30989,
    NPC_WALK_WITH_VARIAN_CREDIT             = 61798,
    NPC_FIGHT_WITH_VARIAN_CREDIT            = 61824,
    SPELL_SUMMON_VARIAN                     = 120352,
    ACTION_AN_OLD_PIT_FIGHTER               = 1
};
const Position VarianPath[9]
{
    { -8363.68f, 241.96f, 155.31f, 1.50f },
    { -8358.11f, 258.80f, 155.34f, 1.25f },
    { -8343.70f, 269.41f, 155.34f, 0.63f },
    { -8325.33f, 246.29f, 155.34f, 5.39f },
    { -8277.68f, 283.86f, 155.34f, 0.67f },
    { -8315.63f, 331.37f, 155.34f, 2.25f },
    { -8339.31f, 312.58f, 155.34f, 3.76f },
    { -8334.64f, 307.08f, 157.34f, 5.34f },
    { -8323.51f, 293.86f, 156.83f, 5.34f },
};
const Position VarianHomePath[3]
{
    { -8338.44f, 274.53f, 157.34f, 3.78f },
    { -8362.87f, 254.89f, 155.34f, 3.78f },
    { -8363.05f, 232.23f, 157.07f, 2.23f },
};

// ===== npc_varian_wrynn_alliance_way_quest
// Varian Wrynn Alliance Way 61796
class npc_varian_wrynn_alliance_way_quest : public CreatureScript
{
    public:
        npc_varian_wrynn_alliance_way_quest() : CreatureScript("npc_varian_wrynn_alliance_way_quest") { }

        bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_AN_OLD_PIT_FIGHTER)
                player->CastSpell(creature, SPELL_SUMMON_VARIAN, true);

            return false;
        }

        struct npc_varian_wrynn_alliance_way_questAI : public ScriptedAI
        {
            npc_varian_wrynn_alliance_way_questAI(Creature* creature) : ScriptedAI(creature) { }

            uint64 summonerGUID;
            uint32 delay;

            void IsSummonedBy(Unit* summoner) override
            {
                summonerGUID = summoner->GetGUID();
                me->SetFacingToObject(summoner);
                me->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);
                me->SetPhaseMask(2, true);

                if (summoner->ToPlayer() && summoner->ToPlayer()->GetQuestStatus(QUEST_ALLIANCE_WAY) == QUEST_STATUS_REWARDED)
                {
                    DoAction(ACTION_AN_OLD_PIT_FIGHTER);
                    return;
                }

                delay = 0;
                me->m_Events.Schedule(delay += 1500, 17, [this]()
                {
                    Movement::MoveSplineInit init(me);
                    for (auto itr : VarianPath)
                        init.Path().push_back(G3D::Vector3(itr.GetPositionX(), itr.GetPositionY(), itr.GetPositionZ()));

                    init.SetWalk(true);
                    init.Launch();

                    me->m_Events.Schedule(delay += me->GetSplineDuration(), 16, [this]()
                    {
                        me->SetFacingTo(Position::NormalizeOrientation(me->GetOrientation() + M_PI));
                        me->DespawnOrUnsummon(1 * IN_MILLISECONDS);

                        if (Player* owner = ObjectAccessor::GetPlayer(*me, summonerGUID))
                        {
                            owner->KilledMonsterCredit(NPC_WALK_WITH_VARIAN_CREDIT);

                            delay = 0;
                            owner->m_Events.Schedule(delay += 1000, 1, [owner]()
                            {
                                owner->SetPhaseMask(1, true);
                            });
                        }
                    });

                    delay = 0;
                    me->m_Events.Schedule(delay += 2000, 1, [this]()
                    {
                        Talk(SAY_INTRO);
                    });

                    me->m_Events.Schedule(delay += 5000, 2, [this]()
                    {
                        Talk(SAY_SPECIAL_1);
                    });

                    me->m_Events.Schedule(delay += 5000, 3, [this]()
                    {
                        Talk(SAY_SPECIAL_2);
                    });

                    me->m_Events.Schedule(delay += 7000, 4, [this]()
                    {
                        Talk(SAY_SPECIAL_3);
                    });

                    me->m_Events.Schedule(delay += 9000, 5, [this]()
                    {
                        Talk(SAY_SPECIAL_4);
                    });

                    me->m_Events.Schedule(delay += 6500, 6, [this]()
                    {
                        Talk(SAY_SPECIAL_5);
                    });

                    me->m_Events.Schedule(delay += 10000, 7, [this]()
                    {
                        Talk(SAY_SPECIAL_6);
                    });

                    me->m_Events.Schedule(delay += 9000, 8, [this]()
                    {
                        Talk(SAY_SPECIAL_7);
                    });

                    me->m_Events.Schedule(delay += 6000, 9, [this]()
                    {
                        Talk(SAY_SPECIAL_8);
                    });

                    me->m_Events.Schedule(delay += 6000, 10, [this]()
                    {
                        Talk(SAY_SPECIAL_9);
                    });

                    me->m_Events.Schedule(delay += 5000, 11, [this]()
                    {
                        Talk(SAY_SPECIAL_10);
                    });

                    me->m_Events.Schedule(delay += 7000, 12, [this]()
                    {
                        Talk(SAY_SPECIAL_11);
                    });

                    me->m_Events.Schedule(delay += 9000, 13, [this]()
                    {
                        Talk(SAY_SPECIAL_12);
                    });

                    me->m_Events.Schedule(delay += 13000, 14, [this]()
                    {
                        Talk(SAY_SPECIAL_13);
                    });
                });
            }

            void DoAction(int32 actionId) override
            {
                if (actionId == ACTION_AN_OLD_PIT_FIGHTER)
                {
                    delay = 0;
                    me->m_Events.Schedule(delay += 1500, 18, [this]()
                    {
                        Talk(SAY_SPECIAL_14);
                    });

                    me->m_Events.Schedule(delay += 11000, 20, [this]()
                    {
                        me->setFaction(16);
                        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PACIFIED);
                        Talk(SAY_SPECIAL_15);
                    });

                    me->m_Events.Schedule(delay += 9300, 21, [this]()
                    {
                        Talk(SAY_SPECIAL_16);
                    });

                    me->m_Events.Schedule(delay += 6000, 22, [this]()
                    {
                        Talk(SAY_SPECIAL_17);
                    });

                    me->m_Events.Schedule(delay += 12000, 23, [this]()
                    {
                        Talk(SAY_SPECIAL_18);
                    });

                    me->m_Events.Schedule(delay += 2900, 24, [this]()
                    {
                        if (Player* owner = ObjectAccessor::GetPlayer(*me, summonerGUID))
                        {
                            owner->KilledMonsterCredit(NPC_FIGHT_WITH_VARIAN_CREDIT);
                            owner->CombatStop();
                        }

                        me->CombatStop();
                        me->setFaction(35);
                    });

                    me->m_Events.Schedule(delay += 3500, 25, [this]()
                    {
                        Talk(SAY_SPECIAL_19);
                    });

                    me->m_Events.Schedule(delay += 4000, 26, [this]()
                    {
                        Movement::MoveSplineInit init(me);
                        for (auto itr : VarianHomePath)
                            init.Path().push_back(G3D::Vector3(itr.GetPositionX(), itr.GetPositionY(), itr.GetPositionZ()));

                        init.SetUncompressed();
                        init.Launch();

                        delay = 0;
                        me->m_Events.Schedule(delay += me->GetSplineDuration(), 27, [this]()
                        {
                            if (Player* owner = ObjectAccessor::GetPlayer(*me, summonerGUID))
                                owner->SetPhaseMask(1, true);

                            me->DespawnOrUnsummon();
                        });
                    });
                }
            }

            void DamageTaken(Unit* who, uint32& damage) override
            {
                damage = 0;
                me->HandleEmoteCommand(EMOTE_ONESHOT_DODGE);
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_varian_wrynn_alliance_way_questAI(creature);
        }
};

// ===== npc_brother_paxton
struct npc_brother_paxton : public ScriptedAI
{
    npc_brother_paxton(Creature *c) : ScriptedAI(c) { }

    EventMap _events;

    uint32 _cooldownTimer;

    bool _cooldown;

    void Reset() override
    {
        _events.Reset();

        me->SetFlag(UNIT_FIELD_FLAGS, UnitFlags::UNIT_FLAG_IMMUNE_TO_PC | UnitFlags::UNIT_FLAG_IMMUNE_TO_NPC);
        DoCast(me, ElwynnForest::SPELL_FORTITUDE);
        me->InitializeReactState();

        _cooldown = false;
        _cooldownTimer = 0;
    }

    void EnterEvadeMode() override
    {
        return;
    }

    void MoveInLineOfSight(Unit* p_Who) override
    {
        if (me->GetDistance(p_Who) < 15.0f)
        {
            if (p_Who && p_Who->GetTypeId() == TypeID::TYPEID_PLAYER && !p_Who->HasAura(ElwynnForest::SPELL_FORTITUDE) && !_cooldown)
            {
               if (roll_chance_i(30))
               {
                    _cooldown = true;
                    me->CastSpell(p_Who, ElwynnForest::SPELL_FORTITUDE);
                    me->CastSpell(p_Who, ElwynnForest::SPELL_RENEW, true);
                    Talk(ElwynnForest::BROTHER_PAXTON_TEXT_PLAYER, p_Who);
                }
            }
        }
    }

    void EnterCombat(Unit* /*p_Who*/) override
    {
        return;
    }

    void MovementInform(uint32 p_Type, uint32 p_ID) override
    {
        if (p_Type == 2 && p_ID == 5 || p_ID == 14 || p_ID == 22 || p_ID == 33 || p_ID == 40 || p_ID == 51 || p_ID == 60 || p_ID == 62)
        {
            switch(urand(ElwynnForest::BROTHER_PAXTON_HEAL_EVENT_01, ElwynnForest::BROTHER_PAXTON_HEAL_EVENT_04))
            {
                case ElwynnForest::BROTHER_PAXTON_HEAL_EVENT_01:
                    _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_01_STEP_01, 500);
                    break;
                case ElwynnForest::BROTHER_PAXTON_HEAL_EVENT_02:
                    _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_02_STEP_01, 500);
                    break;
                case ElwynnForest::BROTHER_PAXTON_HEAL_EVENT_03:
                    _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_03_STEP_01, 500);
                    break;
                case ElwynnForest::BROTHER_PAXTON_HEAL_EVENT_04:
                    _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_04_STEP_01, 500);
                    break;
            }
        }
    }

    void UpdateAI(const uint32 diff) override
    {
        if (_cooldownTimer <= diff)
        {
            _cooldown = false;
            _cooldownTimer = 20 * TimeConstants::IN_MILLISECONDS;
        }
        else _cooldownTimer -= diff;

        _events.Update(diff);

        switch (_events.ExecuteEvent())
        {
            case ElwynnForest::HEAL_EVENT_01_STEP_01:
                me->SetReactState(ReactStates::REACT_PASSIVE);

                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    stormwind_infantry->AI()->Talk(ElwynnForest::INFANTRY_HELP_YELL);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_01_STEP_02, 1s);
                break;
            case ElwynnForest::HEAL_EVENT_01_STEP_02:
                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    me->SetFacingTo(me->GetAngle(stormwind_infantry));
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_01_STEP_03, 2s);
                break;
            case ElwynnForest::HEAL_EVENT_01_STEP_03:
                Talk(ElwynnForest::BROTHER_PAXTON_TEXT);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_01_STEP_04, 1s);
                break;
            case ElwynnForest::HEAL_EVENT_01_STEP_04:
                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    me->CastSpell(stormwind_infantry, ElwynnForest::SPELL_PENANCE);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_RESET, 4s);
                break;
            case ElwynnForest::HEAL_EVENT_02_STEP_01:
                me->SetReactState(ReactStates::REACT_PASSIVE);

                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    stormwind_infantry->AI()->Talk(ElwynnForest::INFANTRY_HELP_YELL);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_02_STEP_02, 1s);
                break;
            case HEAL_EVENT_02_STEP_02:
                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    me->SetFacingTo(me->GetAngle(stormwind_infantry));
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_02_STEP_03, 2s);
                break;
            case ElwynnForest::HEAL_EVENT_02_STEP_03:
                Talk(ElwynnForest::BROTHER_PAXTON_TEXT);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_02_STEP_04, 1s);
                break;
            case ElwynnForest::HEAL_EVENT_02_STEP_04:
                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    me->CastSpell(stormwind_infantry, ElwynnForest::SPELL_FLASH_HEAL);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_RESET, 4s);
                break;
            case ElwynnForest::HEAL_EVENT_03_STEP_01:
                me->SetReactState(ReactStates::REACT_PASSIVE);

                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    stormwind_infantry->AI()->Talk(ElwynnForest::INFANTRY_HELP_YELL);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_03_STEP_02, 1s);
                break;
            case ElwynnForest::HEAL_EVENT_03_STEP_02:
                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    me->SetFacingTo(me->GetAngle(stormwind_infantry));
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_03_STEP_03, 2s);
                break;
            case ElwynnForest::HEAL_EVENT_03_STEP_03:
                Talk(ElwynnForest::BROTHER_PAXTON_TEXT);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_03_STEP_04, 1s);
                break;
            case ElwynnForest::HEAL_EVENT_03_STEP_04:
                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    me->CastSpell(stormwind_infantry, ElwynnForest::SPELL_RENEW);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_RESET, 4s);
                break;
            case ElwynnForest::HEAL_EVENT_04_STEP_01:
                me->SetReactState(ReactStates::REACT_PASSIVE);

                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    stormwind_infantry->AI()->Talk(ElwynnForest::INFANTRY_HELP_YELL);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_04_STEP_02, 1s);
                break;
            case ElwynnForest::HEAL_EVENT_04_STEP_02:
                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    me->SetFacingTo(me->GetAngle(stormwind_infantry));
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_04_STEP_03, 2s);
                break;
            case ElwynnForest::HEAL_EVENT_04_STEP_03:
                Talk(ElwynnForest::BROTHER_PAXTON_TEXT);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_04_STEP_04, 1s);
                break;
            case ElwynnForest::HEAL_EVENT_04_STEP_04:
                if (Creature* stormwind_infantry = me->FindNearestCreature(ElwynnForest::NPC_STORMWIND_INFANTRY, 6.0f))
                    me->CastSpell(stormwind_infantry, ElwynnForest::SPELL_REVIVE);
                _events.ScheduleEvent(ElwynnForest::HEAL_EVENT_RESET, 4s);
                break;
            case ElwynnForest::HEAL_EVENT_RESET:
                me->ClearInCombat();
                Reset();
                break;
            default:
                break;
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};
} // namespace elwynn

namespace stranglethorn
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/EasternKingdoms/zone_stranglethorn_vale.cpp
enum priestessTypes
{
    QUEST_SEE_RAPTOR_A = 26773,
    QUEST_SEE_RAPTOR_H = 26359,
    NPC_CAPTURED_LASHTAIL_HATCHLING = 42840,
};

// ===== npc_stranglethorn_priestess_hurala
// Priestess Hu`rala 42812, Priestess Thaalia 44017
class npc_stranglethorn_priestess_hurala : public CreatureScript
{
    public:
        npc_stranglethorn_priestess_hurala() : CreatureScript("npc_stranglethorn_priestess_hurala") { }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            if (player->GetQuestStatus(QUEST_SEE_RAPTOR_A) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_SEE_RAPTOR_H) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM_DB(player->GetDefaultGossipMenuForSource(creature), 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            if (action == GOSSIP_ACTION_INFO_DEF + 1) // @Todo:: Event with teleport into Zul`Gurub
                player->KilledMonsterCredit(NPC_CAPTURED_LASHTAIL_HATCHLING);

            player->CLOSE_GOSSIP_MENU();
            return true;
        }
};
} // namespace stranglethorn

namespace burning_steppes
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/EasternKingdoms/zone_burning_steppes.cpp
enum ScrappedGolemsType
{
    SPELL_BATTLE_READY               = 89353, // first defeat
    SPELL_WELL_HONED                 = 89352, // second defeat
    SPELL_PERFECTLY_TUNNED           = 89355, // credit after this
    SPELL_HEAVE                      = 91314,
    SPELL_FLAME_BLAST_TRAIN          = 91313,
    EVENT_UPPERCUTE = 1,
    EVENT_FLAME_BLAST,
    QUEST_GOLEM_TRAINING             = 28227,
    ACTION_GOLEM_TRAINING = 0,
    TALK_DEFEAT_1 = 0,
    TALK_OVERRIDE,
    TALK_DEFEAT_2,
    TALK_TRAINING_SUCCESS,
};

// ===== npc_burning_steppes_chiseled_golem
// Chiseled Golem 48037
class npc_burning_steppes_chiseled_golem : public CreatureScript
{
    public:
        npc_burning_steppes_chiseled_golem() : CreatureScript("npc_burning_steppes_chiseled_golem") { }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            if (action == GOSSIP_ACTION_INFO_DEF + 1)
            {
                creature->AI()->SetGUID(player->GetGUID());
                creature->AI()->DoAction(ACTION_GOLEM_TRAINING);
            }

            player->CLOSE_GOSSIP_MENU();

            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (player->GetQuestStatus(QUEST_GOLEM_TRAINING) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM_DB(player->GetDefaultGossipMenuForSource(creature), 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        struct npc_burning_steppes_chiseled_golemAI : public customCreatureAI
        {
            npc_burning_steppes_chiseled_golemAI(Creature* creature) : customCreatureAI(creature) { }

            TaskScheduler scheduler;
            uint64 targetGUID;
            bool hasDefeat;

            void Reset() override
            {
                events.Reset();
                scheduler.CancelAll();
                targetGUID = 0;
                hasDefeat = false;
                me->SetReactState(REACT_AGGRESSIVE);
                me->setFaction(1474); // default
            }

            void SetGUID(uint64 guid, int32 /*type*/) override
            {
                targetGUID = guid;
            }

            void DoAction(int32 actionId) override
            {
                if (actionId == ACTION_GOLEM_TRAINING)
                {
                    me->setFaction(16);

                    if (Player* target = ObjectAccessor::GetPlayer(*me, targetGUID))
                        AttackStart(target);
                }
            }

            void DamageTaken(Unit* attacker, uint32& damage) override
            {
                if (hasDefeat)
                    damage = 0;

                if (damage >= me->GetHealth() && !hasDefeat)
                {
                    damage = 0;
                    hasDefeat = true;

                    // select powerful depend of current
                    if (!me->HasAura(SPELL_BATTLE_READY))
                    {
                        me->PrepareChanneledCast(me->GetOrientation());
                        DoCast(me, SPELL_BATTLE_READY);
                        Talk(TALK_DEFEAT_1);

                        scheduler
                            .Schedule(Seconds(5), [this](TaskContext context)
                        {
                            me->SetFullHealth();
                            Talk(TALK_OVERRIDE);
                            hasDefeat = false;

                            if (Player* target = ObjectAccessor::GetPlayer(*me, targetGUID))
                                me->RemoveChanneledCast(target->GetGUID());

                            events.ScheduleEvent(EVENT_FLAME_BLAST, 2 * IN_MILLISECONDS);
                        });
                    }
                    else if (!me->HasAura(SPELL_WELL_HONED))
                    {
                        me->PrepareChanneledCast(me->GetOrientation());
                        DoCast(me, SPELL_WELL_HONED);
                        Talk(TALK_DEFEAT_2);

                        scheduler
                            .Schedule(Seconds(5), [this](TaskContext context)
                        {
                            me->SetFullHealth();
                            Talk(TALK_OVERRIDE);
                            hasDefeat = false;

                            if (Player* target = ObjectAccessor::GetPlayer(*me, targetGUID))
                                me->RemoveChanneledCast(target->GetGUID());

                            events.ScheduleEvent(EVENT_UPPERCUTE, 2 * IN_MILLISECONDS);
                        });
                    }
                    else // training success
                    {
                        Talk(TALK_TRAINING_SUCCESS);
                        DoCast(me, SPELL_PERFECTLY_TUNNED);
                        me->PrepareChanneledCast(me->GetOrientation());

                        if (Player* target = ObjectAccessor::GetPlayer(*me, targetGUID))
                            target->KilledMonsterCredit(me->GetEntry());

                        me->DespawnOrUnsummon(4 * IN_MILLISECONDS);
                    }
                }
            }

            void EnterCombat(Unit* /*who*/) override { }

            void UpdateAI(uint32 diff) override
            {
                scheduler.Update(diff);

                if (!UpdateVictim())
                    return;

                events.Update(diff);

                if (me->HasUnitState(UNIT_STATE_CASTING))
                    return;

                while (uint32 eventId = events.ExecuteEvent())
                {
                    ExecuteTargetEvent(SPELL_HEAVE, 10500, EVENT_UPPERCUTE, eventId);
                    ExecuteTargetEvent(SPELL_FLAME_BLAST_TRAIN, urand(12 * IN_MILLISECONDS, 15 * IN_MILLISECONDS), EVENT_FLAME_BLAST, eventId, PRIORITY_CHANNELED);
                    break;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_burning_steppes_chiseled_golemAI(creature);
        }
};
} // namespace burning_steppes

namespace eastern_plaguelands
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/EasternKingdoms/zone_eastern_plaguelands.cpp
enum
{
    TALK_DIED                  = 0,
    TALK_CREDIT_1              = 1,
    TALK_CREDIT_2              = 2,
    EVENT_THROW_DYNAMITE       = 1,
    SPELL_THROW_DYNAMITE       = 86088,
    QUEST_BEAT_IT_OUT_OF_THEM  = 27522,
    OBJECTIVE_ENGINEERS        = 265859,
    OBJECTIVE_GIDVINS_LOCATION = 265860,
    OBJECTIVE_GIDVINS_CAPTOR   = 265861,
    NPC_CREDIT_1               = 45845,
    NPC_CREDIT_2               = 45846,
};

// ===== npc_scourge_siege_engineer
// Scourge Siege Engineer - 17878
struct npc_scourge_siege_engineer : public ScriptedAI
{
    npc_scourge_siege_engineer(Creature* creature) : ScriptedAI(creature) { }

    EventMap events;

    void Reset() override
    {
        events.Reset();
    }

    void EnterCombat(Unit* /*who*/) override
    {
        events.ScheduleEvent(EVENT_THROW_DYNAMITE, 10000);
    }

    void JustDied(Unit* killer) override
    {
        if (Player* player = killer->ToPlayer())
        {
            if (player->GetQuestStatus(QUEST_BEAT_IT_OUT_OF_THEM) == QUEST_STATUS_INCOMPLETE)
            {
                if (player->GetQuestObjectiveCounter(OBJECTIVE_ENGINEERS) == 3 && !player->GetQuestObjectiveCounter(OBJECTIVE_GIDVINS_LOCATION))
                {
                    Talk(TALK_CREDIT_1, player);
                    player->KilledMonsterCredit(NPC_CREDIT_1);
                }
                else if (player->GetQuestObjectiveCounter(OBJECTIVE_ENGINEERS) == 6 && !player->GetQuestObjectiveCounter(OBJECTIVE_GIDVINS_CAPTOR))
                {
                    Talk(TALK_CREDIT_2, player);
                    player->KilledMonsterCredit(NPC_CREDIT_2);
                }
                else
                    Talk(TALK_DIED, player);
            }
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_THROW_DYNAMITE:
                    DoCastVictim(SPELL_THROW_DYNAMITE);
                    events.ScheduleEvent(EVENT_THROW_DYNAMITE, urand(5000, 7000));
                    break;
                default:
                    break;
            }
        }

        DoMeleeAttackIfReady();
    }
};
} // namespace eastern_plaguelands

namespace western_plaguelands
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/EasternKingdoms/zone_western_plaguelands.cpp
enum eQuests
{
    QUEST_SCHOLOMANCER = 27162,
};
enum eSpells
{
    SPELL_SHADOWBOLT      = 79932,
    SPELL_SHADOW_ERUPTION = 79932,
    SPELL_SHADOW_PRISON   = 86780,
};
enum eEvents
{
    EVENT_SHADOW_BOLT = 1,
    EVENT_SHADOW_ERUPTION,
};
enum eTalks
{
    SAY_INTRO,
    SAY_SPECIAL_1,
    SAY_SPECIAL_2,
};

// ===== npc_dark_master_gandling_quest
// Dark Master Gandling 44323
struct npc_dark_master_gandling_quest : public ScriptedAI
{
    npc_dark_master_gandling_quest(Creature* creature) : ScriptedAI(creature) { }

    EventMap events;
    bool eventDone;

    void Reset() override
    {
        SetCombatMovement(false);
        events.Reset();
        eventDone = false;
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_PACIFIED);
    }

    void EnterCombat(Unit* who) override
    {
        Talk(SAY_INTRO);
        events.ScheduleEvent(EVENT_SHADOW_BOLT, urand(1500, 3000));
        events.ScheduleEvent(EVENT_SHADOW_ERUPTION, 12 * IN_MILLISECONDS);
    }

    void DamageTaken(Unit* attacker, uint32& damage) override
    {
        if (eventDone)
            damage = 0;

        if (me->GetHealth() <= damage && !eventDone)
        {
            damage = 0;
            eventDone = true;
            Talk(SAY_SPECIAL_1);
            me->InterruptNonMeleeSpells(true);
            events.Reset();
            me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IMMUNE_TO_NPC | UNIT_FLAG_IMMUNE_TO_PC | UNIT_FLAG_PACIFIED);
            DoCast(attacker, SPELL_SHADOW_PRISON);

            me->m_Events.Schedule(16000, [this]()
            {
                Talk(SAY_SPECIAL_2);
                HandleCompleteQuest();
                me->CombatStop();
                me->DespawnOrUnsummon(5 * IN_MILLISECONDS);
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        events.Update(diff);

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_SHADOW_BOLT:
                    if (Unit* target = me->GetVictim())
                        DoCast(target, SPELL_SHADOWBOLT);

                    events.ScheduleEvent(EVENT_SHADOW_BOLT, urand(3100, 3500));
                    break;
                case EVENT_SHADOW_ERUPTION:
                    if (Unit* target = me->GetVictim())
                        DoCast(target, SPELL_SHADOW_ERUPTION);

                    events.ScheduleEvent(EVENT_SHADOW_ERUPTION, 14 * IN_MILLISECONDS);
                    break;
            }
        }
    }

    private:
        // Spell not found
        void HandleCompleteQuest()
        {
            std::list<Player*> pList;
            GetPlayerListInGrid(pList, me, 100.0f);
            pList.remove_if([=](Player* target) { return target && target->GetQuestStatus(QUEST_SCHOLOMANCER) != QUEST_STATUS_INCOMPLETE; });

            for (auto&& itr : pList)
                itr->KilledMonsterCredit(me->GetEntry());
        }
};

// ===== npc_thassarian_quest
// Thassarian 44453
class npc_thassarian_quest : public CreatureScript
{
    public:
        npc_thassarian_quest() : CreatureScript("npc_thassarian_quest") { }

        bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_SCHOLOMANCER)
                creature->AI()->Talk(SAY_INTRO);

            return true;
        }

        struct npc_thassarian_questAI : public ScriptedAI
        {
            npc_thassarian_questAI(Creature* creature) : ScriptedAI(creature) { }

            void UpdateAI(uint32 /*diff*/) override { }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_thassarian_questAI(creature);
        }
};
} // namespace western_plaguelands

} // namespace

void AddSC_eastern_kingdoms_ported()
{
    new creature_script<tirisfal::npc_aradne>("npc_aradne");
    new creature_script<tirisfal::npc_deathknell_grave_target>("npc_deathknell_grave_target");
    new creature_script<tirisfal::npc_mindless_zombie>("npc_mindless_zombie");
    new creature_script<tirisfal::npc_risen_dead>("npc_risen_dead");
    new creature_script<tirisfal::npc_sedrick_calston>("npc_sedrick_calston");
    new creature_script<tirisfal::npc_undertaker_mordo>("npc_undertaker_mordo");
    new creature_script<tirisfal::npc_vile_fin_minor_oracle>("npc_vile_fin_minor_oracle");
    new creature_script<tirisfal::npc_vile_fin_puddlejumper>("npc_vile_fin_puddlejumper");
    new creature_script<gilneas::npc_koroth_the_hillbreaker>("npc_koroth_the_hillbreaker");
    new creature_script<gilneas_pan::npc_duskhaven_watchman>("npc_duskhaven_watchman");
    new gilneas_pan::npc_forsaken_catapult();
    new creature_script<gilneas_pan::npc_forsaken_invader>("npc_forsaken_invader");
    new creature_script<silverpine::npc_fenwick_thatros>("npc_fenwick_thatros");
    new elwynn::npc_varian_wrynn_alliance_way_quest();
    new creature_script<elwynn::npc_brother_paxton>("npc_brother_paxton");
    new stranglethorn::npc_stranglethorn_priestess_hurala();
    new burning_steppes::npc_burning_steppes_chiseled_golem();
    new creature_script<eastern_plaguelands::npc_scourge_siege_engineer>("npc_scourge_siege_engineer");
    new creature_script<western_plaguelands::npc_dark_master_gandling_quest>("npc_dark_master_gandling_quest");
    new western_plaguelands::npc_thassarian_quest();
}
