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
 * Ported to Project SkyFire from Legends-of-Azeroth-Pandaria-5.4.8 (src/server/scripts/Northrend and World/argent_tournament.cpp), GPL v2 or later.
 * Not taken: npc_grauf (drives LoA's Skadi through actions our boss_skadi lacks), the Hadronox adds (LoA's Azjol-Nerub
 * instance data), npc_anstart (LoA's ToC intro, bound to a generic invisible stalker with spawns all over the world).
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

namespace
{
namespace pit_of_saron
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Northrend/FrozenHalls/PitOfSaron/pit_of_saron.cpp
enum Spells
{
    SPELL_BLIGHT_BOMB           = 69582,
    SPELL_PUSTULANT_FLESH       = 69581,
    SPELL_TOXIC_WASTE           = 70274,
};
enum eEvents
{
    EVENT_BLIGHT_BOMB           = 8,
    EVENT_PUSTULANT_FLESH       = 9,
    EVENT_TOXIC_WASTE           = 10,
};

// ===== npc_plagueborn_horror
class npc_plagueborn_horror : public CreatureScript
{
    public:
        npc_plagueborn_horror() : CreatureScript("npc_plagueborn_horror") { }

        struct npc_plagueborn_horrorAI: public ScriptedAI
        {
            npc_plagueborn_horrorAI(Creature* creature) : ScriptedAI(creature) { }

            EventMap events;

            void Reset() override
            {
                events.Reset();
            }

            void EnterCombat(Unit* /*who*/) override
            {
                events.ScheduleEvent(EVENT_BLIGHT_BOMB, 5000);
                events.ScheduleEvent(EVENT_PUSTULANT_FLESH, urand(1000, 5000));
                events.ScheduleEvent(EVENT_TOXIC_WASTE, 100);
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
                    me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_INTERRUPT, false);
                    me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, false);

                    switch (eventId)
                    {
                        case EVENT_BLIGHT_BOMB:
                            me->ApplySpellImmune(0, IMMUNITY_MECHANIC, MECHANIC_INTERRUPT, true);
                            me->ApplySpellImmune(0, IMMUNITY_EFFECT, SPELL_EFFECT_INTERRUPT_CAST, true);

                            if (HealthBelowPct(15))
                            {
                                DoCast(me, SPELL_BLIGHT_BOMB);
                                events.CancelEvent(EVENT_BLIGHT_BOMB);
                            }
                            else
                                events.RescheduleEvent(EVENT_BLIGHT_BOMB, 1000);
                            break;
                        case EVENT_PUSTULANT_FLESH:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_PUSTULANT_FLESH);
                            events.RescheduleEvent(EVENT_PUSTULANT_FLESH, urand(5000, 10000));
                            break;
                        case EVENT_TOXIC_WASTE:
                            if (Unit* target = SelectTarget(SELECT_TARGET_RANDOM, 0))
                                DoCast(target, SPELL_TOXIC_WASTE);
                            events.RescheduleEvent(EVENT_TOXIC_WASTE, urand(5000, 10000));
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_plagueborn_horrorAI(creature);
        }
};
} // namespace pit_of_saron

namespace halls_of_reflection
{
// From LoA's halls_of_reflection.h
uint32 const NPC_QUELDELAR = 37158;
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Northrend/FrozenHalls/HallsOfReflection/halls_of_reflection.cpp
enum TrashSpells
{
    SPELL_QUELDELAR_AURA                          = 70013,
};

// ===== npc_queldelar
class npc_queldelar : public CreatureScript
{
    public:
        npc_queldelar() : CreatureScript("npc_queldelar") { }

        struct npc_queldelarAI  : public ScriptedAI
        {
            npc_queldelarAI(Creature* creature) : ScriptedAI(creature) { }

            void MoveInLineOfSight(Unit* who) override
            {
                if (!who)
                    return;

                if (me->IsWithinDistInMap(who, 20) && who->HasAura(SPELL_QUELDELAR_AURA))
                {
                    me->SummonCreature(NPC_QUELDELAR, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation(), TempSummonType::TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 60000);
                    me->DisappearAndDie();
                }
            }
        };

        CreatureAI* GetAI(Creature* creature) const override
        {
            return new npc_queldelarAI(creature);
        }
};
} // namespace halls_of_reflection

