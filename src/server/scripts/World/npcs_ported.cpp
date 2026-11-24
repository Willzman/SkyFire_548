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
 * Ported to Project SkyFire from Legends-of-Azeroth-Pandaria-5.4.8 (src/server/scripts/World and
 * Pandaria/WanderingIsland), GPL v2 or later. Not taken: npc_bloodworm (LoA sets the worm's health itself and bursts on a
 * made-up chance; our Blood Gorged spell scripts and the guardian AI already handle Blood Parasite).
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
#include "CreatureTextMgr.h"
#include <random>

namespace
{
namespace specials
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/World/npcs_special.cpp
enum soulMirrorsSpell
{
    SPELL_CLONE_ME            = 45204,
};
enum naaruArrivedsMisc
{
    SPELL_VISION_OF_NAARU_COSMETIC = 94444,
};

// ===== npc_abominated_greench
struct npc_abominated_greench : public ScriptedAI
{
    npc_abominated_greench(Creature* creature) : ScriptedAI(creature) { }

    void DamageTaken(Unit* attacker, uint32& /*damage*/) override
    {
        if (attacker->GetTypeId() == TypeID::TYPEID_PLAYER)
            if (eligiblePlayers.find(attacker->GetGUID()) == eligiblePlayers.end())
                eligiblePlayers.insert(attacker->GetGUID());
    }

    void JustDied(Unit* who) override
    {
        for (auto&& guid : eligiblePlayers)
            if (Player* player = ObjectAccessor::FindPlayer(guid))
                player->KilledMonsterCredit(15664);

        if (Creature* metzen = me->FindNearestCreature(15664, 100.0f))
        {
            if (metzen->IsAlive())
            {
                metzen->GetMotionMaster()->MovePoint(0, 217.293f, -295.882f, 151.440f);
                metzen->DespawnOrUnsummon(60000);
            }

            metzen->SummonGameObject(209506, 226.833f, -263.111f, 145.776f, 0.0f, { }, 120);
            metzen->SummonGameObject(209506, 226.441f, -280.302f, 146.928f, 0.0f, { }, 120);
            metzen->SummonGameObject(209506, 228.601f, -270.087f, 146.318f, 0.0f, { }, 120);
            metzen->SummonGameObject(209497, 225.609f, -259.333f, 145.006f, 0.0f, { }, 120);
            metzen->SummonGameObject(209497, 232.154f, -266.674f, 145.929f, 0.0f, { }, 120);
            metzen->SummonGameObject(209497, 224.170f, -278.483f, 146.675f, 0.0f, { }, 120);
        }

        std::list<Creature*> helpers;
        me->GetCreatureListWithEntryInGrid(helpers, 55003, 100.0f);
        for (auto&& helper : helpers)
        {
            if (!helper->IsAlive())
                continue;

            helper->AI()->Talk(0);
            if (helper->GetPositionY() > -296.0f)
                helper->GetMotionMaster()->MovePoint(0, 218.783f, -291.750f, 150.972f);
            else
                helper->GetMotionMaster()->MovePoint(0, 220.692f, -302.994f, 151.439f);
            helper->DespawnOrUnsummon(5000);
        }
    }

    void UpdateAI(uint32 /*diff*/) override
    {
        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();

        if (me->GetDistance(me->GetPosition()) > 100.0f)
            EnterEvadeMode();
    }

private:
    std::set<uint64> eligiblePlayers;
};

// ===== npc_soul_mirror_artifact
// Soul Mirror 51337
struct npc_soul_mirror_artifact : public ScriptedAI
{
    npc_soul_mirror_artifact(Creature* creature) : ScriptedAI(creature) { }

    void IsSummonedBy(Unit* summoner) override
    {
        summoner->CastSpell(me, SPELL_CLONE_ME, true);
        me->SetTarget(summoner->GetGUID());
    }

    void EnterEvadeMode() override { }
};

// ===== npc_steam_powered_auctioneer
class npc_steam_powered_auctioneer : public CreatureScript
{
    public:
        npc_steam_powered_auctioneer() : CreatureScript("npc_steam_powered_auctioneer") { }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (creature->GetZoneId() != 4395 && !player->HasSkill(SKILL_ENGINEERING))
            {
                player->SEND_GOSSIP_MENU(20943, creature->GetGUID());
                return true;
            }

