/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

/*
 * Ported from TrinityCore cata_classic boss_glutton.cpp (GPL v2 or later).
 */

#include "ScriptMgr.h"
#include "razorfen_downs.h"
#include "ScriptedCreature.h"

namespace
{

enum GluttonTexts
{
    SAY_AGGRO               = 0,
    SAY_SLAY                = 1,
    SAY_HEALTH_50           = 2,
    SAY_HEALTH_15           = 3
};

enum GluttonSpells
{
    SPELL_THRASH_15         = 8876,
    SPELL_DISEASE_CLOUD     = 12627,
    SPELL_THRASH_35         = 12787,
    SPELL_FRENZY            = 12795
};

enum GluttonEvents
{
    EVENT_HEALTH_50         = 1,
    EVENT_HEALTH_15
};

enum GluttonPhases : uint8
{
    PHASE_NONE              = 0,
    PHASE_HEALTH_50,
    PHASE_HEALTH_15
};

// 8567 - Glutton
struct boss_glutton : public BossAI
{
    boss_glutton(Creature* creature) : BossAI(creature, DATA_GLUTTON), _phase(PHASE_NONE) { }

    void Reset() override
    {
        _Reset();
        _phase = PHASE_NONE;
        DoCastSelf(SPELL_THRASH_15);
        DoCastSelf(SPELL_DISEASE_CLOUD);
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        Talk(SAY_AGGRO);
    }

    void DamageTaken(Unit* /*attacker*/, uint32& damage) override
    {
        if (_phase < PHASE_HEALTH_50 && me->HealthBelowPctDamaged(50, damage))
        {
            _phase++;
            events.ScheduleEvent(EVENT_HEALTH_50, 0);
        }

        if (_phase < PHASE_HEALTH_15 && me->HealthBelowPctDamaged(15, damage))
        {
            _phase++;
            events.ScheduleEvent(EVENT_HEALTH_15, 0);
        }
    }

    void KilledUnit(Unit* /*victim*/) override
    {
        Talk(SAY_SLAY);
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
                case EVENT_HEALTH_50:
                    Talk(SAY_HEALTH_50);
                    me->RemoveAurasDueToSpell(SPELL_THRASH_15);
                    DoCastSelf(SPELL_THRASH_35);
                    break;
                case EVENT_HEALTH_15:
                    Talk(SAY_HEALTH_15);
                    DoCastSelf(SPELL_FRENZY);
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

void AddSC_boss_glutton()
{
    RegisterRazorfenDownsCreatureAI(boss_glutton);
}
