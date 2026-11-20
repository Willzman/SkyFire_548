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

/*
 * Ported to Project SkyFire from Legends-of-Azeroth-Pandaria-5.4.8
 * (Legends-of-Azeroth-Pandaria-5.4.8 src/server/scripts/Kalimdor/LostCityOfTheTolvir/lost_city_of_the_tolvir.h, GPL v2 or later).
 * Mechanical API changes by skyfire_port_plan/tools/loa2sf.ps1, the rest by hand.
 */

#ifndef DEF_LOST_CITY_OF_THE_TOLVIR_H
#define DEF_LOST_CITY_OF_THE_TOLVIR_H

#include "ScriptMgr.h"
#include "../../Pandaria/pandaria_loa_compat.h"
#include "ScriptedCreature.h"
#include "InstanceScript.h"
#include "ObjectMgr.h"

enum Data
{
    DATA_GENERAL_HUSAM          = 0,
    DATA_LOCKMAW                = 1,
    DATA_AUGH                   = 2,
    DATA_HIGH_PROPHET_BARIM     = 3,
    DATA_SIAMAT                 = 4,
    DATA_HARBINGER              = 5,
    DATA_BLAZE                  = 6,
};

enum Creatures
{
    // Dungeon Bosses
    BOSS_GENERAL_HUSAM           = 44577,
    BOSS_LOCKMAW                 = 43614,
    BOSS_AUGH                    = 49045,
    BOSS_HIGH_PROPHET_BARIM      = 43612,
    BOSS_SIAMAT                  = 44819,
    // Various NPCs
    NPC_WIND_TUNNEL              = 48092,
};

enum GameObjects
{
    SIAMAT_PLATFORM              = 205365,
};

template<class AI>
CreatureAI* GetInstanceAI(Creature* creature)
{
    if (InstanceMap* instance = creature->GetMap()->ToInstanceMap())
        if (instance->GetInstanceScript())
            if (instance->GetScriptId() == sObjectMgr->GetScriptId("instance_lost_city_of_the_tolvir"))
                return new AI(creature);
    return NULL;
}

#endif