            player->GetSession()->SendAuctionHello(creature->GetGUID(), creature);
            return true;
        }
};

// ===== npc_vision_of_the_naaru_stalker
// Vision of the Naaru Invisible Stalker 51200
struct npc_vision_of_the_naaru_stalker : public ScriptedAI
{
    npc_vision_of_the_naaru_stalker(Creature* creature) : ScriptedAI(creature) { }

    void IsSummonedBy(Unit* summoner) override
    {
        DoCast(me, SPELL_VISION_OF_NAARU_COSMETIC);
    }

    void EnterEvadeMode() override { }
};

// ===== npc_visual_sparring
struct npc_visual_sparring : public ScriptedAI
{
    npc_visual_sparring(Creature* creature) : ScriptedAI(creature) { }

    void DamageTaken(Unit* attacker, uint32& damage) override
    {
        if (attacker->GetTypeId() != TypeID::TYPEID_PLAYER && !HealthAbovePct(85))
            damage = 0;
    }
};
} // namespace specials

namespace tarecgosa
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/World/tarecgosa_scripts.cpp
#define GOSSIP_A_WRINKIE_IN_TIME "Yes, Anachronos. I am ready to witness your vision of the future."
#define ACTION_A_WRINKIE_IN_TIME 1001
#define GOSSIP_ON_A_WING_AND_A_PRAYER "Take the Timeless Eye."
#define ACTION_ON_A_WING_AND_A_PRAYER 1002

// ===== npc_anachronos_15192
class npc_anachronos_15192 : public CreatureScript
{
    public:
        npc_anachronos_15192() : CreatureScript("npc_anachronos_15192") { }

        bool OnGossipHello(Player* player, Creature* creature) override
        {
            if (creature->IsQuestGiver())
                player->PrepareQuestMenu(creature->GetGUID());

            if (player->GetQuestStatus(29134) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_A_WRINKIE_IN_TIME, GOSSIP_SENDER_MAIN, ACTION_A_WRINKIE_IN_TIME);
            else if (player->GetQuestStatus(29193) == QUEST_STATUS_INCOMPLETE)
                player->ADD_GOSSIP_ITEM(GOSSIP_ICON_CHAT, GOSSIP_ON_A_WING_AND_A_PRAYER, GOSSIP_SENDER_MAIN, ACTION_ON_A_WING_AND_A_PRAYER);
            player->SEND_GOSSIP_MENU(player->GetGossipTextId(creature), creature->GetGUID());

            return true;
        }

        bool OnGossipSelect(Player* player, Creature* /*creature*/, uint32 /*sender*/, uint32 action) override
        {
            player->PlayerTalkClass->ClearMenus();
            if (action == ACTION_A_WRINKIE_IN_TIME)
            {
                player->KilledMonsterCredit(52605, 0);
            }
            else if (action == ACTION_ON_A_WING_AND_A_PRAYER)
            {
                uint32 curItemCount = player->GetItemCount(69238, false);
                if (curItemCount >= 1)
                    return false;
                
                ItemPosCountVec dest;
                uint8 msg = player->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, 49661, 1);
                if (msg == EQUIP_ERR_OK)
                {
                    Item* item = player->StoreNewItem(dest, 69238, true);
                    player->SendNewItem(item, 1, true, false);
                }
                else
                    return false;
            }

            return true;
        }
};

// ===== npc_blue_dragon_53394
class npc_blue_dragon_53394 : public CreatureScript
{
    public:
        npc_blue_dragon_53394() : CreatureScript("npc_blue_dragon_53394") { }

        struct npc_blue_dragon_53394AI : ScriptedAI
        {
            npc_blue_dragon_53394AI(Creature* creature) : ScriptedAI(creature) 
            {
                me->setActive(true);
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_blue_dragon_53394AI(creature);
        }
};

// ===== npc_tarecgosa_53396
class npc_tarecgosa_53396 : public CreatureScript
{
    public:
        npc_tarecgosa_53396() : CreatureScript("npc_tarecgosa_53396") { }

