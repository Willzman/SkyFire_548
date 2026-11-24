/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

/*
 * Ported from TrinityCore cata_classic boss_tuten_kash.cpp (GPL v2 or later).
 * Timers requires update
 */

#include "ScriptMgr.h"
#include "razorfen_downs.h"
#include "ScriptedCreature.h"

namespace
{

enum TutenkashSpells
{
    SPELL_VIRULENT_POISON        = 12254,
    SPELL_THRASH                 = 8876,
    SPELL_WEB_SPRAY              = 12252,
    SPELL_CURSE_OF_TUTENKASH     = 12255
};

enum TutenkashEvents
{
    EVENT_WEB_SPRAY              = 1,
    EVENT_CURSE_OF_TUTENKASH
};

// 7355 - Tuten'kash
struct boss_tuten_kash : public BossAI
{
    boss_tuten_kash(Creature* creature) : BossAI(creature, DATA_TUTEN_KASH) { }

    void Reset() override
    {
        _Reset();
        DoCastSelf(SPELL_VIRULENT_POISON);
        DoCastSelf(SPELL_THRASH);
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        events.ScheduleEvent(EVENT_WEB_SPRAY, urand(10, 20) * IN_MILLISECONDS);
        events.ScheduleEvent(EVENT_CURSE_OF_TUTENKASH, urand(10, 15) * IN_MILLISECONDS);
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
                case EVENT_WEB_SPRAY:
                    DoCastSelf(SPELL_WEB_SPRAY);
                    events.ScheduleEvent(EVENT_WEB_SPRAY, urand(15, 25) * IN_MILLISECONDS);
                    break;
                case EVENT_CURSE_OF_TUTENKASH:
                    DoCastSelf(SPELL_CURSE_OF_TUTENKASH);
                    events.ScheduleEvent(EVENT_CURSE_OF_TUTENKASH, urand(15, 25) * IN_MILLISECONDS);
                    break;
                default:
                    break;
            }

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;
        }

        DoMeleeAttackIfReady();
    }
};

} // namespace

void AddSC_boss_tuten_kash()
{
    RegisterRazorfenDownsCreatureAI(boss_tuten_kash);
}
