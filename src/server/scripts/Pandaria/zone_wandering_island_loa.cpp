/*
* This file is part of the Legends of Azeroth Pandaria Project. See THANKS file for Copyright information
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
 * (src/server/scripts/Pandaria/WanderingIsland/zone_wandering_island_{north,east,south}.cpp, GPL v2 or later).
 * Mechanical API changes by skyfire_port_plan/tools/loa2sf.ps1, the rest by hand.
 */


/*
 * Wandering Isle scripts SkyFire's DB binds but zone_wandering_island.cpp lacks (PLAN.md P1).
 * The rest of the zone stays in zone_wandering_island.cpp, where SkyFire is ahead.
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
#include "ScriptedEscortAI.h"

namespace
{

// From LoA zone_wandering_island_north.cpp
class boss_li_fei : public CreatureScript
{
    public:
        boss_li_fei() : CreatureScript("boss_li_fei") { }

        bool OnQuestAccept(Player* /*player*/, Creature* /*creature*/, Quest const* /*quest*/) override
        {
            // TODO: there is some kick spell casted on retail at quest accept
            return true;
        }
};

// From LoA zone_wandering_island_east.cpp
class npc_nourished_yak : public CreatureScript
{
    public:
        npc_nourished_yak() : CreatureScript("npc_nourished_yak") { }

        struct npc_nourished_yakAI : public npc_escortAI
        {
            npc_nourished_yakAI(Creature* creature) : npc_escortAI(creature)
            { }

            uint32 IntroTimer;
            uint8 waypointToEject;

            void Reset() override
            {
                waypointToEject = 100;

                if (me->IsSummon())
                {
                    IntroTimer = 2500;

                    // The Singing Pools -> Dai-Lo Farmstead
                    if (me->GetAreaId() == 5826)
                        waypointToEject = 24;
                    // Dai-Lo Farmstead -> Temple
                    else if (me->GetAreaId() == 5881) // Ferme Dai-Lo
                        waypointToEject = 22;
                    // Epave -> Temple
                    else if (me->GetAreaId() == 5833) // New Allies quest Carraige
                        waypointToEject = 18;
                }
                else
                    IntroTimer = 0;
            }

            void WaypointReached(uint32 waypointId) override
            {
                if (waypointId == waypointToEject)
                {
                    if (Creature* vehicle = GetClosestCreatureWithEntry(me, 57208, 50.0f))
                        vehicle->DespawnOrUnsummon();
                    if (Creature* vehicle = GetClosestCreatureWithEntry(me, 59496, 50.0f))
                        vehicle->DespawnOrUnsummon();
                    if (Creature* vehicle = GetClosestCreatureWithEntry(me, 57740, 50.0f))
                        vehicle->DespawnOrUnsummon();
                }
            }

            void UpdateAI(uint32 diff) override
            {
                if (IntroTimer)
                {
                    if (IntroTimer <= diff)
                    {
                        SetRun(true); Start(false);
                        IntroTimer = 0;
                    }
                    else
                        IntroTimer -= diff;
                }

                npc_escortAI::UpdateAI(diff);
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_nourished_yakAI(creature);
        }
};

// From LoA zone_wandering_island_south.cpp
class npc_korga : public CreatureScript
{
    public:
        npc_korga() : CreatureScript("npc_korga") { }

        bool OnQuestAccept(Player* player, Creature* /*creature*/, Quest const* quest) override
        {
            if (quest->GetQuestId() == 30589) // Wrecking the Wreck
                if (Creature* jiEscort = player->SummonCreature(60900, 424.71f, 3635.59f, 92.70f, 2.498430f, TempSummonType::TEMPSUMMON_MANUAL_DESPAWN, 0))
                {
                    // LoA: jiEscort->SetExplicitSeerGuid(player->GetGUID()); SkyFire has no per-player visibility, so others can see this Ji
                    jiEscort->SetReactState(REACT_PASSIVE);
                    jiEscort->AI()->SetGUID(player->GetGUID());
                }

            return true;
        }
};

// From LoA zone_wandering_island_south.cpp
#define MAX_ENNEMIES_POS   2
#define MAX_HEALER_COUNT   12
#define UPDATE_POWER_TIMER 3000

Position const ennemiesPositions[MAX_ENNEMIES_POS] =
{
    {215.0f, 3951.0f, 71.4f, 0.0f},
    {290.0f, 3939.0f, 86.7f, 0.0f}
};

enum eEnums
{
    QUEST_HEALING_SHEN      = 29799,