        struct npc_tarecgosa_53396AI : ScriptedAI
        {
            npc_tarecgosa_53396AI(Creature* creature) : ScriptedAI(creature) 
            {
                me->setActive(true);
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_tarecgosa_53396AI(creature);
        }
};
} // namespace tarecgosa

namespace fangs_of_the_father
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/World/fangs_of_father_scripts.cpp
enum QuestIds
{
    QUEST_TO_RAVENHOLDT         = 29934,
};

// ===== npc_mostrasz_56314
class npc_mostrasz_56314 : public CreatureScript
{
    public:
        npc_mostrasz_56314() : CreatureScript("npc_mostrasz_56314") { }

        bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 /*action*/) override
        {
            player->PlayerTalkClass->ClearMenus();

            if (player->GetQuestStatus(QUEST_TO_RAVENHOLDT) == QUEST_STATUS_INCOMPLETE)
            {
                player->KilledMonsterCredit(56314, 0);
                player->TeleportTo(0, 14.685211f, -1463.118896f, 173.92f, 6.23f);
            }
            
            return true;
        }
};
} // namespace fangs_of_the_father

namespace wandering_isle_east
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Pandaria/WanderingIsland/zone_wandering_island_east.cpp
Position rocksPos[4] =
{
    {1102.05f, 2882.11f, 94.32f, 0.11f},
    {1120.01f, 2883.20f, 96.44f, 4.17f},
    {1128.09f, 2859.44f, 97.64f, 2.51f},
    {1111.52f, 2849.84f, 94.84f, 1.94f}
};

// ===== npc_shu_water_spirit
class npc_shu_water_spirit : public CreatureScript
{
    public:
        npc_shu_water_spirit() : CreatureScript("npc_shu_water_spirit") { }

        struct npc_shu_water_spiritAI : public ScriptedAI
        {
            npc_shu_water_spiritAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap _events;
            uint8 actualPlace;
            uint64 waterSpoutGUID;

            enum eShuSpells
            {
                SPELL_WATER_SPOUT_SUMMON    = 116810,
                SPELL_WATER_SPOUT_WARNING   = 116695,
                SPELL_WATER_SPOUT_EJECT     = 116696,
                SPELL_WATER_SPOUT_VISUAL    = 117057
            };

            enum eEvents
            {
                EVENT_CHANGE_PLACE          = 1,
                EVENT_SUMMON_WATER_SPOUT    = 2,
                EVENT_WATER_SPOUT_VISUAL    = 3,
                EVENT_WATER_SPOUT_EJECT     = 4,
                EVENT_WATER_SPOUT_DESPAWN   = 5
            };

            void Reset() override
            {
                _events.Reset();
                actualPlace = 0;
                waterSpoutGUID = 0;

                _events.ScheduleEvent(EVENT_CHANGE_PLACE, 5000);
            }

            void MovementInform(uint32 type, uint32 pointId) override
            {
                if (type != EFFECT_MOTION_TYPE)
                    return;

                if (pointId == 1)
                {
                    me->RemoveAurasDueToSpell(SPELL_WATER_SPOUT_WARNING);
                    if (Player* player = me->SelectNearestPlayer(50.0f))
                    {
                        me->SetOrientation(me->GetAngle(player));
                        me->SetFacingToObject(player);
                        _events.ScheduleEvent(EVENT_SUMMON_WATER_SPOUT, 2000);
                    }
                    else
                        _events.ScheduleEvent(EVENT_CHANGE_PLACE, 5000);
                }
            }

            Creature* getWaterSpout()
            {
                return me->GetMap()->GetCreature(waterSpoutGUID);
            }

