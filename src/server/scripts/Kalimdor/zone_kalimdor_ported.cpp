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
 * Ported to Project SkyFire from Legends-of-Azeroth-Pandaria-5.4.8 (src/server/scripts/Kalimdor and Maelstrom), GPL v2 or later.
 * Not taken: npc_steamwheedle_balloon (LoA has no path for the balloon it summons), npc_cos_zombie (needs Zombiefest data our
 * Culling of Stratholme instance lacks), npc_sandfury_executioner (Zul'Farrak is not in our build).
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
#include "CavernsOfTime/CullingOfStratholme/culling_of_stratholme.h"

namespace
{
namespace durotar
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Kalimdor/zone_durotar.cpp
enum eSpells
{
    SPELL_SUMMON_GARROSH_JI          = 121139,
    SPELL_BERSERK_CHARGE             = 84742,
    SPELL_WHIRLWIND                  = 84724,
    SPELL_SHOCKWAVE                  = 84715,
};
enum eEvents
{
    EVENT_CHARGE_B  = 1,
    EVENT_WHIRLWIND = 2,
    EVENT_SHOCKWAVE = 3,
};
enum eQuests
{
    QUEST_THE_HORDE_WAY                = 31013,
    QUEST_WATERSHED_PATROL             = 25188,
    QUEST_LOST_BUT_NOT_FORGOTTEN       = 25193, 
    QUEST_SPIRIT_BE_PRAISED            = 25189, 
    QUEST_RAGGARANS_FURY               = 25192, 
    QUEST_THATS_THE_END_OF_THIS_RAPTOR = 25195, 
};
enum eCreatures
{
    NPC_WATERSHED_PATROL_KC1     = 39331,
    NPC_WATERSHED_PATROL_KC2     = 39332,
    NPC_WATERSHED_PATROL_KC3     = 39333,
    NPC_WATERSHED_PATROL_KC4     = 39334,
};
const std::map<uint32, uint32> watershedMatchType =
{
    { QUEST_SPIRIT_BE_PRAISED,            NPC_WATERSHED_PATROL_KC1 },
    { QUEST_RAGGARANS_FURY,               NPC_WATERSHED_PATROL_KC2 },
    { QUEST_LOST_BUT_NOT_FORGOTTEN,       NPC_WATERSHED_PATROL_KC3 },
    { QUEST_THATS_THE_END_OF_THIS_RAPTOR, NPC_WATERSHED_PATROL_KC4 },
};

// ===== npc_garrosh_hellscream_warchief
// Garrosh Hellscream warchief 39605
class npc_garrosh_hellscream_warchief : public CreatureScript
{
    public:
        npc_garrosh_hellscream_warchief() : CreatureScript("npc_garrosh_hellscream_warchief") { }

        bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_THE_HORDE_WAY)
                creature->CastSpell(player, SPELL_SUMMON_GARROSH_JI, true);

            return false;
        }

        struct npc_garrosh_hellscream_warchiefAI : public ScriptedAI
        {
            npc_garrosh_hellscream_warchiefAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;

            void Reset() override
            {
                events.Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                events.ScheduleEvent(EVENT_WHIRLWIND, 25 * IN_MILLISECONDS);
                events.ScheduleEvent(EVENT_CHARGE_B, urand(1 * IN_MILLISECONDS, 5 * IN_MILLISECONDS));
                events.ScheduleEvent(EVENT_SHOCKWAVE, 15 * IN_MILLISECONDS);
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
                        case EVENT_CHARGE_B:
                            if (HandleDelayIfInWhirlwind(eventId))
                                break;

                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, NonTankTargetSelector(me)))
                                DoCast(target, SPELL_BERSERK_CHARGE, false);

                            events.ScheduleEvent(EVENT_CHARGE_B, urand(12.5 * IN_MILLISECONDS, 31 * IN_MILLISECONDS));
                            break;
                        case EVENT_WHIRLWIND:
                            DoCast(me, SPELL_WHIRLWIND);
                            events.ScheduleEvent(EVENT_WHIRLWIND, 50 * IN_MILLISECONDS);
                            me->ClearUnitState(UNIT_STATE_CASTING);
                            break;
                        case EVENT_SHOCKWAVE:
                            if (HandleDelayIfInWhirlwind(eventId))
                                break;

                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0, 180.0f, true))
                                DoCast(target, SPELL_SHOCKWAVE, false);

                            events.ScheduleEvent(EVENT_SHOCKWAVE, 15 * IN_MILLISECONDS);
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

            private:
                bool HandleDelayIfInWhirlwind(uint32 eventID)
                {
                    if (me->HasAura(SPELL_WHIRLWIND))
                    {
                        events.RescheduleEvent(eventID, urand(1 * IN_MILLISECONDS, 2 * IN_MILLISECONDS));
                        return true;
                    }

                    return false;
                }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_garrosh_hellscream_warchiefAI(creature);
        }
};