namespace dalaran
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/Northrend/zone_dalaran.cpp
enum ArchmageLandalockQuests
{
    QUEST_SARTHARION_MUST_DIE               = 24579,
    QUEST_ANUBREKHAN_MUST_DIE               = 24580,
    QUEST_NOTH_THE_PLAGUEBINGER_MUST_DIE    = 24581,
    QUEST_INSTRUCTOR_RAZUVIOUS_MUST_DIE     = 24582,
    QUEST_PATCHWERK_MUST_DIE                = 24583,
    QUEST_MALYGOS_MUST_DIE                  = 24584,
    QUEST_FLAME_LEVIATHAN_MUST_DIE          = 24585,
    QUEST_RAZORSCALE_MUST_DIE               = 24586,
    QUEST_IGNIS_THE_FURNACE_MASTER_MUST_DIE = 24587,
    QUEST_XT_002_DECONSTRUCTOR_MUST_DIE     = 24588,
    QUEST_LORD_JARAXXUS_MUST_DIE            = 24589,
    QUEST_LORD_MARROWGAR_MUST_DIE           = 24590
};
enum ArchmageLandalockImages
{
    NPC_SARTHARION_IMAGE                    = 37849,
    NPC_ANUBREKHAN_IMAGE                    = 37850,
    NPC_NOTH_THE_PLAGUEBINGER_IMAGE         = 37851,
    NPC_INSTRUCTOR_RAZUVIOUS_IMAGE          = 37853,
    NPC_PATCHWERK_IMAGE                     = 37854,
    NPC_MALYGOS_IMAGE                       = 37855,
    NPC_FLAME_LEVIATHAN_IMAGE               = 37856,
    NPC_RAZORSCALE_IMAGE                    = 37858,
    NPC_IGNIS_THE_FURNACE_MASTER_IMAGE      = 37859,
    NPC_XT_002_DECONSTRUCTOR_IMAGE          = 37861,
    NPC_LORD_JARAXXUS_IMAGE                 = 37862,
    NPC_LORD_MARROWGAR_IMAGE                = 37864
};

// ===== npc_archmage_landalock
struct npc_archmage_landalock : public ScriptedAI
{
    npc_archmage_landalock(Creature* creature) : ScriptedAI(creature)
    {
        _switchImageTimer = MINUTE * IN_MILLISECONDS;
        _summonGUID = 0;
    }

    uint32 GetImageEntry(uint32 QuestId)
    {
        switch (QuestId)
        {
            case QUEST_SARTHARION_MUST_DIE:
                return NPC_SARTHARION_IMAGE;
            case QUEST_ANUBREKHAN_MUST_DIE:
                return NPC_ANUBREKHAN_IMAGE;
            case QUEST_NOTH_THE_PLAGUEBINGER_MUST_DIE:
                return NPC_NOTH_THE_PLAGUEBINGER_IMAGE;
            case QUEST_INSTRUCTOR_RAZUVIOUS_MUST_DIE:
                return NPC_INSTRUCTOR_RAZUVIOUS_IMAGE;
            case QUEST_PATCHWERK_MUST_DIE:
                return NPC_PATCHWERK_IMAGE;
            case QUEST_MALYGOS_MUST_DIE:
                return NPC_MALYGOS_IMAGE;
            case QUEST_FLAME_LEVIATHAN_MUST_DIE:
                return NPC_FLAME_LEVIATHAN_IMAGE;
            case QUEST_RAZORSCALE_MUST_DIE:
                return NPC_RAZORSCALE_IMAGE;
            case QUEST_IGNIS_THE_FURNACE_MASTER_MUST_DIE:
                return NPC_IGNIS_THE_FURNACE_MASTER_IMAGE;
            case QUEST_XT_002_DECONSTRUCTOR_MUST_DIE:
                return NPC_XT_002_DECONSTRUCTOR_IMAGE;
            case QUEST_LORD_JARAXXUS_MUST_DIE:
                return NPC_LORD_JARAXXUS_IMAGE;
            default: //case QUEST_LORD_MARROWGAR_MUST_DIE:
                return NPC_LORD_MARROWGAR_IMAGE;
        }
    }

    void JustSummoned(Creature* image) override
    {
        if (image->GetEntry() != NPC_ANUBREKHAN_IMAGE)
        {
            image->GetMotionMaster()->MoveRotate(20000, ROTATE_DIRECTION_RIGHT);
        }

        _summonGUID = image->GetGUID();
    }

