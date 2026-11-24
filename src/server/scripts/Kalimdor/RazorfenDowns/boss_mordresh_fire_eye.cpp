/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

/*
 * Ported from TrinityCore cata_classic boss_mordresh_fire_eye.cpp (GPL v2 or later).
 * Timers requires update
 */

#include "ScriptMgr.h"
#include "razorfen_downs.h"
#include "ScriptedCreature.h"

namespace
{

enum MordreshTexts
{
    SAY_OOC_1               = 0,
    SAY_OOC_2               = 1,
    SAY_OOC_3               = 2,
    SAY_AGGRO               = 3
};

enum MordreshSpells
{
    SPELL_FIREBALL          = 12466,
    SPELL_FIRE_NOVA         = 12470
};

enum MordreshEvents
{
    EVENT_OOC_1            = 1,
    EVENT_OOC_2,
    EVENT_OOC_3,
    EVENT_OOC_4,

    EVENT_FIREBALL,
    EVENT_FIRE_NOVA
};

// 7357 - Mordresh Fire Eye
struct boss_mordresh_fire_eye : public BossAI
{
    boss_mordresh_fire_eye(Creature* creature) : BossAI(creature, DATA_MORDRESH_FIRE_EYE) { }

    void Reset() override
    {
        _Reset();
        events.ScheduleEvent(EVENT_OOC_1, 10 * IN_MILLISECONDS);
    }

    void EnterCombat(Unit* /*who*/) override
    {
        _EnterCombat();
        events.Reset();
        Talk(SAY_AGGRO);
        events.ScheduleEvent(EVENT_FIREBALL, 0);
        events.ScheduleEvent(EVENT_FIRE_NOVA, urand(8, 12) * IN_MILLISECONDS);
    }

    void UpdateAI(uint32 diff) override
    {
        events.Update(diff);

        if (!UpdateVictim())
        {
            while (uint32 eventId = events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_OOC_1:
                        Talk(SAY_OOC_1);
                        events.ScheduleEvent(EVENT_OOC_2, 8 * IN_MILLISECONDS);
                        break;
                    case EVENT_OOC_2:
                        Talk(SAY_OOC_2);
                        events.ScheduleEvent(EVENT_OOC_3, 3 * IN_MILLISECONDS);
                        break;
                    case EVENT_OOC_3:
                        me->HandleEmoteCommand(EMOTE_ONESHOT_EXCLAMATION);
                        events.ScheduleEvent(EVENT_OOC_4, 6 * IN_MILLISECONDS);
                        break;
                    case EVENT_OOC_4:
                        Talk(SAY_OOC_3);
                        events.ScheduleEvent(EVENT_OOC_1, 14 * IN_MILLISECONDS);
                        break;
                }
            }
            return;
        }

        if (me->HasUnitState(UNIT_STATE_CASTING))
            return;

        while (uint32 eventId = events.ExecuteEvent())
        {
            switch (eventId)
            {
                case EVENT_FIREBALL:
                    DoCastVictim(SPELL_FIREBALL);
                    events.ScheduleEvent(EVENT_FIREBALL, urand(2400, 3800));
                    break;
                case EVENT_FIRE_NOVA:
                    DoCastSelf(SPELL_FIRE_NOVA);
                    events.ScheduleEvent(EVENT_FIRE_NOVA, urand(11, 16) * IN_MILLISECONDS);
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

void AddSC_boss_mordresh_fire_eye()
{
    RegisterRazorfenDownsCreatureAI(boss_mordresh_fire_eye);
}
