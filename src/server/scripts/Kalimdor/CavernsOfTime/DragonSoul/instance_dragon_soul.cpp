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
 * (Legends-of-Azeroth-Pandaria-5.4.8 src/server/scripts/Kalimdor/CavernsOfTime/DragonSoul/instance_dragon_soul.cpp, GPL v2 or later).
 * Mechanical API changes by skyfire_port_plan/tools/loa2sf.ps1, the rest by hand.
 */

#include "ScriptMgr.h"
#include "../../../Pandaria/pandaria_loa_compat.h"
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
#include "dragon_soul.h"
#include "LFGMgr.h"
#include "LFGQueue.h"

namespace
{

#define MAX_ENCOUNTER 8

const uint32 twilightAssaultStalkerDbGuidsH[7][8] =
{
    { 9680844, 9680845, 9680846, 9680843, 9680847, 0                 },
    { 9680883, 9680884, 9680885, 9680882, 9680886, 0                 },
    { 9680888, 9680889, 9680890, 9680887, 9680891, 0                 },
    { 9680880, 9680823, 9680877, 9680878, 9680875, 9680879, 9680881, 0 },
    { 9680792, 9680788, 9680789, 9680790, 9680787, 9680791, 9680793, 0 },
    { 9680898, 9680893, 9680894, 9680895, 9680892, 9680896, 9680897, 0 },
    { 9680854, 9680849, 9680850, 9680851, 9680848, 9680852, 9680853, 0 },
};

const uint32 twilightAssaultStalkerDbGuidsV[5][10] =
{
    { 9680828, 9680827, 9680826, 9680822, 9680876, 9680825, 9680824, 9680821, 9680829, 0},
    { 9680837, 9680836, 9680835, 9680831, 9680832, 9680834, 9680833, 9680830, 9680838, 0},
    { 9680801, 9680800, 9680799, 9680795, 9680796, 9680798, 9680797, 9680794, 9680802, 0},
    { 9680819, 9680818, 9680817, 9680813, 9680814, 9680816, 9680815, 9680812, 9680820, 0},
    { 9680810, 9680809, 9680808, 9680804, 9680805, 9680807, 9680806, 9680803, 9680811, 0},
};

class instance_dragon_soul : public InstanceMapScript
{
    public:
        instance_dragon_soul() : InstanceMapScript("instance_dragon_soul", 967) { }

        struct instance_dragon_soul_InstanceMapScript : public InstanceScript, public instance_dragon_soul_trash_accessor
        {
            instance_dragon_soul_InstanceMapScript(Map* map, bool lfr) : InstanceScript(map)
            {
                SetBossNumber(MAX_ENCOUNTER);

                uiMorchokGUID = 0;
                uiKohcromGUID = 0;
                uiYorsahjGUID = 0;
                uiZonozzGUID = 0;
                uiHagaraGUID = 0;
                uiUltraxionGUID = 0;
                uiBlackhornGUID = 0;
                uiAllianceShipGUID = 0;
                uiAllianceShipFirstGUID = 0;
                uiHordeShipGUID = 0;
                uiSwayzeGUID = 0;
                // teleports
                uiWyrmrestBaseFromSummitGUID = 0;
                uiWyrmrestBaseFromGunshipGUID = 0;
                uiWyrmrestBaseFromMaelstormGUID = 0;
                uiWyrmrestSummitGUID = 0;
                uiEyeofEternityGUID = 0;
                uiDeckGUID = 0;
                uiMaelstormGUID = 0;
                uiDeathwingGUID = 0;
                uiAlexstraszaDragonGUID = 0;
                uiNozdormuDragonGUID = 0;
                uiYseraDragonGUID = 0;
                uiKalecgosDragonGUID = 0;
                uiThrall2GUID = 0;

                memset(uiLesserCacheofTheAspects, 0, sizeof(uiLesserCacheofTheAspects));
                memset(uiBackPlates, 0, sizeof(uiBackPlates));
                memset(uiGreaterCacheofTheAspects, 0, sizeof(uiGreaterCacheofTheAspects));
                memset(uiElementiumFragment, 0, sizeof(uiGreaterCacheofTheAspects));

                memset(twilightAssaultStalkerGuidsH, 0, sizeof(twilightAssaultStalkerGuidsH));
                memset(twilightAssaultStalkerGuidsV, 0, sizeof(twilightAssaultStalkerGuidsV));
                memset(twilightAssaultLanesUsedH, 0, sizeof(twilightAssaultLanesUsedH));
                memset(twilightAssaultLanesUsedV, 0, sizeof(twilightAssaultLanesUsedV));

                uiNethestraszGUID = 0;
                uiOpenPortalEvent = 0;
                bHagaraEvent = 0;
                uiThrallEvent = 0;
                uiDragonSoulEvent = 0;
                uiUltraxionTrash = 0;
                uiDragonsCount = 0;
                uiDeathwingEvent = 0;
                uiDelayedChestData = 0;

                isLfr = lfr;
                lfrSectionFound = false;
                isFallOfDeathwing = false;
            }

            void OnPlayerEnter(Player* player) override
            {
                if (!uiTeamInInstance)
                    uiTeamInInstance = player->GetTeam();
                if (isLfr && !lfrSectionFound)
                {
                    lfrSectionFound = true;
                    Group* group = player->GetGroup();
                    if (!group)
                        return;
                    if (group->isLFGGroup())
                        isFallOfDeathwing = sLFGMgr->GetDungeon(group->GetGUID()) == 417;

                    if (isFallOfDeathwing)
                    {
                        if (Creature* boss = instance->GetCreature(uiMorchokGUID))
                            boss->DespawnOrUnsummon();
                        if (Creature* boss = instance->GetCreature(uiZonozzGUID))
                            boss->DespawnOrUnsummon();
                        if (Creature* boss = instance->GetCreature(uiYorsahjGUID))
                            boss->DespawnOrUnsummon();
                        if (Creature* boss = instance->GetCreature(uiHagaraGUID))
                            boss->DespawnOrUnsummon();
                        SetBossState(DATA_MORCHOK, DONE);
                        SetBossState(DATA_ZONOZZ, DONE);
                        SetBossState(DATA_YORSAHJ, DONE);
                        SetBossState(DATA_HAGARA, DONE);
                        uiOpenPortalEvent = uint64(uint64(DONE));
                    }
                }
                if (GetBossState(DATA_MADNESS) == DONE && player->GetAreaId() == 5893)
                    player->AddAura(SPELL_CALM_MAELSTROM_SKYBOX, player);
            }