    void UpdateAI(uint32 diff) override
    {
        ScriptedAI::UpdateAI(diff);

        _switchImageTimer += diff;

        if (_switchImageTimer > MINUTE*IN_MILLISECONDS)
        {
            _switchImageTimer = 0;
            QuestRelationBounds objectQR = sObjectMgr->GetCreatureQuestRelationBounds(me->GetEntry());

            for (QuestRelations::const_iterator itr = objectQR.first; itr != objectQR.second; ++itr)
            {
                uint32 questId = itr->second;
                Quest const* quest = sObjectMgr->GetQuestTemplate(questId);

                if (!quest || !quest->IsWeekly())
                    continue;

                uint32 newEntry = GetImageEntry(questId);

                if (GUID_ENPART(_summonGUID) != newEntry)
                {
                    if (Creature* image = ObjectAccessor::GetCreature(*me, _summonGUID))
                        image->DespawnOrUnsummon();

                    float z = 653.622f;

                    if (newEntry == NPC_MALYGOS_IMAGE || newEntry == NPC_RAZORSCALE_IMAGE || newEntry == NPC_SARTHARION_IMAGE)
                        z += 3.0f;

                    me->SummonCreature(newEntry, 5703.077f, 583.9757f, z, 3.926991f);
                }
            }
        }
    }

private:
    uint32 _switchImageTimer;
    uint64 _summonGUID;
};
} // namespace dalaran

namespace argent_tournament
{
// from Legends-of-Azeroth-Pandaria-5.4.8-master/src/server/scripts/World/argent_tournament.cpp
enum
{
    SPELL_SHIELD_BREAKER_2              = 66480,
    SPELL_CHARGE                        = 62960,
    SPELL_THRUST                        = 62544,
    SPELL_DEFEND                        = 62552,
    SPELL_RIDE_VEHICLE                  = 63151,
    SPELL_PLAYER_ON_TOURNAMENT_MOUNT    = 63034,
    SPELL_LANCE_EQUIPPED                = 62853,
    SPELL_YELLOW_ROSE_FIREWORK          = 11544,
    SAY_FACTION_VALIANT_START           = 0,
    SAY_FACTION_VALIANT_WIN             = 1,
    SAY_FACTION_VALIANT_LOSE            = 2,
    SAY_FACTION_CHAMPION_START          = 0,
    SAY_FACTION_CHAMPION_WIN            = 1,
    SAY_FACTION_CHAMPION_LOSE           = 2,
    TIMER_SPELL_MIN                     = 1000,
    TIMER_SPELL_MAX                     = 2500,
    TIMER_MOVEMENT_MIN                  = 1000,
    TIMER_MOVEMENT_MAX                  = 2500,
    TIMER_SPELL_MIN_2                   = 1000,
    TIMER_SPELL_MAX_2                   = 2000,
    TIMER_MOVEMENT_MIN_2                = 1000,
    TIMER_MOVEMENT_MAX_2                = 2000,
    POINT_INTRO                         = 1001,
    GOSSIP_VALIANT_ITEM_MENU_ID         = 0,
    GOSSIP_VALIANT_GOSSIP_TEXT_1        = 14384,
    GOSSIP_VALIANT_GOSSIP_TEXT_2        = 14489,
    GOSSIP_CHAMP_ITEM_MENU_ID           = 0,
    GOSSIP_CHAMP_GOSSIP_TEXT_1          = 14421,
    GOSSIP_CHAMP_GOSSIP_TEXT_2          = 14489,
};

// ===== CanEngageInMountedCombat
bool CanEngageInMountedCombat(Unit const* who)
{
    return who->HasAura(SPELL_RIDE_VEHICLE) && who->HasAura(SPELL_PLAYER_ON_TOURNAMENT_MOUNT) && who->HasAura(SPELL_LANCE_EQUIPPED) && !who->IsInCombat();
}

// ===== GetBestedIdFor
uint32 GetBestedIdFor(bool champion, Creature* me)
{
    static const struct
    {
        uint32 ValiantID;
        uint32 ChampionID;
        uint32 BestedSpellID;
    } RingBestedDebuffs[] =
    {
        { 33559, 33738, 64805 }, // Darnassus Valiant       / Darnassus Champion        / Bested Darnassus
        { 33562, 33739, 64808 }, // Exodar Valiant          / Exodar Champion           / Bested the Exodar
        { 33558, 33740, 64809 }, // Gnomeregan Valiant      / Gnomeregan Champion       / Bested Gnomeregan
        { 33564, 33743, 64810 }, // Ironforge Valiant       / Ironforge Champion        / Bested Ironforge
        { 33306, 33744, 64811 }, // Orgrimmar Valiant       / Orgrimmar Champion        / Bested Orgrimmar
        { 33285, 33745, 64812 }, // Sen'jin Valiant         / Sen'jin Champion          / Bested Sen'jin
        { 33382, 33746, 64813 }, // Silvermoon Valiant      / Silvermoon Champion       / Bested Silvermoon City
        { 33561, 33747, 64814 }, // Stormwind Valiant       / Stormwind Champion        / Bested Stormwind
        { 33383, 33748, 64815 }, // Thunder Bluff Valiant   / Thunder Bluff Champion    / Bested Thunder Bluff
        { 33384, 33749, 64816 }, // Undercity Valiant       / Undercity Champion        / Bested the Undercity
    };

    for (auto const& debuff : RingBestedDebuffs)
        if ((champion ? debuff.ChampionID : debuff.ValiantID) == me->GetEntry())
            return debuff.BestedSpellID;

    return 0;
}

// ===== npc_ring_rider_base
struct npc_ring_rider_base : ScriptedAI
{
    npc_ring_rider_base(Creature* c) : ScriptedAI(c) {}

