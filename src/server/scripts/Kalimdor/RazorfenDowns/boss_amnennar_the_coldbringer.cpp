/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

/*
 * Ported from TrinityCore cata_classic boss_amnennar_the_coldbringer.cpp (GPL v2 or later),
 * replacing SkyFire's timer version: adds the instance boss state, the 75% line, the
 * summon emote and the Banish Frost Spectres cast on evade and death.
 * Timers requires update
 */

#include "ScriptMgr.h"
#include "razorfen_downs.h"
#include "ScriptedCreature.h"

namespace
{

enum AmnennarTexts
{
    SAY_AGGRO                      = 0,
    SAY_SLAY                       = 1,
    SAY_HEALTH_75                  = 2,
    SAY_SUMMON_60                  = 3,
    SAY_SUMMON_30                  = 4,
    EMOTE_SUMMON                   = 5
};

enum AmnennarSpells
{
    SPELL_AMNENNARS_WRATH          = 13009,
    SPELL_FROSTBOLT                = 15530,
    SPELL_FROST_NOVA               = 15531,
    SPELL_SUMMON_FROST_SPECTRES    = 12642,
    SPELL_BANISH_FROST_SPECTRES    = 12660
};

enum AmnennarEvents
{
    EVENT_AMNENNARS_WRATH          = 1,
    EVENT_FROSTBOLT,
    EVENT_FROST_NOVA,

    EVENT_HEALTH_75,
    EVENT_HEALTH_60,
    EVENT_HEALTH_30
};

enum AmnennarPhases : uint8
{
    PHASE_NONE                     = 0,
    PHASE_HEALTH_75,
    PHASE_HEALTH_60,
    PHASE_HEALTH_30
};

// 7358 - Amnennar the Coldbringer
struct boss_amnennar_the_coldbringer : public BossAI
{
    boss_amnennar_the_coldbringer(Creature* creature) : BossAI(creature, DATA_AMNENNAR_THE_COLD_BRINGER), _phase(PHASE_NONE) { }

    void Reset() override
    {
        _Reset();
        _phase = PHASE_NONE;
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        events.ScheduleEvent(EVENT_AMNENNARS_WRATH, 8 * IN_MILLISECONDS);
        events.ScheduleEvent(EVENT_FROSTBOLT, 0);
        events.ScheduleEvent(EVENT_FROST_NOVA, urand(10, 15) * IN_MILLISECONDS);
        Talk(SAY_AGGRO);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage) override
    {
        if (_phase < PHASE_HEALTH_75 && me->HealthBelowPctDamaged(75, damage))
        {
            _phase++;
            events.ScheduleEvent(EVENT_HEALTH_75, 0);
        }

        if (_phase < PHASE_HEALTH_60 && me->HealthBelowPctDamaged(60, damage))
        {
            _phase++;
            events.ScheduleEvent(EVENT_HEALTH_60, 0);
        }

        if (_phase < PHASE_HEALTH_30 && me->HealthBelowPctDamaged(30, damage))
        {
            _phase++;
            events.ScheduleEvent(EVENT_HEALTH_30, 0);
        }
    }

    void KilledUnit(Unit* who) override
    {
        if (who->GetTypeId() == TypeID::TYPEID_PLAYER)
            Talk(SAY_SLAY);
    }

    // Despawn is handled by spell, don't store anything
    void JustSummoned(Creature* /*summon*/) override { }

    void EnterEvadeMode() override
    {
        DoCastSelf(SPELL_BANISH_FROST_SPECTRES, true);
        BossAI::EnterEvadeMode();
    }

    void JustDied(Unit* /*killer*/) override
    {
        _JustDied();
        DoCastSelf(SPELL_BANISH_FROST_SPECTRES, true);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        events.Update(diff);

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_AMNENNARS_WRATH:
                    DoCastVictim(SPELL_AMNENNARS_WRATH);
                    events.ScheduleEvent(EVENT_AMNENNARS_WRATH, 12 * IN_MILLISECONDS);
                    break;
                case EVENT_FROSTBOLT:
                    DoCastVictim(SPELL_FROSTBOLT);
                    events.ScheduleEvent(EVENT_FROSTBOLT, 8 * IN_MILLISECONDS);
                    break;
                case EVENT_FROST_NOVA:
                    DoCastSelf(SPELL_FROST_NOVA);
                    events.ScheduleEvent(EVENT_FROST_NOVA, 15 * IN_MILLISECONDS);
                    break;

                case EVENT_HEALTH_75:
                    Talk(SAY_HEALTH_75);
                    break;
                case EVENT_HEALTH_60:
                    Talk(EMOTE_SUMMON);
                    Talk(SAY_SUMMON_60);
                    DoCastSelf(SPELL_SUMMON_FROST_SPECTRES);
                    break;
                case EVENT_HEALTH_30:
                    Talk(EMOTE_SUMMON);
                    Talk(SAY_SUMMON_30);
                    DoCastSelf(SPELL_SUMMON_FROST_SPECTRES);
                    break;
                default:
                    break;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
        }

        DoMeleeAttackIfReady();
    }

private:
    uint8 _phase;
};

} // namespace

void AddSC_boss_amnennar_the_coldbringer()
{
    RegisterRazorfenDownsCreatureAI(boss_amnennar_the_coldbringer);
}
