/*
* This file is part of the Pandaria 5.4.8 Project. See THANKS file for Copyright information
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

// Ported to SkyFire_548 from Legends-of-Azeroth-Pandaria-5.4.8
// (src/server/scripts/Pandaria/GateOfTheSettingSun/gate_of_the_setting_sun.cpp).
// Only the two trash scripts SkyFire's DB already binds are ported here
// (npc_krikthik_bombarder, vehicle_artillery_to_wall). The rest of LoA's file
// (trash AI, brasier, ropes, cannoneers, wall events) needs its own DB rows and
// is left for the P5 Gate of the Setting Sun item.

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "CombatAI.h"
#include "Vehicle.h"
#include "InstanceScript.h"
#include "Player.h"
#include "gate_of_the_setting_sun.h"

namespace
{

enum spells
{
    SPELL_BOMB_CAST_VISUAL          = 106729,
    SPELL_BOMB_AURA                 = 106875,
};

class npc_krikthik_bombarder : public CreatureScript
{
    public:
        npc_krikthik_bombarder() : CreatureScript("npc_krikthik_bombarder") { }

        struct npc_krikthik_bombarderAI : public ScriptedAI
        {
            npc_krikthik_bombarderAI(Creature* creature) : ScriptedAI(creature)
            {
                pInstance = creature->GetInstanceScript();
            }

            void Reset() override
            {
                me->GetMotionMaster()->MoveRandom(5.0f);
                bombTimer = urand(1000, 7500);
            }

            // Called when spell hits a target
            void SpellHitTarget(Unit* target, SpellInfo const* /*spell*/) override
            {
                if (target->GetEntry() == NPC_BOMB_STALKER)
                    me->AddAura(SPELL_BOMB_AURA, target);
            }

            void UpdateAI(uint32 diff) override
            {
                if (!pInstance)
                    return;

                if (bombTimer <= diff)
                {
                    if (Unit* stalker = pInstance->instance->GetCreature(pInstance->GetData64(DATA_RANDOM_BOMB_STALKER)))
                        if (!stalker->HasAura(SPELL_BOMB_AURA))
                            me->CastSpell(stalker, SPELL_BOMB_CAST_VISUAL, true);

                    bombTimer = urand(1000, 5000);
                }
                else bombTimer -= diff;
            }

        private:
            InstanceScript* pInstance;
            uint32 bombTimer;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_krikthik_bombarderAI(creature);
        }
};

class vehicle_artillery_to_wall : public CreatureScript
{
    public:
        vehicle_artillery_to_wall() : CreatureScript("vehicle_artillery_to_wall") { }

        enum eSpells
        {
            SPELL_JUMP_TO_WALL = 131497
        };

        enum eEvents
        {
            EVENT_JUMP_TO_WALL = 1
        };

        struct vehicle_artillery_to_wallAI : public VehicleAI
        {
            vehicle_artillery_to_wallAI(Creature* creature) : VehicleAI(creature) { }

            void PassengerBoarded(Unit* /*who*/, int8 /*seatId*/, bool apply) override
            {
                if (apply)
                    events.ScheduleEvent(EVENT_JUMP_TO_WALL, 1 * IN_MILLISECONDS);
            }

            void UpdateAI(uint32 diff) override
            {
                events.Update(diff);

                while (uint32 eventId = events.ExecuteEvent())
                {
                    if (eventId == EVENT_JUMP_TO_WALL)
                    {
                        if (Vehicle* vehicle = me->GetVehicleKit())
                            if (Unit* passenger = vehicle->GetPassenger(0))
                                if (Player* player = passenger->ToPlayer())
                                {
                                    player->ExitVehicle();
                                    player->CastSpell(player, SPELL_JUMP_TO_WALL, false);
                                }
                    }
                    break;
                }
            }

        private:
            EventMap events;
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new vehicle_artillery_to_wallAI(creature);
        }
};

} // namespace

void AddSC_gate_of_the_setting_sun()
{
    new npc_krikthik_bombarder();
    new vehicle_artillery_to_wall();
}