    uint32 spellTimer, movementTimer;
    uint32 spellTimerMin, spellTimerMax;
    uint32 movementTimerMin, movementTimerMax;
    Position center;

    void Reset() override
    {
        me->setFaction(35);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
    }

    bool CanAIAttack(Unit const* target) const override
    {
        if (target->GetTypeId() == TypeID::TYPEID_UNIT)
            if (Vehicle* vehicle = target->GetVehicleKit())
                if (Unit* passenger = vehicle->GetPassenger(0))
                    return passenger->GetTypeId() == TypeID::TYPEID_PLAYER;

        return false;
    }

    void AttackStart(Unit* victim) override
    {
        if (Unit* vehicle = victim->GetVehicleBase())
            victim = vehicle;
        ScriptedAI::AttackStart(victim);
    }

    void DoEvade()
    {
        me->setFaction(35);
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
        EnterEvadeMode();
    }

    Position FindDestinationInCircle(Position const* from, float maxDist, float radius)
    {
        Position dest = { from->GetPositionX() + maxDist * ((float)rand_norm() * 2.0f - 1.0f), from->GetPositionY() + maxDist * ((float)rand_norm() * 2.0f - 1.0f), from->GetPositionZ() };
        if (center.GetExactDist(&dest) > radius)
        {
            float angle = dest.GetAngle(&center);
            Position offset = { maxDist * cos(angle), maxDist * sin(angle) };
            dest.RelocateOffset(offset);
        }
        return dest;
    }

    void UpdateAI(const uint32 uiDiff) override
    {
        if (!UpdateVictim())
            return;

        Unit* target = me->GetVictim();
        if (!target)
            return;

        if (target->GetTypeId() == TypeID::TYPEID_PLAYER)
            target = target->GetVehicleBase();

        if (!target)
            return;

        if (spellTimer <= uiDiff)
        {
            if (me->IsInRange(target, 5, 40, false))
            {
                switch (urand(0, 2))
                {
                    case 0:
                        DoCast(target, SPELL_SHIELD_BREAKER_2, true);
                        break;
                    case 1:
                        DoCast(target, SPELL_CHARGE, true);
                        break;
                    case 2:
                        me->CastSpell(me, SPELL_DEFEND, true);
                        break;
                }
            }
            else
            {
                switch (urand(0, 3))
                {
                    case 0:
                        me->CastSpell(me, SPELL_DEFEND, true);
                        break;
                    case 1: case 2: case 3:
                        DoCast(target, SPELL_THRUST, true);
                        break;
                }
            }
            spellTimer = urand(spellTimerMin, spellTimerMax);
        }
        else
            spellTimer -= uiDiff;

        if (movementTimer <= uiDiff)
        {
            me->GetMotionMaster()->MovePoint(0, FindDestinationInCircle(me, 10.0f, 30.0f));
            movementTimer = urand(movementTimerMin, movementTimerMax);
        }
        else
            movementTimer -= uiDiff;
    }
};

// ===== npc_ring_champions
class npc_ring_champions : public CreatureScript
{
public:
    npc_ring_champions() : CreatureScript("npc_ring_champions") { }