            void UpdateAI(uint32 diff) override
            {
                _events.Update(diff);

                switch (_events.ExecuteEvent())
                {
                    case EVENT_CHANGE_PLACE:
                    {
                        uint8 newPlace = 0;

                        do
                        {
                            newPlace = urand(0, 3);
                        }
                        while (newPlace == actualPlace);

                        me->GetMotionMaster()->MoveJump(rocksPos[newPlace].GetPositionX(), rocksPos[newPlace].GetPositionY(), rocksPos[newPlace].GetPositionZ(), 10.0f, 10.0f, 1);
                        me->AddAura(SPELL_WATER_SPOUT_WARNING, me); // Just visual
                        actualPlace = newPlace;
                        break;
                    }
                    case EVENT_SUMMON_WATER_SPOUT:
                    {
                        float x = 0.0f, y = 0.0f;
                        GetPositionWithDistInOrientation(me, 5.0f, me->GetOrientation() + frand(-M_PI, M_PI), x, y);
                        waterSpoutGUID = 0;

                        if (Creature* waterSpout = me->SummonCreature(60488, x, y, 92.189629f))
                            waterSpoutGUID = waterSpout->GetGUID();

                        _events.ScheduleEvent(EVENT_WATER_SPOUT_VISUAL, 500);
                        _events.ScheduleEvent(EVENT_WATER_SPOUT_EJECT, 7500);
                        break;
                    }
                    case EVENT_WATER_SPOUT_VISUAL:
                    {
                        if (Creature* waterSpout = getWaterSpout())
                            waterSpout->CastSpell(waterSpout, SPELL_WATER_SPOUT_WARNING, true);
                        break;
                    }
                    case EVENT_WATER_SPOUT_EJECT:
                    {
                        if (Creature* waterSpout = getWaterSpout())
                        {
                            std::list<Player*> playerList;
                            GetPlayerListInGrid(playerList, waterSpout, 1.0f);

                            for (auto&& player: playerList)
                                player->CastSpell(player, SPELL_WATER_SPOUT_EJECT, true);

                            waterSpout->CastSpell(waterSpout, SPELL_WATER_SPOUT_VISUAL, true);
                        }
                        _events.ScheduleEvent(EVENT_WATER_SPOUT_DESPAWN, 3000);
                        break;
                    }
                    case EVENT_WATER_SPOUT_DESPAWN:
                    {
                        if (Creature* waterSpout = getWaterSpout())
                            waterSpout->DespawnOrUnsummon();

                        waterSpoutGUID = 0;

                        _events.ScheduleEvent(EVENT_CHANGE_PLACE, 2000);
                        break;
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_shu_water_spiritAI(creature);
        }
};
} // namespace wandering_isle_east

namespace wandering_isle_north
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Pandaria/WanderingIsland/zone_wandering_island_north.cpp

// ===== npc_trainee_nim
class npc_trainee_nim : public CreatureScript
{
    public:
        npc_trainee_nim() : CreatureScript("npc_trainee_nim") { }

        struct npc_trainee_nimAI : public ScriptedAI
        {
            npc_trainee_nimAI(Creature* creature) : ScriptedAI(creature) { }
            std::set<uint64> guids;

            void MoveInLineOfSight(Unit* who) override
            {
                Player * const player = who->ToPlayer();
                if (!player)
                    return;

                if (player->GetQuestStatus(29409) != QUEST_STATUS_INCOMPLETE)
                    return;

                if (who->GetDistance(me) < 20.f)
                {
                    if (guids.find(player->GetGUID()) == guids.end())
                    {
                        Talk(0, player);
                        guids.insert(player->GetGUID());
                    }
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_trainee_nimAI(creature);
        }
};
} // namespace wandering_isle_north

namespace wandering_isle_west
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Pandaria/WanderingIsland/zone_wandering_island_west.cpp

// ===== mob_aisa_pre_balon_event
class mob_aisa_pre_balon_event : public CreatureScript
{
public:
    mob_aisa_pre_balon_event() : CreatureScript("mob_aisa_pre_balon_event") { }

    bool OnQuestAccept(Player* player, Creature* creature, Quest const* quest) override
    {
        if (quest->GetQuestId() == 29791)
            sCreatureTextMgr->SendChat(creature, 1);

        creature->CastSpell(player, 95247, true);
        player->CastSpell(player, 95247, true);
        return true;
    }

    struct mob_aisa_pre_balon_eventAI : public ScriptedAI
    {
        mob_aisa_pre_balon_eventAI(Creature* creature) : ScriptedAI(creature) { }

        bool justSpeaking;
        EventMap _events;
        GuidSet m_player_for_event;

        enum events
        {
            EVENT_1 = 1,
            EVENT_2 = 2,
            EVENT_3 = 3,

            NPC_FRIEND = 56663,
        };

        void Reset() override
        {
            justSpeaking = false;
        }