// ===== npc_watershed_patrol
// Watershed Patrol 3193, 39325, 39326, 39324
class npc_watershed_patrol : public CreatureScript
{
    public:
        npc_watershed_patrol() : CreatureScript("npc_watershed_patrol") { }

        bool OnQuestReward(Player* player, Creature* creature, const Quest *_Quest, uint32 /*slot*/) override
        {
            if (player->GetQuestStatus(QUEST_WATERSHED_PATROL) != QUEST_STATUS_INCOMPLETE)
                return false;

            for (auto iType : watershedMatchType)
            {
                if (_Quest->GetQuestId() == iType.first)
                {
                    player->KilledMonsterCredit(iType.second);

                    if (player->GetQuestStatus(QUEST_WATERSHED_PATROL) == QUEST_STATUS_INCOMPLETE)
                        player->CompleteQuest(QUEST_WATERSHED_PATROL);

                    return true;
                }
            }

            return true;
        }

        struct npc_watershed_patrolAI : public ScriptedAI
        {
            npc_watershed_patrolAI(Creature* creature) : ScriptedAI(creature) { }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_watershed_patrolAI(creature);
        }
};
} // namespace durotar

namespace moonglade
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Kalimdor/zone_moonglade.cpp

// ===== npc_bunthen_plainswind
// Bunthen Plainswind 11798, Silva Filnaveth 11800
class npc_bunthen_plainswind : public CreatureScript
{
    public:
        npc_bunthen_plainswind() : CreatureScript("npc_bunthen_plainswind") { }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            if (action == GOSSIP_ACTION_INFO_DEF + 1)
            {
                player->CLOSE_GOSSIP_MENU();
                player->ActivateTaxiPathTo(player->GetTeam() == HORDE ? 316 : 315);
            }

            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (player->getClass() == CLASS_DRUID && (creature->GetEntry() == 11798 && player->GetTeam() == HORDE || creature->GetEntry() == 11800 && player->GetTeam() != HORDE))
                player->ADD_GOSSIP_ITEM_DB(player->GetDefaultGossipMenuForSource(creature), 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }
};
} // namespace moonglade

namespace thunder_bluff
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Kalimdor/zone_thunder_bluff.cpp
enum CairneBloodhoof
{
    SPELL_BERSERKER_CHARGE  = 16636,
    SPELL_CLEAVE            = 16044,
    SPELL_MORTAL_STRIKE     = 16856,
    SPELL_THUNDERCLAP       = 23931,
    SPELL_UPPERCUT          = 22916,
    TALK_AGGRO              = 0,
    TALK_EVADE              = 1,
};

// ===== npc_baine_bloodhoof
/// @todo verify abilities/timers
struct npc_baine_bloodhoof : public ScriptedAI
{
    npc_baine_bloodhoof(Creature* creature) : ScriptedAI(creature) { }

    uint32 BerserkerChargeTimer;
    uint32 CleaveTimer;
    uint32 MortalStrikeTimer;
    uint32 ThunderclapTimer;
    uint32 UppercutTimer;

    void Reset() override
    {
        BerserkerChargeTimer = 30000;
        CleaveTimer = 5000;
        MortalStrikeTimer = 10000;
        ThunderclapTimer = 15000;
        UppercutTimer = 10000;
    }

    void EnterCombat(Unit* /*who*/) override
    {
        Talk(TALK_AGGRO);
    }

    void JustReachedHome() override
    {
        Talk(TALK_EVADE);
    }