    NPC_HEALER_A            = 60878,
    NPC_HEALER_H            = 60896,
    NPC_ENNEMY              = 60858,

    NPC_SHEN_HEAL_CREDIT    = 56011,

    EVENT_CHECK_PLAYERS     = 1,
    EVENT_UPDATE_POWER      = 2,
    EVENT_SUMMON_ENNEMY     = 3,
    EVENT_SUMMON_HEALER     = 4,

    SPELL_SHEN_HEALING      = 117783,
    SPELL_HEALER_A          = 117784,
    SPELL_HEALER_H          = 117932,
};


class npc_ji_end_event : public CreatureScript
{
    public:
        npc_ji_end_event() : CreatureScript("npc_ji_end_event") { }

        struct npc_ji_end_eventAI : public ScriptedAI
        {
            npc_ji_end_eventAI(Creature* creature) : ScriptedAI(creature), _summons(creature) { }

            EventMap   _events;
            SummonList _summons;

            bool       inProgress;
            uint8      healerCount;
            uint8      ennemiesCount;
            uint16     actualPower;

            void Reset() override
            {
                _summons.DespawnAll();

                healerCount   = 0;
                ennemiesCount = 0;
                actualPower   = 0;

                inProgress = false;

                _events.Reset();
                _events.ScheduleEvent(EVENT_CHECK_PLAYERS, 5000);
            }

            bool CheckPlayers()
            {
                std::list<Player*> playerList;
                GetPlayerListInGrid(playerList, me, 100.0f);

                for (auto player : playerList)
                    if (player->GetQuestStatus(QUEST_HEALING_SHEN) == QUEST_STATUS_INCOMPLETE)
                        if (player->IsAlive())
                            return true;

                return false;
            }

            void UpdatePower()
            {
                actualPower = (actualPower + healerCount <= 700) ? actualPower + healerCount: 700;

                std::list<Player*> playerList;
                GetPlayerListInGrid(playerList, me, 100.0f);

                for (auto player : playerList)
                {
                    if (player->GetQuestStatus(QUEST_HEALING_SHEN) == QUEST_STATUS_INCOMPLETE)
                    {
                        if (player->IsAlive())
                        {
                            if (actualPower < 700) // IN_PROGRESS
                            {
                                if (!player->HasAura(SPELL_SHEN_HEALING))
                                    player->CastSpell(player, SPELL_SHEN_HEALING, true);

                                player->SetPower(POWER_ALTERNATE_POWER, actualPower);
                            }
                            else
                            {
                                if (player->HasAura(SPELL_SHEN_HEALING))
                                    player->RemoveAurasDueToSpell(SPELL_SHEN_HEALING);

                                player->KilledMonsterCredit(NPC_SHEN_HEAL_CREDIT);
                            }
                        }
                    }
                }

                if (actualPower >= 700)
                    Reset();
            }

            void SummonEnnemy()
            {
                uint8 pos = rand() % MAX_ENNEMIES_POS;
                float posJumpX = frand(228.0f, 270.0f);
                float posJumpY = frand(3949.0f, 3962.0f);

                if (Creature* ennemy = me->SummonCreature(NPC_ENNEMY, ennemiesPositions[pos].GetPositionX(), ennemiesPositions[pos].GetPositionY(), ennemiesPositions[pos].GetPositionZ(), 0.0f, TempSummonType::TEMPSUMMON_CORPSE_DESPAWN))
                    ennemy->GetMotionMaster()->MoveJump(posJumpX, posJumpY, me->GetMap()->GetHeight(me->GetPhaseMask(), posJumpX, posJumpY, 100.0f), 20.0f, 20.0f);
            }