        void MoveInLineOfSight(Unit* who) override
        {
            if (justSpeaking || who->GetTypeId() != TypeID::TYPEID_PLAYER || who->IsOnVehicle())
                return;

            GuidSet::iterator itr = m_player_for_event.find(who->GetGUID());

            if (itr != m_player_for_event.end())
                return;

            if (who->ToPlayer()->GetQuestStatus(29790) != QUEST_STATUS_COMPLETE)
                return;

            m_player_for_event.insert(who->GetGUID());
            justSpeaking = true;
            _events.ScheduleEvent(EVENT_1, 10000);
            sCreatureTextMgr->SendChat(me, 0);
            
        }

        void UpdateAI(uint32 diff) override
        {
            _events.Update(diff);

            while (uint32 eventId = _events.ExecuteEvent())
            {
                switch (eventId)
                {
                    case EVENT_1:
                    {
                        _events.ScheduleEvent(EVENT_2, 8000);

                        if (Creature* f = me->FindNearestCreature(NPC_FRIEND, 100.0f, true))
                        {
                            sCreatureTextMgr->SendChat(f, 0);
                            f->SetFacingToObject(me);
                        }
                        break;
                    }
                    case EVENT_2:
                        sCreatureTextMgr->SendChat(me, 2);
                        justSpeaking = false;
                        break;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new mob_aisa_pre_balon_eventAI(creature);
    }
};

// ===== npc_master_shang_xi_thousand_staff_escort
// Passing Wisdom (29790)
class npc_master_shang_xi_thousand_staff_escort : public CreatureScript
{
    public:
        npc_master_shang_xi_thousand_staff_escort() : CreatureScript("npc_master_shang_xi_thousand_staff_escort") { }

        struct npc_master_shang_xi_thousand_staff_escortAI : public ScriptedAI
        {
            npc_master_shang_xi_thousand_staff_escortAI(Creature* creature) : ScriptedAI(creature) { }

            uint32 IntroTimer;
            uint8 phase;

            uint64 playerGuid;

            void Reset() override
            {
                phase = 0;
                IntroTimer = 250;
                me->SetReactState(REACT_PASSIVE);
            }

            void SetGUID(uint64 guid, int32 /*type*/) override
            {
                playerGuid = guid;
            }

            void UpdateAI(uint32 diff) override
            {
                if (IntroTimer < diff)
                {
                    if (phase < 6)
                        Talk(phase, ObjectAccessor::GetPlayer(*me, playerGuid));

                    IntroTimer = 15000;
                    ++phase;

                    if (phase == 7)
                    {
                        // LoA makes this summon visible to the escorting player only (SetExplicitSeerGuid); SkyFire has no per-player seer
                        me->SummonCreature(57874, 873.09f, 4462.25f, 241.27f, 3.80f, TempSummonType::TEMPSUMMON_TIMED_DESPAWN, 60000);

                        me->DespawnOrUnsummon();

                        if (Player* owner = ObjectAccessor::GetPlayer(*me, playerGuid))
                            owner->KilledMonsterCredit(56688);
                    }
                }
                else IntroTimer -= diff;
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_master_shang_xi_thousand_staff_escortAI(creature);
        }
};
} // namespace wandering_isle_west

} // namespace

void AddSC_npcs_ported()
{
    new creature_script<specials::npc_abominated_greench>("npc_abominated_greench");
    new creature_script<specials::npc_soul_mirror_artifact>("npc_soul_mirror_artifact");
    new specials::npc_steam_powered_auctioneer();
    new creature_script<specials::npc_vision_of_the_naaru_stalker>("npc_vision_of_the_naaru_stalker");
    new creature_script<specials::npc_visual_sparring>("npc_visual_sparring");
    new tarecgosa::npc_anachronos_15192();
    new tarecgosa::npc_blue_dragon_53394();
    new tarecgosa::npc_tarecgosa_53396();
    new fangs_of_the_father::npc_mostrasz_56314();
    new wandering_isle_east::npc_shu_water_spirit();
    new wandering_isle_north::npc_trainee_nim();
    new wandering_isle_west::mob_aisa_pre_balon_event();
    new wandering_isle_west::npc_master_shang_xi_thousand_staff_escort();
}