    void UpdateAI(uint32 diff) override
    {
        if (!UpdateVictim())
            return;

        if (BerserkerChargeTimer <= diff)
        {
            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                DoCast(target, SPELL_BERSERKER_CHARGE);
            BerserkerChargeTimer = 25000;
        } else BerserkerChargeTimer -= diff;

        if (UppercutTimer <= diff)
        {
            DoCastVictim(SPELL_UPPERCUT);
            UppercutTimer = 20000;
        } else UppercutTimer -= diff;

        if (ThunderclapTimer <= diff)
        {
            DoCastVictim(SPELL_THUNDERCLAP);
            ThunderclapTimer = 15000;
        } else ThunderclapTimer -= diff;

        if (MortalStrikeTimer <= diff)
        {
            DoCastVictim(SPELL_MORTAL_STRIKE);
            MortalStrikeTimer = 15000;
        } else MortalStrikeTimer -= diff;

        if (CleaveTimer <= diff)
        {
            DoCastVictim(SPELL_CLEAVE);
            CleaveTimer = 7000;
        } else CleaveTimer -= diff;

        DoMeleeAttackIfReady();
    }
};
} // namespace thunder_bluff

namespace kezan
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Maelstrom/zone_kezan.cpp

// ===== npc_sister_goldskimmer
struct npc_sister_goldskimmer : public ScriptedAI
{
    npc_sister_goldskimmer(Creature* creature) : ScriptedAI(creature) { }

    void MoveInLineOfSight(Unit* who) override
    {
        if (who->GetTypeId() == TypeID::TYPEID_PLAYER && me->IsFriendlyTo(who) && me->isInFrontInMap(who, 7) && !who->HasAura(74973))
        {
            Talk(0, who);
            me->CastSpell(who, 74973, true);
        }
    }
};
} // namespace kezan

namespace culling_of_stratholme
{
// From LoA's culling_of_stratholme.h (our header has no entrance Chromie data)
uint32 const ITEM_ARCANE_DISRUPTOR = 37888;
Position const ChromieEntranceSummonPos = { 1813.29f, 1283.57f, 142.325f, 3.87816f };
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Kalimdor/CavernsOfTime/CullingOfStratholme/culling_of_stratholme.cpp
#define GOSSIP_ITEM_CHROMIE_0 "I need something for revealing the scourge plans, Chromie."
#define GOSSIP_ITEM_CHROMIE_1 "Take me to the entrance of Stratholme."

// ===== npc_chromie
class npc_chromie : public CreatureScript
{
    public:
        npc_chromie() : CreatureScript("npc_chromie") { }

        bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            switch (action)
            {
                case GOSSIP_ACTION_INFO_DEF:
                    player->AddItem(ITEM_ARCANE_DISRUPTOR, 1);
                    break;
                case GOSSIP_ACTION_INFO_DEF+1:
                    player->TeleportTo(player->GetMapId(), ChromieEntranceSummonPos.GetPositionX() - 3.0f, ChromieEntranceSummonPos.GetPositionY() - 3.0f, ChromieEntranceSummonPos.GetPositionZ(), 0.0f);
                    break;
            }
            player->CLOSE_GOSSIP_MENU();
            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            InstanceScript* instance = player->GetInstanceScript();

            if (instance)
            {
                if (creature->IsQuestGiver())
                    player->PrepareQuestMenu(creature->GetGUID());

                if (instance->GetData(DATA_CRATE_COUNT) < 5)
                {
                    if(!player->HasItemCount(ITEM_ARCANE_DISRUPTOR, 1))
                        player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_CHROMIE_0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
                    player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                }
                else
                {
                    player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ITEM_CHROMIE_1, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF+1);
                    player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
                }
            }
            return true;
        }
};
} // namespace culling_of_stratholme