            void SummonHealer()
            {
                uint32 entry = rand() % 2 ? NPC_HEALER_A: NPC_HEALER_H;
                float posX = frand(228.0f, 270.0f);
                float posY = frand(3949.0f, 3962.0f);

                me->SummonCreature(entry, posX, posY, me->GetMap()->GetHeight(me->GetPhaseMask(), posX, posY, 100.0f), 1.37f, TempSummonType::TEMPSUMMON_CORPSE_DESPAWN);
            }

            void JustSummoned(Creature* summon) override
            {
                _summons.Summon(summon);

                switch (summon->GetEntry())
                {
                    case NPC_HEALER_A:
                    case NPC_HEALER_H:
                        ++healerCount;
                        break;
                    case NPC_ENNEMY:
                        ++ennemiesCount;
                        break;
                }
            }

            void SummonedCreatureDies(Creature* summon, Unit* /*killer*/) override
            {
                _summons.Despawn(summon);

                switch (summon->GetEntry())
                {
                    case NPC_HEALER_A:
                    case NPC_HEALER_H:
                        --healerCount;
                        break;
                    case NPC_ENNEMY:
                        --ennemiesCount;
                        break;
                }
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                switch (_events.ExecuteEvent())
                {
                    case EVENT_CHECK_PLAYERS:
                    {
                        bool playerNearWithQuest = CheckPlayers();

                        if (inProgress && !playerNearWithQuest)
                        {
                            inProgress = false;
                            Reset();
                        }
                        else if (!inProgress && playerNearWithQuest)
                        {
                            inProgress = true;
                            _events.ScheduleEvent(EVENT_UPDATE_POWER,  UPDATE_POWER_TIMER);
                            _events.ScheduleEvent(EVENT_SUMMON_ENNEMY, 5000);
                            _events.ScheduleEvent(EVENT_SUMMON_HEALER, 5000);
                        }
                        _events.ScheduleEvent(EVENT_CHECK_PLAYERS, 5000);
                        break;
                    }
                    case EVENT_UPDATE_POWER:
                        UpdatePower();
                        _events.ScheduleEvent(EVENT_UPDATE_POWER, UPDATE_POWER_TIMER);
                        break;
                    case EVENT_SUMMON_ENNEMY:
                        if (ennemiesCount < (healerCount / 2))
                        {
                            SummonEnnemy();
                            _events.ScheduleEvent(EVENT_SUMMON_ENNEMY, 5000);
                        }
                        else
                            _events.ScheduleEvent(EVENT_SUMMON_ENNEMY, 7500);
                        break;
                    case EVENT_SUMMON_HEALER:
                        if (healerCount < MAX_HEALER_COUNT)
                            SummonHealer();

                        _events.ScheduleEvent(EVENT_SUMMON_HEALER, 12500);
                        break;
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_ji_end_eventAI(creature);
        }
};

// From LoA zone_wandering_island_south.cpp
class npc_shen_healer : public CreatureScript
{
    public:
        npc_shen_healer() : CreatureScript("npc_shen_healer") { }

        struct npc_shen_healerAI : public ScriptedAI
        {
            npc_shen_healerAI(Creature* creature) : ScriptedAI(creature) { }

            void Reset() override
            {
                me->SetReactState(REACT_PASSIVE);
                me->CastSpell(me, me->GetEntry() == NPC_HEALER_A ? SPELL_HEALER_A: SPELL_HEALER_H, true);
            }

            void EnterCombat(Unit* /*who*/) override
            {
                return;
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_shen_healerAI(creature);
        }
};

} // namespace

void AddSC_wandering_island_loa()
{
    new boss_li_fei();
    new npc_nourished_yak();
    new npc_korga();
    new npc_ji_end_event();
    new npc_shen_healer();
}