            void OnMovieEnded(Player* player) override
            {
                if (!player->isDead() && !player->HasAura(SPELL_PARACHUTE) && (GetBossState(DATA_SPINE) == IN_PROGRESS || GetBossState(DATA_SPINE) == DONE) && (GetBossState(DATA_MADNESS) != DONE))
                    player->CastSpell(player, SPELL_PARACHUTE, true);
            }

            void OnCreatureCreate(Creature* creature) override
            {
                if (isLfr && !lfrSectionFound)
                {
                    Map::PlayerList const &players = instance->GetPlayers();
                    if (!players.isEmpty())
                        if (Player* player = players.begin()->GetSource())
                            OnPlayerEnter(player);
                }

                if (isLfr)
                {
                    uint32 entry = creature->GetEntry();
                    if (isFallOfDeathwing)
                    {
                        if (entry == NPC_MORCHOK || entry == NPC_ZONOZZ || entry == NPC_YORSAHJ || entry == NPC_HAGARA)
                        {
                            creature->DespawnOrUnsummon();
                            return;
                        }
                    }
                    else
                    {
                        if (entry == NPC_ULTRAXION || entry == NPC_BLACKHORN || entry == NPC_SKY_CAPTAIN_SWAYZE || entry == NPC_KAANU_REEVS)
                        {
                            creature->DespawnOrUnsummon();
                            return;
                        }
                    }
                }

                switch (creature->GetEntry())
                {
                    case NPC_MORCHOK:
                        uiMorchokGUID = creature->GetGUID();
                        break;
                    case NPC_KOHCROM:
                        uiKohcromGUID = creature->GetGUID();
                        break;
                    case NPC_YORSAHJ:
                        uiYorsahjGUID = creature->GetGUID();
                        break;
                    case NPC_ZONOZZ:
                        uiZonozzGUID = creature->GetGUID();
                        break;
                    case NPC_HAGARA:
                        uiHagaraGUID = creature->GetGUID();
                        break;
                    case NPC_ULTRAXION:
                        uiUltraxionGUID = creature->GetGUID();
                        break;
                    case NPC_BLACKHORN:
                        uiBlackhornGUID = creature->GetGUID();
                        break;
                    case NPC_SKY_CAPTAIN_SWAYZE:
                        if (creature->GetPositionZ() > 200.0f)
                            uiSwayzeGUID = creature->GetGUID();
                        if (GetBossState(DATA_BLACKHORN) == DONE)
                            creature->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        break;
                    case NPC_TWILIGHT_ASSAULTER_1:
                    case NPC_TWILIGHT_ASSAULTER_2:
                    case NPC_TWILIGHT_ASSAULTER_3:
                    case NPC_TWILIGHT_ASSAULTER_4:
                        assaultersGUIDs.push_back(creature->GetGUID());
                        if (creature->isDead())
                            creature->Respawn();
                        break;
                    case NPC_DEATHWING_EVENT:
                        uiDeathwingEvent = creature->GetGUID();
                        if (GetData(DATA_ULTRAXION_TRASH) == DONE)
                            creature->DespawnOrUnsummon();
                        break;
                    case NPC_THRALL_1:
                        uiThrallEvent = creature->GetGUID();
                        creature->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        if (GetBossState(DATA_ULTRAXION) == DONE)
                        {
                            creature->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                            creature->SummonCreature(NPC_SKY_CAPTAIN_SWAYZE, customPos[1], TempSummonType::TEMPSUMMON_MANUAL_DESPAWN, 0);
                            creature->SummonCreature(NPC_KAANU_REEVS, customPos[2], TempSummonType::TEMPSUMMON_MANUAL_DESPAWN, 0);
                        }
                        else if (GetBossState(DATA_HAGARA) == DONE)
                            creature->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
                        break;
                    case NPC_TWILIGHT_ASSAULTER_STALKER:
                    {
                        for (uint8 row = 0; row < 7; ++row)
                        {
                            for (uint8 col = 0; col < 8; ++col)
                            {
                                if (!twilightAssaultStalkerDbGuidsH[row][col])
                                    break;
                                if (twilightAssaultStalkerDbGuidsH[row][col] == creature->GetDBTableGUIDLow())
                                {
                                    twilightAssaultStalkerGuidsH[row][col] = creature->GetGUID();
                                    return;
                                }
                            }
                        }
                        for (uint8 col = 0; col < 5; ++col)
                        {
                            for (uint8 row = 0; row < 10; ++row)
                            {
                                if (!twilightAssaultStalkerDbGuidsV[col][row])
                                    break;
                                if (twilightAssaultStalkerDbGuidsV[col][row] == creature->GetDBTableGUIDLow())
                                {
                                    twilightAssaultStalkerGuidsV[col][row] = creature->GetGUID();
                                    return;
                                }
                            }
                        }
                        SF_LOG_ERROR("scripts", "instance_dragon_soul: NPC_TWILIGHT_ASSAULTER_STALKER of unknown DB GUID was spawned: {}", creature->GetDBTableGUIDLow());
                        break;
                    }
                    case NPC_EIENDORMI:
                    case NPC_VALEERA:
                        dragonstaxiGUIDs.push_back(creature->GetGUID());
                        creature->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_SPELLCLICK);
                        if (GetBossState(DATA_MORCHOK) == DONE)
                            creature->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_SPELLCLICK);
                        break;
                    case NPC_NETHESTRASZ:
                        uiNethestraszGUID = creature->GetGUID();
                        creature->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_SPELLCLICK);
                        if ((GetBossState(DATA_YORSAHJ) == DONE) && (GetBossState(DATA_ZONOZZ) == DONE))
                            creature->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_SPELLCLICK);
                        break;
                    case NPC_THRALL_2:
                        uiThrall2GUID = creature->GetGUID();
                        break;
                    // teleports hardcoding
                    case NPC_TRAVEL_TO_WYRMREST_BASE:
                        if (creature->GetPositionZ() < 50)
                        {
                            uiWyrmrestBaseFromMaelstormGUID = creature->GetGUID();
                            maelstormteleGUIDs.push_back(creature->GetGUID());
                            SetPortalState(creature, GetBossState(DATA_SPINE) == DONE);
                        }
                        else if (creature->GetPositionZ() < 100)
                        {
                            startportalsGUIDs.push_back(creature->GetGUID());
                            SetPortalState(creature, GetBossState(DATA_MORCHOK) == DONE);
                        }
                        else if (creature->GetPositionZ() < 200)
                        {
                            uiWyrmrestBaseFromGunshipGUID = creature->GetGUID();
                            SetPortalState(creature, GetBossState(DATA_ULTRAXION) == DONE);
                        }
                        else
                        {
                            uiWyrmrestBaseFromSummitGUID = creature->GetGUID();
                            SetPortalState(creature, (GetBossState(DATA_YORSAHJ) == DONE && GetBossState(DATA_ZONOZZ) == DONE));
                        }
                        teleportGUIDs.push_back(creature->GetGUID());
                        break;
                    case NPC_DEATHWING:
                        uiDeathwingGUID = creature->GetGUID();
                        break;
                    case NPC_ALEXSTRASZA_DRAGON:
                        uiAlexstraszaDragonGUID = creature->GetGUID();
                        break;
                    case NPC_NOZDORMU_DRAGON:
                        uiNozdormuDragonGUID = creature->GetGUID();
                        break;
                    case NPC_YSERA_DRAGON:
                        uiYseraDragonGUID = creature->GetGUID();
                        break;
                    case NPC_KALECGOS_DRAGON:
                        uiKalecgosDragonGUID = creature->GetGUID();
                        break;
                    case NPC_TRAVEL_TO_WYRMREST_TEMPLE:
                        SetPortalState(creature, GetBossState(DATA_MORCHOK) == DONE);
                        startportalsGUIDs.push_back(creature->GetGUID());
                        teleportGUIDs.push_back(creature->GetGUID());
                        break;
                    case NPC_TRAVEL_TO_WYRMREST_SUMMIT:
                        uiWyrmrestSummitGUID = creature->GetGUID();
                        wyrmrestsummitGUIDs.push_back(creature->GetGUID());
                        teleportGUIDs.push_back(creature->GetGUID());
                        SetPortalState(creature, (GetBossState(DATA_YORSAHJ) == DONE && GetBossState(DATA_ZONOZZ) == DONE));
                        break;
                    case NPC_TRAVEL_TO_EYE_OF_ETERNITY:
                        uiEyeofEternityGUID = creature->GetGUID();
                        wyrmrestsummitGUIDs.push_back(creature->GetGUID());
                        teleportGUIDs.push_back(creature->GetGUID());
                        SetPortalState(creature, GetData(DATA_OPEN_PORTAL_TO_EYE) == DONE);
                        creature->SetVisible(GetData(DATA_OPEN_PORTAL_TO_EYE) == DONE);
                        break;
                    case NPC_TRAVEL_TO_DECK:
                        uiDeckGUID = creature->GetGUID();
                        maelstormteleGUIDs.push_back(creature->GetGUID());
                        teleportGUIDs.push_back(creature->GetGUID());
                        creature->SetVisible(GetBossState(DATA_SPINE) == DONE);
                        SetPortalState(creature, GetBossState(DATA_SPINE) == DONE);
                        break;
                    case NPC_TRAVEL_TO_MAELSTORM:
                        uiMaelstormGUID = creature->GetGUID();
                        maelstormteleGUIDs.push_back(creature->GetGUID());
                        teleportGUIDs.push_back(creature->GetGUID());
                        creature->SetVisible(GetBossState(DATA_SPINE) == DONE);
                        SetPortalState(creature, GetBossState(DATA_SPINE) == DONE);
                        break;
                    default:
                        break;
                }
            }

            void OnCreatureRemove(Creature* creature) override
            {
                switch (creature->GetEntry())
                {
                    case NPC_ULTRAXION:
                        uiUltraxionGUID = 0;
                        break;
                    case NPC_BLACKHORN:
                        uiBlackhornGUID = 0;
                        break;
                    case NPC_DEATHWING:
                        uiDeathwingGUID = 0;
                        break;
                    case NPC_ALEXSTRASZA_DRAGON:
                        uiAlexstraszaDragonGUID = 0;
                        break;
                    case NPC_NOZDORMU_DRAGON:
                        uiNozdormuDragonGUID = 0;
                        break;
                    case NPC_YSERA_DRAGON:
                        uiYseraDragonGUID = 0;
                        break;
                    case NPC_KALECGOS_DRAGON:
                        uiKalecgosDragonGUID = 0;
                        break;
                }
            }

            void OnGameObjectCreate(GameObject* go) override
            {
                if (isLfr && !lfrSectionFound)
                {
                    Map::PlayerList const &players = instance->GetPlayers();
                    if (!players.isEmpty())
                        if (Player* player = players.begin()->GetSource())
                            OnPlayerEnter(player);
                }

                switch (go->GetEntry())
                {
                    case GO_LESSER_CACHE_OF_THE_ASPECTS_LFR:
                        if (!isLfr)
                        {
                            LoaCompat::SetPhaseMask(go, 256, true);
                            return;
                        }
                        uiLesserCacheofTheAspects[1] = go->GetGUID();
                        break;
                    case GO_LESSER_CACHE_OF_THE_ASPECTS_10N:
                        uiLesserCacheofTheAspects[0] = go->GetGUID();
                        break;
                    case GO_LESSER_CACHE_OF_THE_ASPECTS_25N:
                        if (isLfr)
                        {
                            LoaCompat::SetPhaseMask(go, 256, true);
                            return;
                        }
                        uiLesserCacheofTheAspects[1] = go->GetGUID();
                        break;
                    case GO_LESSER_CACHE_OF_THE_ASPECTS_10H:
                        uiLesserCacheofTheAspects[2] = go->GetGUID();
                        break;
                    case GO_LESSER_CACHE_OF_THE_ASPECTS_25H:
                        uiLesserCacheofTheAspects[3] = go->GetGUID();
                        break;
                    case GO_ALLIANCE_SHIP:
                        uiAllianceShipGUID = go->GetGUID();
                        if (GetBossState(DATA_ULTRAXION) == DONE)
                        {
                            go->RemoveFlag(GAMEOBJECT_FIELD_FLAGS, GO_FLAG_DESTROYED);
                            go->UpdateObjectVisibility();
                        }
                        break;
                    case GO_ALLIANCE_SHIP_FIRST:
                        uiAllianceShipFirstGUID = go->GetGUID();
                        if (GetBossState(DATA_ULTRAXION) == DONE)
                        {
                            go->SetFlag(GAMEOBJECT_FIELD_FLAGS, GO_FLAG_DESTROYED);
                            go->UpdateObjectVisibility();
                        }
                        break;
                    case GO_HORDE_SHIP:
                        uiHordeShipGUID = go->GetGUID();
                        if (GetBossState(DATA_ULTRAXION) == DONE)
                        {
                            go->SetFlag(GAMEOBJECT_FIELD_FLAGS, GO_FLAG_DESTROYED);
                            go->UpdateObjectVisibility();
                        }
                        break;
                    case GO_DEATHWING_BACK_PLATE_1:
                        uiBackPlates[0] = go->GetGUID();
                        break;
                    case GO_DEATHWING_BACK_PLATE_2:
                        uiBackPlates[1] = go->GetGUID();
                        break;
                    case GO_DEATHWING_BACK_PLATE_3:
                        uiBackPlates[2] = go->GetGUID();
                        break;
                    case GO_GREATER_CACHE_OF_THE_ASPECTS_LFR:
                        if (!isLfr)
                        {
                            LoaCompat::SetPhaseMask(go, 256, true);
                            return;
                        }
                        uiGreaterCacheofTheAspects[1] = go->GetGUID();
                        break;
                    case GO_GREATER_CACHE_OF_THE_ASPECTS_10N:
                        uiGreaterCacheofTheAspects[0] = go->GetGUID();
                        break;
                    case GO_GREATER_CACHE_OF_THE_ASPECTS_25N:
                        if (isLfr)
                        {
                            LoaCompat::SetPhaseMask(go, 256, true);
                            return;
                        }
                        uiGreaterCacheofTheAspects[1] = go->GetGUID();
                        break;
                    case GO_GREATER_CACHE_OF_THE_ASPECTS_10H:
                        uiGreaterCacheofTheAspects[2] = go->GetGUID();
                        break;
                    case GO_GREATER_CACHE_OF_THE_ASPECTS_25H:
                        uiGreaterCacheofTheAspects[3] = go->GetGUID();
                        break;
                    case GO_ELEMENTIUM_FRAGMENT_LFR:
                        if (!isLfr)
                        {
                            LoaCompat::SetPhaseMask(go, 256, true);
                            return;
                        }
                        uiElementiumFragment[1] = go->GetGUID();
                        break;
                    case GO_ELEMENTIUM_FRAGMENT_10N:
                        uiElementiumFragment[0] = go->GetGUID();
                        break;
                    case GO_ELEMENTIUM_FRAGMENT_25N:
                        if (isLfr)
                        {
                            LoaCompat::SetPhaseMask(go, 256, true);
                            return;
                        }
                        uiElementiumFragment[1] = go->GetGUID();
                        break;
                    case GO_ELEMENTIUM_FRAGMENT_10H:
                        uiElementiumFragment[2] = go->GetGUID();
                        break;
                    case GO_ELEMENTIUM_FRAGMENT_25H:
                        uiElementiumFragment[3] = go->GetGUID();
                        break;
                    default:
                        break;
                }
            }

            void OnUnitDeath(Unit* unit) override
            {
                if (Player* player = unit->ToPlayer())
                {
                    if (IsEncounterInProgress() && (player->GetAreaId() == 5960 || player->GetAreaId() == 5893))
                    {
                        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET, 94644, 0, 0, player);
                        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_BE_SPELL_TARGET2, 94655, 0, 0, player);
                    }
                }
            }

            uint64 GetData64(uint32 type) const override
            {
                switch (type)
                {
                    case DATA_MORCHOK:             return uiMorchokGUID;
                    case DATA_KOHCROM:             return uiKohcromGUID;
                    case DATA_YORSAHJ:             return uiYorsahjGUID;
                    case DATA_ZONOZZ:              return uiZonozzGUID;
                    case DATA_HAGARA:              return uiHagaraGUID;
                    case DATA_ULTRAXION:           return uiUltraxionGUID;
                    case DATA_BLACKHORN:           return uiBlackhornGUID;
                    case DATA_LESSER_CACHE_10N:    return uiLesserCacheofTheAspects[0];
                    case DATA_LESSER_CACHE_25N:    return uiLesserCacheofTheAspects[1];
                    case DATA_LESSER_CACHE_10H:    return uiLesserCacheofTheAspects[2];
                    case DATA_LESSER_CACHE_25H:    return uiLesserCacheofTheAspects[3];
                    case DATA_SWAYZE:              return uiSwayzeGUID;
                    case DATA_DEATHWING:           return uiDeathwingGUID;
                    case DATA_ALEXSTRASZA_DRAGON:  return uiAlexstraszaDragonGUID;
                    case DATA_NOZDORMU_DRAGON:     return uiNozdormuDragonGUID;
                    case DATA_YSERA_DRAGON:        return uiYseraDragonGUID;
                    case DATA_KALECGOS_DRAGON:     return uiKalecgosDragonGUID;
                    case DATA_ALLIANCE_SHIP:       return uiAllianceShipGUID;
                    case DATA_ALLIANCE_SHIP_FIRST: return uiAllianceShipFirstGUID;
                    case DATA_HORDE_SHIP:          return uiHordeShipGUID;
                    case DATA_BACK_PLATE_1:        return uiBackPlates[0];
                    case DATA_BACK_PLATE_2:        return uiBackPlates[1];
                    case DATA_BACK_PLATE_3:        return uiBackPlates[2];
                    case DATA_GREATER_CACHE_10N:   return uiGreaterCacheofTheAspects[0];
                    case DATA_GREATER_CACHE_25N:   return uiGreaterCacheofTheAspects[1];
                    case DATA_GREATER_CACHE_10H:   return uiGreaterCacheofTheAspects[2];
                    case DATA_GREATER_CACHE_25H:   return uiGreaterCacheofTheAspects[3];
                    case DATA_ELEM_FRAGMENT_10N:   return uiElementiumFragment[0];
                    case DATA_ELEM_FRAGMENT_25N:   return uiElementiumFragment[1]; 
                    case DATA_ELEM_FRAGMENT_10H:   return uiElementiumFragment[2];
                    case DATA_ELEM_FRAGMENT_25H:   return uiElementiumFragment[3];
                    case DATA_DRAGON_SOUL_EVENT:   return uiDeathwingEvent;
                    case DATA_THRALL_MADNESS:      return uiThrall2GUID;
                    default:                       return 0;
                }
            }

            void SetData(uint32 type, uint32 data) override
            {   
                switch (type)
                {
                    case DATA_OPEN_PORTAL_TO_EYE:
                        uiOpenPortalEvent = uint64(uint64(data));
                        if (uiOpenPortalEvent == DONE)
                            if (Creature* EyeofEternityTele = instance->GetCreature(uiEyeofEternityGUID))
                            {
                                ActivatePortal(EyeofEternityTele);
                                SaveToDB();
                            }
                        break;
                    case DATA_HAGARA_EVENT:
                        bHagaraEvent = data;
                        switch (data)
                        {
                            case IN_PROGRESS:
                                if (Creature* WyrmrestSummitTele = instance->GetCreature(uiWyrmrestSummitGUID))
                                    DeactivatePortal(WyrmrestSummitTele);
                                break;
                            case FAIL:
                                UpdatePortals();
                                break;
                            case DONE:
                                UpdatePortals();
                                SaveToDB();
                                break;
                        }
                        break;
                    case DATA_DRAGON_SOUL_EVENT:
                        uiDragonSoulEvent = data;
                        if (uiDragonSoulEvent == DONE)
                            SaveToDB();
                        break;
                    case DATA_ULTRAXION_TRASH:
                        uiUltraxionTrash = data;
                        switch (data)
                        {
                        case IN_PROGRESS:
                            for (std::vector<uint64>::const_iterator itr = assaultersGUIDs.begin(); itr != assaultersGUIDs.end(); ++itr)
                                if (Creature* assaulter = instance->GetCreature(*itr))
                                {
                                    LoaCompat::SetPhaseMask(assaulter, 1, true);
                                    assaulter->CastSpell(assaulter, SPELL_TWILIGHT_SPAWN);
                                }
                            break;
                        case SPECIAL:
                            for (std::vector<uint64>::const_iterator itr = assaultersGUIDs.begin(); itr != assaultersGUIDs.end(); ++itr)
                                if (Creature* assaulter = instance->GetCreature(*itr))
                                    assaulter->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                            if (!teleportGUIDs.empty())
                                for (std::vector<uint64>::const_iterator itr = teleportGUIDs.begin(); itr != teleportGUIDs.end(); ++itr)
                                    if (Creature* pTeleports = instance->GetCreature((*itr)))
                                        DeactivatePortal(pTeleports);
                            break;
                        case FAIL:
                            for (std::vector<uint64>::const_iterator itr = assaultersGUIDs.begin(); itr != assaultersGUIDs.end(); ++itr)
                                if (Creature* assaulter = instance->GetCreature(*itr))
                                {
                                    assaulter->SetCanFly(true);
                                    assaulter->SetDisableGravity(true);
                                    assaulter->GetMotionMaster()->Clear(true);
                                    assaulter->Respawn(true);
                                }
                            if (Creature* deathwing = instance->GetCreature(uiDeathwingEvent))
                                deathwing->AI()->DoAction(ACTION_DEATHWING_RESET);
                            memset(twilightAssaultLanesUsedH, 0, sizeof(twilightAssaultLanesUsedH));
                            memset(twilightAssaultLanesUsedV, 0, sizeof(twilightAssaultLanesUsedV));
                            UpdatePortals();
                            break;
                        case DONE:
                            SaveToDB();
                            UpdatePortals();
                            break;
                        }
                        break;
                    case DATA_DRAGONS_COUNT:
                        if (++uiDragonsCount == 15)
                        {
                            if (Creature* thrall = instance->GetCreature(uiThrallEvent))
                                thrall->AI()->DoAction(ACTION_STOP_ASSAULTERS_SPAWN);
                            if (Creature* Deathwing = instance->GetCreature(GetData64(DATA_DRAGON_SOUL_EVENT)))
                                Deathwing->AI()->DoAction(ACTION_DEATHWING_INTRO);
                            for (std::vector<uint64>::const_iterator itr = assaultersGUIDs.begin(); itr != assaultersGUIDs.end(); ++itr)
                                if (Creature* assaulters = instance->GetCreature(*itr))
                                {
                                    assaulters->AI()->DoAction(ACTION_STOP_ASSAULT);
                                    LoaCompat::SetPhaseMask(assaulters, 256, true);
                                    assaulters->CastSpell(assaulters, SPELL_TWILIGHT_ESCAPE);
                                }
                            SetData(DATA_ULTRAXION_TRASH, DONE);
                        }
                        break;
                    case DATA_NEXT_ASSAULTER:
                    {
                        if (Creature* thrall = instance->GetCreature(uiThrallEvent))
                        {
                            std::list<Creature*> assaulters;
                            for (uint32 i = NPC_TWILIGHT_ASSAULTER_1; i < NPC_TWILIGHT_ASSAULTER_4 + 1; i++)
                                GetCreatureListWithEntryInGrid(assaulters, thrall, i, 300.0f);

                            assaulters.remove_if([=](Creature* target) { return target && (!target->IsAlive() || target->AI()->GetData(1)); });

                            if (assaulters.empty())
                                break;

                            if (Creature* assaulter = Skyfire::Containers::SelectRandomContainerElement(assaulters))
                                assaulter->AI()->DoAction(ACTION_START_ASSAULT);
                        }
                        break;
                    }
                    case DATA_SPAWN_GREATER_CHEST:
                        if (uiDelayedChestData)
                        {
                            if (instance->GetGameObject(GetData64(uiDelayedChestData)))
                            {
                                DoRespawnGameObject(GetData64(uiDelayedChestData), DAY);
                                uiDelayedChestData = 0;
                            }
                        }
                        else if (instance->GetGameObject(GetData64(data)))
                        {
                            DoRespawnGameObject(GetData64(data), DAY);
                            uiDelayedChestData = 0;
                        }
                        else
                            uiDelayedChestData = data;
                        break;
                    default:
                        break;
                }
            }
            
            uint32 GetData(uint32 type) const override
            {
                switch (type)
                {
                    case DATA_OPEN_PORTAL_TO_EYE:
                        return uiOpenPortalEvent;
                    case DATA_HAGARA_EVENT:
                        return bHagaraEvent;
                    case DATA_DRAGON_SOUL_EVENT:
                        return uiDragonSoulEvent;
                    case DATA_ULTRAXION_TRASH:
                        return uiUltraxionTrash;
                    case DATA_NEXT_ASSAULTER:
                        return 20000 - uiDragonsCount * 800;
                    case DATA_IS_LFR:
                        return IsLFR();
                    case DATA_IS_FALL_OF_DEATHWING:
                        return IsFallOfDeathwing();
                    default:
                        break;
                }

                return 0;
            }

            bool SetBossState(uint32 type, EncounterState state) override
            {
                if (!InstanceScript::SetBossState(type, state))
                    return false;

                if (type == DATA_MORCHOK && state == DONE)
                    if (!dragonstaxiGUIDs.empty())
                        for (std::vector<uint64>::const_iterator itr = dragonstaxiGUIDs.begin(); itr != dragonstaxiGUIDs.end(); ++itr)
                            if (Creature* dragonstaxi = instance->GetCreature((*itr)))
                                dragonstaxi->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_SPELLCLICK);

                if ((GetBossState(DATA_YORSAHJ) == DONE) && (GetBossState(DATA_ZONOZZ) == DONE))
                    if (Creature* Nethestrasz = instance->GetCreature(uiNethestraszGUID))
                        Nethestrasz->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_SPELLCLICK);

                if (type == DATA_HAGARA && state == DONE)
                    if (Creature* Thrall = instance->GetCreature(uiThrallEvent))
                        Thrall->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

                if (type == DATA_SPINE)
                    if (!maelstormteleGUIDs.empty())
                        for (std::vector<uint64>::const_iterator itr = maelstormteleGUIDs.begin(); itr != maelstormteleGUIDs.end(); ++itr)
                            if (Creature* Teleports = instance->GetCreature((*itr)))
                                Teleports->SetVisible(state == DONE ? true : false);

                if (type == DATA_BLACKHORN && state == DONE)
                    if (Creature* Swayze = instance->GetCreature(uiSwayzeGUID))
                        Swayze->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

                // visual state of teleporters
                if (state == IN_PROGRESS)
                {
                    if (!teleportGUIDs.empty())
                        for (std::vector<uint64>::const_iterator itr = teleportGUIDs.begin(); itr != teleportGUIDs.end(); ++itr)
                            if (Creature* Teleports = instance->GetCreature((*itr)))
                                DeactivatePortal(Teleports);
                }
                else
                    UpdatePortals();

                return true;
            }
            
            void UpdatePortals()
            {
                if (GetBossState(DATA_MORCHOK) == DONE)
                    if (!startportalsGUIDs.empty())
                        for (std::vector<uint64>::const_iterator itr = startportalsGUIDs.begin(); itr != startportalsGUIDs.end(); ++itr)
                            if (Creature* Teleports = instance->GetCreature((*itr)))
                                ActivatePortal(Teleports);
                if ((GetBossState(DATA_YORSAHJ) == DONE) && (GetBossState(DATA_ZONOZZ) == DONE))
                    if (Creature* WyrmrestBaseFromSummitTele = instance->GetCreature(uiWyrmrestBaseFromSummitGUID))
                        ActivatePortal(WyrmrestBaseFromSummitTele);
                if ((GetBossState(DATA_HAGARA) == DONE) || (GetData(DATA_OPEN_PORTAL_TO_EYE) == DONE))
                    if (!wyrmrestsummitGUIDs.empty())
                        for (std::vector<uint64>::const_iterator itr = wyrmrestsummitGUIDs.begin(); itr != wyrmrestsummitGUIDs.end(); ++itr)
                            if (Creature* Teleports = instance->GetCreature((*itr)))
                                ActivatePortal(Teleports);
                if (GetBossState(DATA_ULTRAXION) == DONE)
                    if (Creature* WyrmrestBaseFromGunship = instance->GetCreature(uiWyrmrestBaseFromGunshipGUID))
                        ActivatePortal(WyrmrestBaseFromGunship);
                if (GetBossState(DATA_SPINE) == DONE)
                    if (!maelstormteleGUIDs.empty())
                        for (std::vector<uint64>::const_iterator itr = maelstormteleGUIDs.begin(); itr != maelstormteleGUIDs.end(); ++itr)
                            if (Creature* Teleports = instance->GetCreature((*itr)))
                                ActivatePortal(Teleports);
            }

            std::string GetSaveData() override
            {
                OUT_SAVE_INST_DATA;

                std::string str_data;

                std::ostringstream saveStream;
                saveStream << "D S " << GetBossSaveData() << uiOpenPortalEvent  << " " << bHagaraEvent << " " << uiDragonSoulEvent << " " << uiUltraxionTrash << " ";

                str_data = saveStream.str();

                OUT_SAVE_INST_DATA_COMPLETE;
                return str_data;
            }

            void Load(const char* in) override
            {
                if (!in)
                {
                    OUT_LOAD_INST_DATA_FAIL;
                    return;
                }

                OUT_LOAD_INST_DATA(in);

                char dataHead1, dataHead2;

                std::istringstream loadStream(in);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'D' && dataHead2 == 'S')
                {
                    for (uint8 i = 0; i < MAX_ENCOUNTER; ++i)
                    {
                        uint32 tmpState;
                        loadStream >> tmpState;
                        if (tmpState == IN_PROGRESS || tmpState > SPECIAL)
                            tmpState = NOT_STARTED;
                        SetBossState(i, EncounterState(tmpState));
                    }
                    
                    uint32 tmpEvent;
                    loadStream >> tmpEvent;
                    if (tmpEvent != DONE) 
                        tmpEvent = NOT_STARTED;
                    uiOpenPortalEvent = uint64(uint64(tmpEvent));

                    loadStream >> tmpEvent;
                    if (tmpEvent != DONE) 
                        tmpEvent = NOT_STARTED;
                    bHagaraEvent = tmpEvent;

                    loadStream >> tmpEvent;
                    if (tmpEvent != DONE) 
                        tmpEvent = NOT_STARTED;
                    uiDragonSoulEvent = tmpEvent;

                    loadStream >> tmpEvent;
                    if (tmpEvent != DONE) 
                        tmpEvent = NOT_STARTED;
                    uiUltraxionTrash = tmpEvent;
                } else OUT_LOAD_INST_DATA_FAIL;

                OUT_LOAD_INST_DATA_COMPLETE;
            }

            bool IsLFR() const
            {
                return isLfr;
            }
            bool IsFallOfDeathwing() const
            {
                return isLfr && isFallOfDeathwing;
            }
            
            bool CheckAchievementCriteriaMeet(uint32 criteria_id, Player const* /*source*/, Unit const* /*target*/, uint32 /*miscvalue1*/) override
            {
                switch (criteria_id)
                {
                    case CRITERIA_STATS_MORCHOK_KILLS_LFR:
                    case CRITERIA_STATS_ZONOZZ_KILLS_LFR:
                    case CRITERIA_STATS_YORSAHJ_KILLS_LFR:
                    case CRITERIA_STATS_HAGARA_KILLS_LFR:
                    case CRITERIA_STATS_ULTRAXION_KILLS_LFR:
                    case CRITERIA_STATS_WARMASTER_KILLS_LFR:
                    case CRITERIA_STATS_SPINE_KILLS_LFR:
                    case CRITERIA_STATS_DEATHWING_KILLS_LFR:
                        return IsLFR();
                    case CRITARIA_DONT_STAND_SO_CLOSE_TO_ME:
                    case CRITERIA_PING_PONG_CHAMPION:
                    case CRITERIA_TASTE_THE_RAINBOW_BY:
                    case CRITERIA_TASTE_THE_RAINBOW_RG:
                    case CRITERIA_TASTE_THE_RAINBOW_BB:
                    case CRITERIA_TASTE_THE_RAINBOW_PY:
                    case CRITERIA_HOLDING_HANDS:
                    case CRITERIA_MINUTES_TO_MIDNIGHT:
                    case CRITERIA_DECK_DEFENDER:
                    case CRITERIA_MAYBE_HELL_GET_DIZZY:
                    case CRITERIA_ALEXSTRASZA_FIRST:
                    case CRITERIA_KALECGOS_FIRST:
                    case CRITERIA_NOZDORMU_FIRST:
                    case CRITERIA_YSERA_FIRST:
                    case CRITERIA_DESTROYERS_END:
                        return !IsLFR();
                    default:
                        SF_LOG_ERROR("scripts", "Achievement system call InstanceScript::CheckAchievementCriteriaMeet but instance script for map {} not have implementation for achievement criteria {}", instance->GetId(), criteria_id);
                        break;
                }

                return false;
            }

            Creature* GetNextTwilightAssaulterStalker(Creature const* current) override
            {
                uint64 currentGuid = current->GetGUID();
                for (uint8 row = 0; row < 7; ++row)
                {
                    for (uint8 col = 0; col < 8; ++col)
                    {
                        if (!twilightAssaultStalkerGuidsH[row][col])
                            break;
                        if (twilightAssaultStalkerGuidsH[row][col] == currentGuid)
                        {
                            //ASSERT(twilightAssaultLanesUsedH[row]);
                            if (!twilightAssaultLanesUsedH[row])
                                return NULL;
                            bool inverseDirection = twilightAssaultLanesUsedH[row] == 2;
                            if (inverseDirection && col == 0)
                                return NULL;
                            uint64 nextGuid = twilightAssaultStalkerGuidsH[row][inverseDirection ? col-1 : col+1];
                            return nextGuid ? instance->GetCreature(nextGuid) : NULL;
                        }
                    }
                }
                for (uint8 col = 0; col < 5; ++col)
                {
                    for (uint8 row = 0; row < 10; ++row)
                    {
                        if (!twilightAssaultStalkerGuidsV[col][row])
                            break;
                        if (twilightAssaultStalkerGuidsV[col][row] == currentGuid)
                        {
                            //ASSERT(twilightAssaultLanesUsedV[col]);
                            if (!twilightAssaultLanesUsedV[col])
                                return NULL;
                            bool inverseDirection = twilightAssaultLanesUsedV[col] == 2;
                            if (inverseDirection && row == 0)
                                return NULL;
                            uint64 nextGuid = twilightAssaultStalkerGuidsV[col][inverseDirection ? row-1 : row+1];
                            return nextGuid ? instance->GetCreature(nextGuid) : NULL;
                        }
                    }
                }
                return NULL;
            }

            std::optional<Position> GetRandomTwilightAssaulterAssaultPosition(bool horizonal, bool fromEnd, uint8& lane, uint64& targetGUID) override
            {
                if (horizonal)
                {
                    // Check if all lanes are used
                    bool allUsed = true;
                    for (uint8 i = 0; i < 7; ++i)
                        if (!twilightAssaultLanesUsedH[i])
                        {
                            allUsed = false;
                            break;
                        }
                    if (allUsed)
                    {
                        lane = 0;

                        // clear it (or it`ll stuck event)
                        for (uint8 i = 0; i < 7; ++i)
                            twilightAssaultLanesUsedH[i] = 0;

                        return std::nullopt;
                    }

                    // Find random unused lane
                    uint8 row;
                    do { row = urand(0, 6); }
                    while (twilightAssaultLanesUsedH[row]);

                    lane = row;

                    uint8 col = 0;
                    if (fromEnd)
                        while (twilightAssaultStalkerGuidsH[row][col + 1]) { ++col; } // Find the last one

                    Position assaultPos;
                    if (Creature* stalker = instance->GetCreature(targetGUID = twilightAssaultStalkerGuidsH[row][col]))
                        assaultPos = stalker->GetPosition();

                    if (fromEnd)
                    {
                        assaultPos.RelocateOffset({ 0, -10, 10 });
                        assaultPos.SetOrientation(M_PI/2);
                    }
                    else
                    {
                        assaultPos.RelocateOffset({ 0, 10, 10 });
                        assaultPos.SetOrientation(M_PI*2 - M_PI/2);
                    }

                    twilightAssaultLanesUsedH[row] = fromEnd ? 2 : 1;
                    return assaultPos;
                }
                else
                {
                    // Check if all lanes are used
                    bool allUsed = true;
                    for (uint8 i = 0; i < 5; ++i)
                        if (!twilightAssaultLanesUsedV[i])
                        {
                            allUsed = false;
                            break;
                        }
                    if (allUsed)
                    {
                        lane = 0;

                        // clear it (or it`ll stuck event)
                        for (uint8 i = 0; i < 5; ++i)
                            twilightAssaultLanesUsedV[i] = 0;

                        return std::nullopt;
                    }

                    // Find random unused lane
                    uint8 col;
                    do { col = urand(0, 4); }
                    while (twilightAssaultLanesUsedV[col]);

                    lane = col;

                    uint8 row = 0;
                    if (fromEnd)
                        while (twilightAssaultStalkerGuidsV[col][row + 1]) { ++row; } // Find the last one

                    Position assaultPos;
                    if (Creature* stalker = instance->GetCreature(targetGUID = twilightAssaultStalkerGuidsV[col][row]))
                        assaultPos = stalker->GetPosition();

                    if (fromEnd)
                    {
                        assaultPos.RelocateOffset({ -10, 0, 10 });
                        assaultPos.SetOrientation(0);
                    }
                    else
                    {
                        assaultPos.RelocateOffset({ 10, 0, 10 });
                        assaultPos.SetOrientation(M_PI);
                    }

                    twilightAssaultLanesUsedV[col] = fromEnd ? 2 : 1;
                    return assaultPos;
                }
            }

            void FreeTwilightAssaulterAssaultLane(bool horizontal, uint8 lane) override
            {
                if (horizontal)
                    twilightAssaultLanesUsedH[lane] = 0;
                else
                    twilightAssaultLanesUsedV[lane] = 0;
            }

            virtual void CleanTwilightAssaulterAssaultLane(bool horizontal, uint8 lane) override
            {
                if (horizontal)
                {
                    for (uint8 col = 0; col < 8; ++col)
                    {
                        if (Creature* stalker = instance->GetCreature(twilightAssaultStalkerGuidsH[lane][col]))
                        {
                            stalker->RemoveAllAuras();
                        }
                    }
                }
            }

            void ActivatePortal(Creature* portal)
            {
                portal->RemoveAura(SPELL_TELEPORT_VISUAL_DISABLED);
                portal->CastSpell(portal, SPELL_TELEPORT_VISUAL_DISABLED, true);
                portal->CastSpell(portal, SPELL_TELEPORT_VISUAL_ACTIVE, true);
                portal->SetFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_SPELLCLICK);
            }
            void DeactivatePortal(Creature* portal)
            {
                portal->RemoveAura(SPELL_TELEPORT_VISUAL_ACTIVE);
                portal->CastSpell(portal, SPELL_TELEPORT_VISUAL_DISABLED, true);
                portal->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP | UNIT_NPC_FLAG_SPELLCLICK);
            }
            void SetPortalState(Creature* portal, bool active)
            {
                if (active)
                    ActivatePortal(portal);
                else
                    DeactivatePortal(portal);
            }

            private:
                uint32 uiTeamInInstance;

                uint64 uiMorchokGUID;
                uint64 uiKohcromGUID;
                uint64 uiYorsahjGUID;
                uint64 uiZonozzGUID;
                uint64 uiHagaraGUID;
                uint64 uiUltraxionGUID;
                uint64 uiBlackhornGUID;
                uint64 uiAllianceShipGUID;
                uint64 uiAllianceShipFirstGUID;
                uint64 uiHordeShipGUID;
                uint64 uiSwayzeGUID;
                // teleports
                uint64 uiWyrmrestBaseFromSummitGUID;
                uint64 uiWyrmrestBaseFromGunshipGUID;
                uint64 uiWyrmrestBaseFromMaelstormGUID;
                uint64 uiWyrmrestSummitGUID;
                uint64 uiEyeofEternityGUID;
                uint64 uiDeckGUID;
                uint64 uiMaelstormGUID;
                uint64 uiDeathwingGUID;
                uint64 uiAlexstraszaDragonGUID;
                uint64 uiNozdormuDragonGUID;
                uint64 uiYseraDragonGUID;
                uint64 uiKalecgosDragonGUID;
                uint64 uiThrall2GUID;

                uint64 uiLesserCacheofTheAspects[4];
                uint64 uiBackPlates[3];
                uint64 uiGreaterCacheofTheAspects[4];
                uint64 uiElementiumFragment[4];

                std::vector<uint64> dragonstaxiGUIDs;
                std::vector<uint64> assaultersGUIDs;
                std::vector<uint64> startportalsGUIDs;
                std::vector<uint64> wyrmrestsummitGUIDs;
                std::vector<uint64> maelstormteleGUIDs;
                std::vector<uint64> teleportGUIDs;

                uint64 twilightAssaultStalkerGuidsH[7][8];
                uint64 twilightAssaultStalkerGuidsV[5][10];
                uint8 twilightAssaultLanesUsedH[7];
                uint8 twilightAssaultLanesUsedV[5];

                uint64 uiNethestraszGUID;
                uint64 uiOpenPortalEvent;
                uint64 uiDeathwingEvent;
                uint64 uiThrallEvent;
                uint32 bHagaraEvent;
                uint32 uiDragonSoulEvent;
                uint32 uiUltraxionTrash;
                uint8 uiDragonsCount;
                uint32 uiDelayedChestData;
               
                bool isLfr;
                bool lfrSectionFound;
                bool isFallOfDeathwing;
        };

        InstanceScript* GetInstanceScript(InstanceMap* map) const override
        {
            return new instance_dragon_soul_InstanceMapScript(map, map->IsLFGMap());
        }
};

} // namespace

void AddSC_instance_dragon_soul()
{
    new instance_dragon_soul();
}