    bool OnGossipHello(Player* player, Creature* creature) override
    {
        if ((player->GetQuestStatus(13790) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(13793) == QUEST_STATUS_INCOMPLETE ||
            player->GetQuestStatus(13811) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(13814) == QUEST_STATUS_INCOMPLETE) &&
            !(player->HasAura(62665) || player->HasAura(GetBestedIdFor(true, creature))) && CanEngageInMountedCombat(player))
        {
            player->ADD_GOSSIP_ITEM_DB(player->GetDefaultGossipMenuForSource(creature), GOSSIP_CHAMP_ITEM_MENU_ID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }
        if (player->HasAura(GetBestedIdFor(true, creature)))
        {
            player->SEND_GOSSIP_MENU(GOSSIP_CHAMP_GOSSIP_TEXT_2, creature->GetGUID());
            return true;
        }

        player->SEND_GOSSIP_MENU(GOSSIP_CHAMP_GOSSIP_TEXT_1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        player->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            player->CLOSE_GOSSIP_MENU();
            creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
            creature->SetWalk(false);
            if (creature->GetHomePosition().GetPositionY() < 950.35f)
                creature->GetMotionMaster()->MovePoint(POINT_INTRO, 8432.1f, 921.514282f, 544.787842f);
            else
                creature->GetMotionMaster()->MovePoint(POINT_INTRO, 8432.1f, 975.514282f, 544.787842f);
        }
        return true;
    }

    struct npc_ring_championsAI : public npc_ring_rider_base
    {
        npc_ring_championsAI(Creature* creature) : npc_ring_rider_base(creature)
        {
            spellTimerMin = TIMER_SPELL_MIN_2;
            spellTimerMax = TIMER_SPELL_MAX_2;
            movementTimerMin = TIMER_MOVEMENT_MIN_2;
            movementTimerMax = TIMER_MOVEMENT_MAX_2;
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != POINT_INTRO)
                return;
            me->setFaction(14);
            center.Relocate(*me);
            me->CastSpell(me, SPELL_DEFEND, true);
            me->CastSpell(me, SPELL_DEFEND, true);
            me->CastSpell(me, SPELL_DEFEND, true);
        }

        void DamageTaken(Unit* attacker, uint32& damage) override
        {
            if (attacker && damage > me->GetHealth())
            {
                if (Player* player = attacker->GetAffectingPlayer())
                {
                    damage = 0;

                    player->CastSpell(player, 63596, true); // Reward mark

                    if (uint32 debuff = GetBestedIdFor(true, me))
                        player->CastSpell(player, debuff, true);

                    Talk(SAY_FACTION_CHAMPION_LOSE, player);
                    DoEvade();
                }
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (Player* player = victim->GetCharmerOrOwnerPlayerOrPlayerItself())
                Talk(SAY_FACTION_CHAMPION_WIN, player);

            me->CastSpell(me, SPELL_YELLOW_ROSE_FIREWORK, true);
            me->CombatStop(true);
            DoEvade();
        }

        void EnterCombat(Unit* who) override
        {
            if (Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself())
                Talk(SAY_FACTION_CHAMPION_START, player);
            spellTimer = urand(TIMER_SPELL_MIN_2, TIMER_SPELL_MAX_2);
            movementTimer = urand(TIMER_MOVEMENT_MIN_2, TIMER_MOVEMENT_MAX_2);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ring_championsAI(creature);
    }
};

// ===== npc_ring_valiants
class npc_ring_valiants : public CreatureScript
{
public:
    npc_ring_valiants() : CreatureScript("npc_ring_valiants") { }

    bool OnGossipHello(Player* pPlayer, Creature* creature) override
    {
        if (((pPlayer->GetQuestStatus(13665) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(13745) == QUEST_STATUS_INCOMPLETE ||
            pPlayer->GetQuestStatus(13761) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(13767) == QUEST_STATUS_INCOMPLETE ||
            pPlayer->GetQuestStatus(13772) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(13777) == QUEST_STATUS_INCOMPLETE ||
            pPlayer->GetQuestStatus(13782) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(13787) == QUEST_STATUS_INCOMPLETE ||
            pPlayer->GetQuestStatus(13750) == QUEST_STATUS_INCOMPLETE || pPlayer->GetQuestStatus(13756) == QUEST_STATUS_INCOMPLETE)
            || (((pPlayer->GetQuestStatus(13814) == QUEST_STATUS_INCOMPLETE) || (pPlayer->GetQuestStatus(13811) == QUEST_STATUS_INCOMPLETE) || (pPlayer->GetQuestStatus(13793) == QUEST_STATUS_INCOMPLETE) || (pPlayer->GetQuestStatus(13790) == QUEST_STATUS_INCOMPLETE)) && !(pPlayer->HasAchieved(2836)))) &&
            !(pPlayer->HasAura(62665) || pPlayer->HasAura(GetBestedIdFor(false, creature))) && CanEngageInMountedCombat(pPlayer))
        {
            pPlayer->ADD_GOSSIP_ITEM_DB(pPlayer->GetDefaultGossipMenuForSource(creature), GOSSIP_VALIANT_ITEM_MENU_ID, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
        }

        if (pPlayer->HasAura(GetBestedIdFor(false, creature)))
        {
            pPlayer->SEND_GOSSIP_MENU(GOSSIP_VALIANT_GOSSIP_TEXT_2, creature->GetGUID());
            return true;
        }

        pPlayer->SEND_GOSSIP_MENU(GOSSIP_VALIANT_GOSSIP_TEXT_1, creature->GetGUID());
        return true;
    }

    bool OnGossipSelect(Player* pPlayer, Creature* creature, uint32 /*sender*/, uint32 action) override
    {
        pPlayer->PlayerTalkClass->ClearMenus();
        if (action == GOSSIP_ACTION_INFO_DEF + 1)
        {
            pPlayer->CLOSE_GOSSIP_MENU();
            creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_IMMUNE_TO_PC);
            creature->SetWalk(false);
            if (creature->GetHomePosition().GetPositionX() > 8500.0f)
                creature->GetMotionMaster()->MovePoint(POINT_INTRO, 8658.1f, 719.514282f, 547.787842f);
            else
                creature->GetMotionMaster()->MovePoint(POINT_INTRO, 8338.1f, 719.514282f, 553.787842f);
        }
        return true;
    }

    struct npc_ring_valiantsAI : public npc_ring_rider_base
    {
        npc_ring_valiantsAI(Creature* pCreature) : npc_ring_rider_base(pCreature)
        {
            spellTimerMin = TIMER_SPELL_MIN;
            spellTimerMax = TIMER_SPELL_MAX;
            movementTimerMin = TIMER_MOVEMENT_MIN;
            movementTimerMax = TIMER_MOVEMENT_MAX;
        }

        void MovementInform(uint32 type, uint32 id) override
        {
            if (type != POINT_MOTION_TYPE || id != POINT_INTRO)
                return;
            me->setFaction(14);
            center.Relocate(*me);
        }

        void DamageTaken(Unit* attacker, uint32& damage) override
        {
            if (attacker && damage > me->GetHealth())
            {
                if (Player* player = attacker->GetAffectingPlayer())
                {
                    damage = 0;

                    player->CastSpell(player, 62724, true); // Reward mark

                    if (uint32 debuff = GetBestedIdFor(false, me))
                        player->CastSpell(player, debuff, true);

                    Talk(SAY_FACTION_VALIANT_LOSE, player);
                    DoEvade();
                }
            }
        }

        void KilledUnit(Unit* victim) override
        {
            if (Player* player = victim->GetCharmerOrOwnerPlayerOrPlayerItself())
                Talk(SAY_FACTION_VALIANT_WIN, player);

            me->CombatStop(true);
            me->CastSpell(me, SPELL_YELLOW_ROSE_FIREWORK, true);
            DoEvade();
        }

        void EnterCombat(Unit* who) override
        {
            if (Player* player = who->GetCharmerOrOwnerPlayerOrPlayerItself())
                Talk(SAY_FACTION_VALIANT_START, player);
            spellTimer = urand(TIMER_SPELL_MIN, TIMER_SPELL_MAX);
            movementTimer = urand(TIMER_MOVEMENT_MIN, TIMER_MOVEMENT_MAX);
            me->CastSpell(me, SPELL_DEFEND, true);
            me->CastSpell(me, SPELL_DEFEND, true);
        }
    };

    CreatureAI* GetAI(Creature* creature) const override
    {
        return new npc_ring_valiantsAI(creature);
    }
};
} // namespace argent_tournament

} // namespace

void AddSC_northrend_ported()
{
    new pit_of_saron::npc_plagueborn_horror();
    new halls_of_reflection::npc_queldelar();
    new creature_script<dalaran::npc_archmage_landalock>("npc_archmage_landalock");
    new argent_tournament::npc_ring_champions();
    new argent_tournament::npc_ring_valiants();
}