namespace uldum
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Kalimdor/zone_uldum.cpp
enum Spells
{
    SPELL_TELEPORT_TO_RAMKAHEN      = 94564,
};
enum CreatureIds
{
    NPC_SUN_PRIEST_ASARIS    = 47715,
    NPC_ASAQ                 = 47930,
    NPC_NORMACH              = 46603,
};
enum Quests
{
    QUEST_ESCAPE_FROM_THE_LOST_CITY = 28112,
    QUEST_IMPENDING_RETRIBUTION     = 28134,
};
enum Credits
{
    CREDIT_SUN_PRIEST_ASARIS    = 47933,
    CREDIT_CONVERSATION_ASAQ    = 47936,
    CREDIT_CONVERSATION_NOMARCH = 47932,
};
const std::map<uint32, uint32> CreditMatchType =
{
    { NPC_SUN_PRIEST_ASARIS, CREDIT_SUN_PRIEST_ASARIS },
    { NPC_ASAQ,              CREDIT_CONVERSATION_ASAQ },
    { NPC_NORMACH,           CREDIT_CONVERSATION_NOMARCH },
};

// ===== npc_prince_nadun
// Prince Nadun 46872
class npc_prince_nadun : public CreatureScript
{
    public:
        npc_prince_nadun() : CreatureScript("npc_prince_nadun") { }

        bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
        {
            if (quest->GetQuestId() == QUEST_ESCAPE_FROM_THE_LOST_CITY)
                player->CastSpell(player, SPELL_TELEPORT_TO_RAMKAHEN, true);

            return false;
        }
};

// ===== npc_quest_impending_retribution
// Quest Impending Retribution 47715, 47930, 46603
class npc_quest_impending_retribution : public CreatureScript
{
    public:
        npc_quest_impending_retribution() : CreatureScript("npc_quest_impending_retribution") { }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            if (action == GOSSIP_ACTION_INFO_DEF + 1)
                player->KilledMonsterCredit(CreditMatchType.find(creature->GetEntry())->second);

            player->CLOSE_GOSSIP_MENU();

            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            if (player->GetQuestStatus(QUEST_IMPENDING_RETRIBUTION) != QUEST_STATUS_INCOMPLETE)
                return false;

            switch (creature->GetEntry())
            {
                case NPC_SUN_PRIEST_ASARIS:
                case NPC_ASAQ:
                case NPC_NORMACH:
                    player->ADD_GOSSIP_ITEM_DB(player->GetDefaultGossipMenuForSource(creature), 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                    break;
            }

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }
};
} // namespace uldum

namespace dire_maul
{
// From LoA's dire_maul.h
uint32 const GO_CONSERVATORY_DOOR = 176907;
const Position ironbarkPath[4]
{
    { -42.31f, -267.44f, -57.32f, 6.05f },
    {   7.69f, -288.92f, -52.41f, 5.89f },
    {  63.08f, -269.52f, -53.95f, 0.33f },
    { 127.53f, -278.66f, -55.88f, 6.16f },
};
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Kalimdor/DireMaul/dire_maul.cpp

// ===== npc_old_ironbark
// Old Ironbark 11491
class npc_old_ironbark : public CreatureScript
{
    public:
        npc_old_ironbark() : CreatureScript("npc_old_ironbark") { }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();

            if (action == GOSSIP_ACTION_INFO_DEF + 1)
            {
                creature->RemoveFlag(UNIT_FIELD_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

                uint32 delay = 0;
                uint64 guid = creature->GetGUID();

                Movement::MoveSplineInit init(creature);
                for (auto itr : ironbarkPath)
                    init.Path().push_back(G3D::Vector3(itr.GetPositionX(), itr.GetPositionY(), itr.GetPositionZ()));

                init.SetSmooth();
                init.SetUncompressed();
                init.Launch();
                creature->m_Events.Schedule(delay += creature->GetSplineDuration(), 1, [this,creature,guid]()
                {
                    // our Dire Maul instance script does not track this door: open the nearest one
                    if (Unit* ironbark = ObjectAccessor::GetUnit(*creature, guid))
                        if (GameObject* door = ironbark->FindNearestGameObject(GO_CONSERVATORY_DOOR, 40.0f))
                            door->UseDoorOrButton();
                });
            }

            player->CLOSE_GOSSIP_MENU();

            return true;
        }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            player->ADD_GOSSIP_ITEM_DB(player->GetDefaultGossipMenuForSource(creature), 0, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);

            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());
            return true;
        }

        struct npc_old_ironbarkAI : public ScriptedAI
        {
            npc_old_ironbarkAI(Creature* creature) : ScriptedAI(creature) { }

            void UpdateAI(uint32 /*diff*/) override { }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_old_ironbarkAI(creature);
        }
};
} // namespace dire_maul

namespace mulgore
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Kalimdor/zone_mulgore.cpp
#define GOSSIP_SW "Tell me a story, Skorn."

// ===== npc_skorn_whitecloud
class npc_skorn_whitecloud : public CreatureScript
{
public:
    npc_skorn_whitecloud() : CreatureScript("npc_skorn_whitecloud") { }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action)
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF)
            player->SEND_GOSSIP_MENU(523, creature->GetGUID());

        return true;
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        if (creature->IsQuestGiver())
            player->PrepareQuestMenu(creature->GetGUID());

        if (!player->GetQuestRewardStatus(770))
            player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_SW, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

        player->SEND_GOSSIP_MENU(522, creature->GetGUID());

        return true;
    }

};
} // namespace mulgore

namespace azshara
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Kalimdor/zone_azshara.cpp
enum groundTroopsTypes
{
    NPC_AWOL_GRUNT_DESCIPLINED = 42893,
    TALK_ENRAGE = 0,
    TALK_DEFEAT,
    TALK_APOLOGY,
    ACTION_CHOISE = 0,
};

// ===== npc_azshara_awol_grunt
// AWOL Grunt 42646
struct npc_azshara_awol_grunt : public ScriptedAI
{
    npc_azshara_awol_grunt(Creature* creature) : ScriptedAI(creature) { }

    TaskScheduler scheduler;
    uint64 targetGUID;
    bool hasDefeat;

    void Reset() override
    {
        targetGUID = 0;
        hasDefeat = false;
        me->setFaction(125);
    }

    void SetGUID(uint64 guid, int32 /*type*/) override
    {
        targetGUID = guid;
    }

    void DoAction(int32 actionId) override
    {
        if (actionId == ACTION_CHOISE)
        {
            uint32 ourChoise = urand(0, 1);

            if (ourChoise)
            {
                if (Player* target = ObjectAccessor::GetPlayer(*me, targetGUID))
                {
                    Talk(TALK_APOLOGY, target);
                    target->KilledMonsterCredit(NPC_AWOL_GRUNT_DESCIPLINED);
                }

                scheduler
                    .Schedule(Seconds(2), [this](TaskContext context)
                {
                    MoveAway();
                });
            }
            else
            {
                me->setFaction(16);

                if (Player* target = ObjectAccessor::GetPlayer(*me, targetGUID))
                {
                    Talk(TALK_ENRAGE, target);
                    AttackStart(target);
                }
            }
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
            me->setFaction(125);
            me->PrepareChanneledCast(me->GetOrientation());
            Talk(TALK_DEFEAT);

            if (Player* target = ObjectAccessor::GetPlayer(*me, targetGUID))
                target->KilledMonsterCredit(NPC_AWOL_GRUNT_DESCIPLINED);

            scheduler
                .Schedule(Seconds(2), [this](TaskContext context)
            {
                MoveAway();
            });
        }
    }

    void UpdateAI(uint32 diff) override
    {
        scheduler.Update(diff);

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }

    private:
        void MoveAway()
        {
            Position pos = me->GetNearPosition(15.0f, frand(0.0f, 2 * M_PI));
            me->GetMotionMaster()->MovePoint(0, pos);
            me->DespawnOrUnsummon(me->GetSplineDuration());
        }
};
} // namespace azshara

} // namespace

void AddSC_kalimdor_ported()
{
    new durotar::npc_garrosh_hellscream_warchief();
    new durotar::npc_watershed_patrol();
    new moonglade::npc_bunthen_plainswind();
    new creature_script<thunder_bluff::npc_baine_bloodhoof>("npc_baine_bloodhoof");
    new creature_script<kezan::npc_sister_goldskimmer>("npc_sister_goldskimmer");
    new culling_of_stratholme::npc_chromie();
    new uldum::npc_prince_nadun();
    new uldum::npc_quest_impending_retribution();
    new dire_maul::npc_old_ironbark();
    new mulgore::npc_skorn_whitecloud();
    new creature_script<azshara::npc_azshara_awol_grunt>("npc_azshara_awol_grunt");
}
