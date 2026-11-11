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
 * (src/server/scripts/Spells/spell_item.cpp, GPL v2 or later).
 * Mechanical API changes by skyfire_port_plan/tools/loa2sf.ps1, the rest by hand.
 */


/*
 * MoP 5.4 item, trinket and profession spell scripts (PLAN.md P3).
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
#include "SkillDiscovery.h"
#include "Battleground.h"
#include "Chat.h"
#include "CreatureTextMgr.h"
#include "Creature.h"

namespace
{

// SkyFire helpers for LoA APIs this file uses
uint32 GetPlayerSpec(Player const* player)
{
    return player->GetTalentSpecialization(player->GetActiveSpec());
}

enum LoaRoles
{
    ROLES_DPS    = 0,
    ROLES_TANK   = 1,
    ROLES_HEALER = 2,
};

uint32 GetSpecRole(uint32 spec)
{
    switch (spec)
    {
        case 66: case 73: case 104: case 250: case 268:                 // Prot Paladin/Warrior, Guardian, Blood, Brewmaster
            return ROLES_TANK;
        case 65: case 105: case 256: case 257: case 264: case 270:      // Holy Paladin, Resto Druid, Disc/Holy, Resto Shaman, Mistweaver
            return ROLES_HEALER;
        default:
            return ROLES_DPS;
    }
}

uint32 ProcDamage(ProcEventInfo const& eventInfo)
{
    return eventInfo.GetDamageInfo() ? eventInfo.GetDamageInfo()->GetDamage() : 0;
}

uint32 ProcHeal(ProcEventInfo const& eventInfo)
{
    return eventInfo.GetHealInfo() ? eventInfo.GetHealInfo()->GetHeal() : 0;
}

// From LoA scripts/Spells/spell_common.h
class spell_smart_heal : public SpellScript
{
protected:
    void ApplySmartHeal(std::list<WorldObject*>& targets, uint32 count, bool ignoreLos = false)
    {
        Position pos = GetCaster()->GetPosition();
        if (GetSpell()->m_targets.HasDst())
            pos = GetSpell()->m_targets.GetDst()->_position;
        Unit* caster = GetOriginalCaster();
        if (!caster)
            caster = GetCaster();
        if (GetSpellInfo()->AttributesEx2 & SPELL_ATTR2_CAN_TARGET_NOT_IN_LOS)
            ignoreLos = true;
        Spell::ApplySmartHeal(caster, targets, count, ignoreLos, &pos);
    }
};

class spell_item_stay_of_execution : public SpellScriptLoader
{
    public:
        spell_item_stay_of_execution() : SpellScriptLoader("spell_item_stay_of_execution") { }

        class spell_item_stay_of_execution_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_stay_of_execution_AuraScript);

            uint32 absorbPct, healPct;

            bool Load() override
            {
                withdrawn = 0;
                return GetUnitOwner()->GetTypeId() == TypeID::TYPEID_PLAYER;
            }

            void Absorb(AuraEffect* /*aurEff*/, DamageInfo & dmgInfo, uint32 & absorbAmount)
            {
                absorbAmount = CalculatePct(dmgInfo.GetDamage(), 20);
                withdrawn += absorbAmount;
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster())
                    return;

                int32 bp0 = int32(0.08f * withdrawn);
                GetCaster()->CastCustomSpell(GetCaster(), 96993, &bp0, 0, 0, true);
            }

            void Register() override
            {
                OnEffectAbsorb += AuraEffectAbsorbFn(spell_item_stay_of_execution_AuraScript::Absorb, EFFECT_0);
                OnEffectRemove += AuraEffectRemoveFn(spell_item_stay_of_execution_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB, AURA_EFFECT_HANDLE_REAL);
            }

        private:
            int32 withdrawn;
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_item_stay_of_execution_AuraScript();
        }
};

class spell_item_flameseers_staff_flamebreaker : public SpellScriptLoader
{
    public:
        spell_item_flameseers_staff_flamebreaker() : SpellScriptLoader("spell_item_flameseers_staff_flamebreaker") { }

        class spell_item_flameseers_staff_flamebreaker_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_item_flameseers_staff_flamebreaker_AuraScript);

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (!GetCaster() || !GetTarget())
                    return;

                if (GetTarget()->GetEntry() == 38896)
                {
                    GetCaster()->CastSpell(GetTarget(), 74723, true);
                    GetTarget()->Kill(GetTarget());
                }
            }

            void Register() override
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_item_flameseers_staff_flamebreaker_AuraScript::OnRemove, EFFECT_1, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const override
        {
            return new spell_item_flameseers_staff_flamebreaker_AuraScript();
        }
};

enum WormholeGeneratorPandariaSpell
{
    SPELL_WORMHOLE_PANDARIA_ISLE_OF_RECKONING   = 126756,
    SPELL_WORMHOLE_PANDARIA_KUNLAI_UNDERWATER   = 126757,
    SPELL_WORMHOLE_PANDARIA_SRA_VESS            = 126758,
    SPELL_WORMHOLE_PANDARIA_RIKKITUN_VILLAGE    = 126759,
    SPELL_WORMHOLE_PANDARIA_ZANVESS_TREE        = 126760,
    SPELL_WORMHOLE_PANDARIA_ANGLERS_WHARF       = 126761,
    SPELL_WORMHOLE_PANDARIA_CRANE_STATUE        = 126762,
    SPELL_WORMHOLE_PANDARIA_EMPERORS_OMEN       = 126763,
    SPELL_WORMHOLE_PANDARIA_WHITEPETAL_LAKE     = 126764,
};

std::vector<uint32> const WormholeTargetLocations =
{
    SPELL_WORMHOLE_PANDARIA_ISLE_OF_RECKONING,
    SPELL_WORMHOLE_PANDARIA_KUNLAI_UNDERWATER,
    SPELL_WORMHOLE_PANDARIA_SRA_VESS,
    SPELL_WORMHOLE_PANDARIA_RIKKITUN_VILLAGE,
    SPELL_WORMHOLE_PANDARIA_ZANVESS_TREE,
    SPELL_WORMHOLE_PANDARIA_ANGLERS_WHARF,
    SPELL_WORMHOLE_PANDARIA_CRANE_STATUE,
    SPELL_WORMHOLE_PANDARIA_EMPERORS_OMEN,
    SPELL_WORMHOLE_PANDARIA_WHITEPETAL_LAKE
};

// 126755 - Wormhole: Pandaria
class spell_item_wormhole_pandaria : public SpellScript
{
    PrepareSpellScript(spell_item_wormhole_pandaria);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        for (uint32 spellId : WormholeTargetLocations)
            if (!sSpellMgr->GetSpellInfo(spellId))
                return false;
        return true;
    }

    void HandleTeleport(SpellEffIndex effIndex)
    {
        PreventHitDefaultEffect(effIndex);
        uint32 spellId = Skyfire::Containers::SelectRandomContainerElement(WormholeTargetLocations);
        GetCaster()->CastSpell(GetHitUnit(), spellId, true);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_wormhole_pandaria::HandleTeleport, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 129339 - Flip It
class spell_item_flippable_table : public SpellScript
{
    PrepareSpellScript(spell_item_flippable_table);

    void HandleCast()
    {
        // With Ghostcrawler on the table. I dunno how it must work. Just some funny stuff.
        uint32 spellId = roll_chance_i(5) ? 129338 : 128783;
        GetCaster()->CastSpell(GetCaster(), spellId, false);
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_item_flippable_table::HandleCast);
    }
};

enum Stardust2
{
    SPELL_STARDUST_NO_2               = 73667,
    QUEST_THE_LATEST_FASHION_ALLIANCE = 25157,
    QUEST_THE_LATEST_FASHION_HORDE    = 25159,
    NPC_THE_LATEST_FASHION_CREDIT     = 39237,
};

// 73667 - Stardust No. 2
class spell_item_stardust_no_2 : public AuraScript
{
    PrepareAuraScript(spell_item_stardust_no_2);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Player* player = GetCaster()->ToPlayer())
            if (player->GetQuestStatus(QUEST_THE_LATEST_FASHION_ALLIANCE) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(QUEST_THE_LATEST_FASHION_HORDE) == QUEST_STATUS_INCOMPLETE)
                player->KilledMonsterCredit(NPC_THE_LATEST_FASHION_CREDIT, 0);
    }

    void Register()
    {
        OnEffectApply += AuraEffectApplyFn(spell_item_stardust_no_2::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

enum JewelcraftingDailyQuestsCata
{
    QUEST_NIBBLER_NO_ALLIANCE              = 25105,
    QUEST_ORGEZONIANS_IN_THE_MOOD_ALLIANCE = 25155,
    QUEST_A_PRESENT_FOR_LILA_ALLIANCE      = 25154,
    QUEST_NIBBLER_NO_HORDE                 = 25158,
    QUEST_ORGEZONIANS_IN_THE_MOOD_HORDE    = 25161,
    QUEST_A_PRESENT_FOR_LILA_HORDE         = 25160,

    SPELL_SOLID_ZEPHYRITE                  = 73227,
    SPELL_JAGGED_JASPER                    = 73274,
    SPELL_TIMELESS_NIGHTSTONE              = 73243,

    NPC_NIBBLER_NO_CREDIT                  = 39221,
    NPC_ORGEZONIANS_IN_THE_MOOD_CREDIT     = 39223,
    NPC_A_PRESENT_FOR_LILA_CREDIT          = 39222,
};

struct QuestData
{
    QuestData(uint32 hordeQuest, uint32 allianceQuest, uint32 credit) : HordeQuest(hordeQuest), AllianceQuest(allianceQuest), Credit(credit) { }

    uint32 HordeQuest;
    uint32 AllianceQuest;
    uint32 Credit;
};

std::map<uint32, QuestData> spellToQuest =
{
    { SPELL_SOLID_ZEPHYRITE,     QuestData(QUEST_NIBBLER_NO_ALLIANCE,              QUEST_NIBBLER_NO_HORDE,              NPC_NIBBLER_NO_CREDIT             ) },
    { SPELL_JAGGED_JASPER,       QuestData(QUEST_ORGEZONIANS_IN_THE_MOOD_ALLIANCE, QUEST_ORGEZONIANS_IN_THE_MOOD_HORDE, NPC_ORGEZONIANS_IN_THE_MOOD_CREDIT) },
    { SPELL_TIMELESS_NIGHTSTONE, QuestData(QUEST_A_PRESENT_FOR_LILA_ALLIANCE,      QUEST_A_PRESENT_FOR_LILA_HORDE,      NPC_A_PRESENT_FOR_LILA_CREDIT     ) },
};

class spell_jewelcrafting_daily_quests_cata : public SpellScript
{
    PrepareSpellScript(spell_jewelcrafting_daily_quests_cata);

    void HandleCast()
    {
        auto itr = spellToQuest.find(GetSpell()->GetSpellInfo()->Id);
        if (itr != spellToQuest.end())
        {
            Player* player = GetCaster()->ToPlayer();
            if (player->GetQuestStatus(itr->second.AllianceQuest) == QUEST_STATUS_INCOMPLETE || player->GetQuestStatus(itr->second.HordeQuest) == QUEST_STATUS_INCOMPLETE)
                player->KilledMonsterCredit(itr->second.Credit);
        }
    }

    void Register()
    {
        AfterCast += SpellCastFn(spell_jewelcrafting_daily_quests_cata::HandleCast);
    }
};

// 105617 - Alchemist's Flask
class spell_item_alchemists_flask : public SpellScript
{
    PrepareSpellScript(spell_item_alchemists_flask);

    void HandleCast()
    {
        Unit* caster = GetCaster();
        std::vector<float> stats{ caster->GetStat(STAT_STRENGTH), caster->GetStat(STAT_AGILITY), 0, caster->GetStat(STAT_INTELLECT) };
        auto it = std::max_element(stats.begin(), stats.end());
        uint32 stat = std::distance(stats.begin(), it);
        uint32 spellId = 0;
        switch (stat)
        {
            case STAT_STRENGTH:  spellId = 79638; break;
            case STAT_AGILITY:   spellId = 79639; break;
            case STAT_INTELLECT: spellId = 79640; break;
            default:
                return;
        }
        caster->CastSpell(caster, spellId, true);
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_item_alchemists_flask::HandleCast);
    }
};

enum swarmKeepersSpell
{
    SPELL_SWARMKEEPERS_SPEED     = 128887,
    SPELL_SWARMKEEPERS_SPEED_EFF = 128882,
};

// Swarmkeeper`s Speed 128887
class spell_item_swarmkeepers_speed : public AuraScript
{
    PrepareAuraScript(spell_item_swarmkeepers_speed);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        // Need this cuz at unequip/equip - it doesn`t apply aura till area switch
        if (Player* player = GetOwner()->ToPlayer())
            player->CastSpell(player, SPELL_SWARMKEEPERS_SPEED_EFF, true);
    }

    void Register()
    {
        OnEffectApply += AuraEffectApplyFn(spell_item_swarmkeepers_speed::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// Arrival of the Naaru Cosmetic 94444
class spell_item_arrival_of_the_naaru : public AuraScript
{
    PrepareAuraScript(spell_item_arrival_of_the_naaru);

    void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Creature* caster = GetOwner()->ToCreature())
            caster->CastSpell(caster, 94443, true);
    }

    void Register()
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_item_arrival_of_the_naaru::OnRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// Possible not full, only wowhead quite
const std::vector<WorldLocation> errorTeleLocations =
{
    WorldLocation(1, -7419.403f, 1727.004f, -35.594471f, 6.109519f), // Hive`Zora
    WorldLocation(0, -10216.424f, 187.672f, 1.724689f, 3.872366f), // Duskwood Catacombs
    WorldLocation(0, -4520.678f, -3240.069f, 179.561417f, 3.669699f), // Shattered Dam
    WorldLocation(1, -266.556f, 2494.944f, 19.763773f, 0.634602f), // Slitherblade Shore
    WorldLocation(1, -7208.254f, -653.120f, -234.697678f, 3.376429f), // Golakka Hot Springs
    WorldLocation(0, -6895.936f, -3375.137f, 202.327179f, 4.656716f), // Tomb of the Watchers
    WorldLocation(0, 2956.488f, -1409.799f, 176.101440f, 4.268025f), // Mardenholde Keep
    WorldLocation(1, -6886.273f, -4839.866f, 6.127418f, 1.941495f), // Steamwheedle Port
    WorldLocation(0, -6628.200f, -3895.360f, 378.730011f, 5.073192f), // Fuselight by the Sea
    WorldLocation(530, -1050.882f, 3046.176f, 433.985565f, 5.531922f), // Floating Rock (Hellfire Peninsula)
    WorldLocation(1, -1630.870f, -4244.494f, 4.429177f, 2.357727f), // Fray Island
    WorldLocation(1, -8008.594f, -5286.748f, 0.575901f, 1.862948f), // Lost Rigger Cove
    WorldLocation(1, 6243.650f, -1202.918f, 370.821869f, 2.177830f), // Irontree Woods
    WorldLocation(1, 7958.594f, -2492.875f, 487.918427f, 3.233107f), // Nighthaven
    WorldLocation(0, 1252.864f, -2586.790f, 92.886726f, 0.455692f), // Scholomance
    WorldLocation(0, -14808.640f, -165.362f, 5.233351f, 1.882970f), // Jaguero Isle
    WorldLocation(1, -3750.070f, 1090.165f, 131.969452f, 6.259622f), // Broken Commons
    WorldLocation(1, -686.694f, -2240.777f, 17.159506f, 0.837993f), // Cavern of Mists
};

// Teleport with Error 82674
class spell_item_teleport_with_error : public SpellScript
{
    PrepareSpellScript(spell_item_teleport_with_error);

    void HandleAfterCast()
    {
        if (Player* caster = GetCaster()->ToPlayer())
            caster->TeleportTo(Skyfire::Containers::SelectRandomContainerElement(errorTeleLocations));
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_item_teleport_with_error::HandleAfterCast);
    }
};

// Taunt Flag Targeting 51640: not ported (needs spell corpse hit targets and LoA's LANG_TAUNT_FLAG text).

enum ChaliceMountainKingsMisc
{
    SPELL_SWORD_DANCE          = 94690, // summon invisible stalker
    SPELL_SUMMON_SWORD_DANCERS = 94691,
    NPC_SWORD_DANCER_A         = 51269,
    NPC_SWORD_DANCER_B         = 51270,
    NPC_SWORD_DANCER_C         = 51271,
    NPC_SWORD_DANCER_D         = 51272,
};

// Summon Sword Dancers 94691
class spell_item_summon_sword_dancers : public SpellScript
{
    PrepareSpellScript(spell_item_summon_sword_dancers);

    void HandleScriptEff(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetHitUnit())
        {
            faceOri = frand(0, 2 * M_PI);

            for (uint32 i = 0; i < 4; i++)
            {
                GetPositionWithDistInOrientation(caster, 3.5f, Position::NormalizeOrientation(faceOri + i * (M_PI / 2)), x, y);
                caster->SummonCreature(NPC_SWORD_DANCER_A + i, x, y, caster->GetPositionZ(), Position::NormalizeOrientation(faceOri + i * (M_PI / 2) - M_PI), TempSummonType::TEMPSUMMON_TIMED_DESPAWN, (18 * IN_MILLISECONDS));
            }
        }
    }

    private:
        float x, y, faceOri;

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_summon_sword_dancers::HandleScriptEff, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum SparkOfZandalar
{
    SPELL_PROC_AURA_SPARK_OF_ZANDALAR = 138957, // same for HC, LFR
    SPELL_SPARK_OF_ZANDALAR           = 138958, // accumulate to 10
    SPELL_SPARK_OF_ZANDALAR_TRANSFORM = 138960,
};

// 138957 - Item - Proc Charges For Strength Transform
class spell_item_spark_of_zandalari_proc_aura : public AuraScript
{
    PrepareAuraScript(spell_item_spark_of_zandalari_proc_aura);

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TypeID::TYPEID_PLAYER;
    }

    void HandleOnProc(ProcEventInfo& eventInfo)
    {
        if (!GetUnitOwner()->HasAura(SPELL_SPARK_OF_ZANDALAR_TRANSFORM))
        {
            Item* item = GetUnitOwner()->ToPlayer()->GetItemByGuid(GetAura()->GetCastItemGUID());
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SPARK_OF_ZANDALAR, true, item);
        }
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_item_spark_of_zandalari_proc_aura::HandleOnProc);
    }
};

// Spark of Zandalar 138958
class spell_item_spark_of_zandalari : public AuraScript
{
    PrepareAuraScript(spell_item_spark_of_zandalari);

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TypeID::TYPEID_PLAYER;
    }

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetStackAmount() > 9)
        {
            Item* item = GetUnitOwner()->ToPlayer()->GetItemByGuid(GetAura()->GetCastItemGUID());
            GetUnitOwner()->RemoveAurasDueToSpell(SPELL_SPARK_OF_ZANDALAR);
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_SPARK_OF_ZANDALAR_TRANSFORM, true, item);
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_item_spark_of_zandalari::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAPPLY);
    }
};

enum zuldazarRelicsSpell
{
    SPELL_PROC_AURA_RELIC_OF_ZULDAZAR = 138968, // same for HC, LFR
    SPELL_ZANDALARI_WARDING           = 138925,
    SPELL_BLESSING_OF_ZULDAZAR        = 138967,
};

// Relic of Zuldazar 138925
class spell_item_relic_of_zuldazar_shield : public AuraScript
{
    PrepareAuraScript(spell_item_relic_of_zuldazar_shield);

    void CalculateAmount(AuraEffect const* /*aurEff*/, int32& amount, bool& /*canBeRecalculated*/)
    {
        if (Unit* caster = GetCaster())
            if (Aura* zuldazar = caster->GetAura(SPELL_BLESSING_OF_ZULDAZAR))
                amount *= zuldazar->GetStackAmount();
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_relic_of_zuldazar_shield::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
    }
};

// Relic of Zuldazar 138925
class spell_item_relic_of_zuldazar : public SpellScript
{
    PrepareSpellScript(spell_item_relic_of_zuldazar);

    void HandleHitEff(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            caster->RemoveAurasDueToSpell(SPELL_BLESSING_OF_ZULDAZAR);
    }

    SpellCastResult CheckCast()
    {
        if (Unit* caster = GetCaster())
            if (caster->GetAura(SPELL_BLESSING_OF_ZULDAZAR) && caster->IsInCombat())
                return SpellCastResult::SPELL_CAST_OK;

        return SpellCastResult::SPELL_FAILED_SPELL_UNAVAILABLE;
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_relic_of_zuldazar::HandleHitEff, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
        OnCheckCast += SpellCheckCastFn(spell_item_relic_of_zuldazar::CheckCast);
    }
};

enum lightningChalicesSpell
{
    SPELL_PROC_AURA_LIGHTNING_CHALICE = 139190,
    SPELL_INFINITE_POWER              = 139189,
    SPELL_RESTORATION_OF_THE_INFINITE = 139195,
};

// Lightning Chalice Proc Aura 139190
class spell_item_lightning_chalice_proc_aura : public AuraScript
{
    PrepareAuraScript(spell_item_lightning_chalice_proc_aura);

    void HandleProc(ProcEventInfo& eventInfo)
    {
        if (Player* owner = GetOwner()->ToPlayer())
        {
            Item* item = owner->GetItemByGuid(GetAura()->GetCastItemGUID());
            owner->CastSpell(owner, SPELL_INFINITE_POWER, true, item);
        }
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_item_lightning_chalice_proc_aura::HandleProc);
    }
};

// Infinite Power 139189
class spell_infinite_power : public AuraScript
{
    PrepareAuraScript(spell_infinite_power);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetStackAmount() > 5)
        {
            if (Player* owner = GetOwner()->ToPlayer())
            {
                owner->RemoveAurasDueToSpell(SPELL_INFINITE_POWER);
                Item* item = owner->GetItemByGuid(GetAura()->GetCastItemGUID());
                owner->CastSpell(owner, SPELL_RESTORATION_OF_THE_INFINITE, true, item);
            }
        }
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_infinite_power::OnApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAPPLY);
    }
};

// Hardened Shell 129787
class spell_item_hardened_shell : public SpellScript
{
    PrepareSpellScript(spell_item_hardened_shell);

    void HandleHitEff(SpellEffIndex /*effIndex*/)
    {
        if (Unit* target = GetHitUnit())
            target->RemoveAurasByType(SPELL_AURA_MOUNTED);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_hardened_shell::HandleHitEff, EFFECT_0, SPELL_EFFECT_APPLY_AURA);
    }
};

// 138979 - Soul Barrier
class spell_item_soul_barrier : public AuraScript
{
    PrepareAuraScript(spell_item_soul_barrier);

    uint32 totalAbsorbed = 0;
    uint32 perHit = 0;

    void CalculateAmount(AuraEffect const*, int32& amount, bool&)
    {
        perHit = amount;
        amount *= 5;
    }

    void HandleAbsorb(AuraEffect* eff, DamageInfo& dmgInfo, uint32& absorbedDamage)
    {
        absorbedDamage = std::min(dmgInfo.GetDamage(), perHit);
        if (totalAbsorbed + absorbedDamage > 5 * perHit)
            absorbedDamage = 5 * perHit - totalAbsorbed;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_soul_barrier::CalculateAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_item_soul_barrier::HandleAbsorb, EFFECT_0);
    }
};

// 138972 - Item - Proc Heal Below 35%
class spell_item_proc_ji_kuns_rising_winds : public AuraScript
{
    PrepareAuraScript(spell_item_proc_ji_kuns_rising_winds);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetDamageInfo()->GetDamage())
            return false;
        return GetUnitOwner()->HealthBelowPctDamaged(35, eventInfo.GetDamageInfo()->GetDamage());
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_proc_ji_kuns_rising_winds::CheckProc);
    }
};

// 138756 - Blades of Renataki
// 138759 - Feathers of Fury
// 138786 - Wushoolay's Lightning
class spell_item_tot_stack_trinket : public AuraScript
{
    PrepareAuraScript(spell_item_tot_stack_trinket);

    uint32 GetEffectSpellId() const
    {
        switch (GetSpellInfo()->Id)
        {
            case 138756: return 138737;
            case 138786: return 138788;
            case 138759: return 138760;
        }
        return 0;
    }

    void HandlePeriodic(AuraEffect const* eff)
    {
        if (int32(eff->GetTickNumber()) > eff->GetTotalTicks()) // First at apply
            return;

        if (Aura* aura = GetUnitOwner()->GetAura(GetEffectSpellId()))
            aura->SetStackAmount(aura->GetStackAmount() + 1);
        else
        {
            Item* castItem = nullptr;
            if (Unit* caster = GetCaster())
                if (Player* player = caster->ToPlayer())
                    castItem = player->GetItemByGuid(GetAura()->GetCastItemGUID());

            GetUnitOwner()->CastSpell(GetUnitOwner(), GetEffectSpellId(), true, castItem, eff);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_tot_stack_trinket::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 139116 - Item - Attacks Proc Highest Rating
class spell_item_rune_of_re_organization : public AuraScript
{
    PrepareAuraScript(spell_item_rune_of_re_organization);

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TypeID::TYPEID_PLAYER;
    }

    void HandleProc(ProcEventInfo& eventInfo)
    {
        Player* player = GetUnitOwner()->ToPlayer();
        std::array<int32, 3> ratings
        {
            int32(player->GetUInt32Value(PLAYER_FIELD_COMBAT_RATINGS + uint32(CombatRating::CR_CRIT_MELEE))),
            int32(player->GetUInt32Value(PLAYER_FIELD_COMBAT_RATINGS + uint32(CombatRating::CR_MASTERY))),
            int32(player->GetUInt32Value(PLAYER_FIELD_COMBAT_RATINGS + uint32(CombatRating::CR_HASTE_MELEE)))
        };
        auto it = std::max_element(ratings.begin(), ratings.end());
        uint32 spellId = 0;
        int32 bp0 = 0, bp1 = 0, bp2 = 0;
        switch (std::distance(ratings.begin(), it))
        {
            case 0:
                spellId = 139117;
                bp0 = (ratings[1] + ratings[2]) * 2;
                bp1 = -ratings[1];
                bp2 = -ratings[2];
                break;
            case 1:
                spellId = 139120;
                bp0 = (ratings[0] + ratings[2]) * 2;
                bp1 = -ratings[0];
                bp2 = -ratings[2];
                break;
            case 2:
                spellId = 139121;
                bp0 = (ratings[1] + ratings[0]) * 2;
                bp1 = -ratings[1];
                bp2 = -ratings[0];
                break;
        }
        player->CastCustomSpell(player, spellId, &bp0, &bp1, &bp2, true);
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_item_rune_of_re_organization::HandleProc);
    }
};

// 143743 - Jard's Peculiar Energy Source
class spell_chief_engineer_jards_journal : public SpellScript
{
    PrepareSpellScript(spell_chief_engineer_jards_journal);

    void HandleCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            player->learnSpell(139176, false); // Jard's Peculiar Energy Source
            player->learnSpell(139192, false); // Sky Golem
            player->learnSpell(139197, false); // Advanced Refrigeration Unit
            player->learnSpell(139196, false); // Pierre
            player->learnSpell(143714, false); // Rascal-Bot
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_chief_engineer_jards_journal::HandleCast);
    }
};

// 143644 - Hardened Magnificent Hide and Its Uses
// 143626 - Celestial Cloth and Its Uses
// 143646 - Balanced Trillium Ingot and Its Uses
class spell_learn_some_ingredient_and_its_uses : public SpellScript
{
    PrepareSpellScript(spell_learn_some_ingredient_and_its_uses);

    void HandleCast()
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            uint32 spellId = 0;

            switch (GetSpellInfo()->Id)
            {
                case 143644: spellId = 142976; break;
                case 143626: spellId = 143011; break;
                case 143646: spellId = 143255; break;
                default:
                    return;
            }

            player->learnSpell(spellId, false);

            if (uint32 recipe = GetExplicitDiscoverySpell(spellId, player))
                player->learnSpell(recipe, false);
        }
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_learn_some_ingredient_and_its_uses::HandleCast);
    }
};

const std::vector<uint32> memorySpellsId = { 127196, 127205, 127206 };

// Memory of Mr. Smite 127207
class spell_memory_of_mr_smite : public AuraScript
{
    PrepareAuraScript(spell_memory_of_mr_smite);

    void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (Unit* owner = GetOwner()->ToUnit())
            owner->CastSpell(owner, Skyfire::Containers::SelectRandomContainerElement(memorySpellsId), true);
    }

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_memory_of_mr_smite::OnApply, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

// Potion of Illusion 80265
class spell_item_potion_of_illusion : public SpellScript
{
    PrepareSpellScript(spell_item_potion_of_illusion);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (!GetCaster())
            return;

        targets.remove(GetCaster());
        targets.remove_if(IllusionSourceCheck());
        if (GetCaster()->GetTypeId() == TypeID::TYPEID_PLAYER)
        {
            if (Unit* selection = GetCaster()->ToPlayer()->GetSelectedUnit())
            {
                if (std::find(targets.begin(), targets.end(), selection) != targets.end())
                {
                    targets.clear();
                    targets.push_back(selection);
                    return;
                }
            }
        }
        if (targets.size() > 1)
            Skyfire::Containers::RandomResizeList(targets, 1);
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        if (Unit* caster = GetCaster())
            if (Unit* target = GetHitUnit())
                caster->CastSpell(caster, GetEffectValue(), true, NULL, NULL, target->GetGUID());
    }

    void Register()
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_potion_of_illusion::FilterTargets, EFFECT_0, TARGET_UNIT_SRC_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_item_potion_of_illusion::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }

private:
    struct IllusionSourceCheck
    {
        bool operator()(WorldObject* u)
        {
            if (Unit* unit = u->ToUnit())
            {
                if (unit->GetFloatValue(OBJECT_FIELD_SCALE) <= 0)
                    return true;

                if (!unit->IsVisible())
                    return true;

                switch (unit->GetDisplayId())
                {
                    case 169:
                    case 1126:
                    case 11686:
                        return true;
                    default:
                    {
                        CreatureDisplayInfoEntry const* info = sCreatureDisplayInfoStore.LookupEntry(unit->GetDisplayId());
                        if (!info || !info->ModelId)
                            return true;

                        CreatureModelDataEntry const* model = sCreatureModelDataStore.LookupEntry(info->ModelId);
                        if (!model)
                            return true;

                        if (strstr(model->ModelPath, "INVISIBLESTALKER"))
                            return true;

                        return false;
                    }
                }
            }

            return true;
        }
    };
};

class spell_item_multistrike_trinket : public AuraScript
{
    PrepareAuraScript(spell_item_multistrike_trinket);

    void HandleProc(AuraEffect const* effect, ProcEventInfo& eventInfo)
    {
        if (!roll_chance_f(effect->GetAmount() / 10.0f))
            return;

        int32 damage = ProcDamage(eventInfo) / 3;
        uint32 spellId = GetSpellId(eventInfo.GetSpellInfo());
        GetUnitOwner()->CastCustomSpell(spellId, SPELLVALUE_BASE_POINT0, damage, eventInfo.GetActionTarget(), true);
    }

    virtual uint32 GetSpellId(SpellInfo const* trigger) = 0;

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_multistrike_trinket::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 146059 - Multistrike
class spell_item_multistrike_trinket_damage : public spell_item_multistrike_trinket
{
    uint32 GetSpellId(SpellInfo const* trigger) override
    {
        // I don't know how this must work
        if (!trigger)
            return 146061;
        if (trigger->SchoolMask == SPELL_SCHOOL_MASK_NORMAL && trigger->DmgClass == SPELL_DAMAGE_CLASS_MELEE)
            return 146061;

        switch (GetUnitOwner()->getClass())
        {
            case CLASS_PALADIN:
                if (trigger->SchoolMask & SPELL_SCHOOL_HOLY)
                    return 146063;
                break;
            case CLASS_HUNTER:
                return 146069;
            case CLASS_PRIEST:
                if (trigger->SchoolMask & SPELL_SCHOOL_HOLY)
                    return 146063;
                return 146065;
            case CLASS_SHAMAN:
                return 146071;
            case CLASS_MAGE:
                if (trigger->SchoolMask & SPELL_SCHOOL_MASK_ARCANE)
                    return 146070;
                return 146067;
            case CLASS_WARLOCK:
                return 146065;
            case CLASS_DRUID:
                return 146064;
            case CLASS_MONK:
                return 146075;
        }
        // By default - melee
        return 146061;
    }
};

// 146176 - Multistrike
class spell_item_multistrike_trinket_heal : public spell_item_multistrike_trinket
{
    uint32 GetSpellId(SpellInfo const* trigger) override
    {
        // I don't know how this must work
        return trigger->SchoolMask & SPELL_SCHOOL_MASK_NATURE ? 146178 : 146177;
    }
};

class spell_item_cooldown_reduce_trinket : public AuraScript
{
    PrepareAuraScript(spell_item_cooldown_reduce_trinket);

    uint32 spellId = 0;

    bool Load() override
    {
        return GetOwner()->GetTypeId() == TypeID::TYPEID_PLAYER;
    }

    void HandleApply(AuraEffect const* effect, AuraEffectHandleModes)
    {
        spellId = GetSpell();
        if (spellId)
        {
            float amount = -(1.0f - 1.0f / (1.0f + effect->GetAmount() / 100.0f)) * 100.0f;
            GetUnitOwner()->CastSpell(GetUnitOwner(), spellId, true);
            if (AuraEffect* spellMod = GetUnitOwner()->GetAuraEffect(spellId, EFFECT_0))
                spellMod->ChangeAmount(amount);
        }
    }

    void HandleRemove(AuraEffect const*, AuraEffectHandleModes)
    {
        if (spellId)
            GetUnitOwner()->RemoveAurasDueToSpell(spellId);
    }

    virtual uint32 GetSpell() = 0;

    void Register() override
    {
        OnEffectApply += AuraEffectApplyFn(spell_item_cooldown_reduce_trinket::HandleApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectApplyFn(spell_item_cooldown_reduce_trinket::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 145955 - Readiness
class spell_item_evil_eye_of_galakras : public spell_item_cooldown_reduce_trinket
{
    uint32 GetSpell() override
    {
        switch (GetPlayerSpec(GetUnitOwner()->ToPlayer()))
        {
            case SPEC_DEATH_KNIGHT_FROST:   return 145959;
            case SPEC_DEATH_KNIGHT_UNHOLY:  return 145960;
            case SPEC_DRUID_FERAL:          return 145961;
            case SPEC_PALADIN_RETRIBUTION:  return 145978;
            case SPEC_WARRIOR_ARMS:         return 145990;
            case SPEC_WARRIOR_FURY:         return 145991;
        }
        return 0;
    }
};

// 146019 - Readiness
class spell_item_assurance_of_consequence : public spell_item_cooldown_reduce_trinket
{
    uint32 GetSpell() override
    {
        switch (GetPlayerSpec(GetUnitOwner()->ToPlayer()))
        {
            case SPEC_DRUID_FERAL:          return 145961;
            case SPEC_HUNTER_BEAST_MASTERY: return 145964;
            case SPEC_HUNTER_MARKSMANSHIP:  return 145965;
            case SPEC_HUNTER_SURVIVAL:      return 145966;
            case SPEC_MONK_WINDWALKER:      return 145969;
            case SPEC_ROGUE_ASSASSINATION:  return 145983;
            case SPEC_ROGUE_COMBAT:         return 145984;
            case SPEC_ROGUE_SUBTLETY:       return 145985;
            case SPEC_SHAMAN_ENHANCEMENT:   return 145986;
        }
        return 0;
    }
};

// 146025 - Readiness
class spell_item_vial_of_living_corruption : public spell_item_cooldown_reduce_trinket
{
    uint32 GetSpell() override
    {
        switch (GetPlayerSpec(GetUnitOwner()->ToPlayer()))
        {
            case SPEC_DEATH_KNIGHT_BLOOD:   return 145958;
            case SPEC_DRUID_GUARDIAN:       return 145962;
            case SPEC_MONK_BREWMASTER:      return 145967;
            case SPEC_PALADIN_PROTECTION:   return 145976;
            case SPEC_WARRIOR_PROTECTION:   return 145992;
        }
        return 0;
    }
};

// 138728 - Change of Tactics
// 146310 - Restless Agility
// 146317 - Restless Spirit
class spell_item_restless_stat_trinket : public AuraScript
{
    PrepareAuraScript(spell_item_restless_stat_trinket);

    bool Load() override
    {
        GetAura()->SetStackAmount(GetSpellInfo()->StackAmount);
        return true;
    }

    void HandleTick(AuraEffect const*)
    {
        ModStackAmount(-1);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_restless_stat_trinket::HandleTick, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 146285 - Cruelty
// 146184 - Wrath of the Darkspear
class spell_item_soo_stack_trinket : public AuraScript
{
    PrepareAuraScript(spell_item_soo_stack_trinket);

    uint32 GetEffectSpellId() const
    {
        switch (GetSpellInfo()->Id)
        {
            case 146285: return 146293;
            case 146184: return 146202;
        }
        return 0;
    }

    void HandlePeriodic(AuraEffect const* effect)
    {
        if (int32(effect->GetTickNumber()) > effect->GetTotalTicks()) // First at apply
            return;

        // Yes, cast every tick
        Item* castItem = nullptr;
        if (Unit* caster = GetCaster())
            if (Player* player = caster->ToPlayer())
                castItem = player->GetItemByGuid(GetAura()->GetCastItemGUID());

        GetUnitOwner()->CastCustomSpell(GetEffectSpellId(), SPELLVALUE_BASE_POINT0, effect->GetAmount(), GetUnitOwner(), true, castItem, effect);
    }

    void HandleApply(AuraEffect const* effect, AuraEffectHandleModes)
    {
        if (GetSpellInfo()->Id == 146285) // Cruelty, no tick at apply
            HandlePeriodic(effect);
    }

    void HandleRemove(AuraEffect const*, AuraEffectHandleModes)
    {
        GetUnitOwner()->RemoveAurasDueToSpell(GetEffectSpellId());
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_soo_stack_trinket::HandlePeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectApply += AuraEffectRemoveFn(spell_item_soo_stack_trinket::HandleApply, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
        OnEffectRemove += AuraEffectRemoveFn(spell_item_soo_stack_trinket::HandleRemove, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

class spell_item_soo_trinket_aoe : public AuraScript
{
    PrepareAuraScript(spell_item_soo_trinket_aoe);

    void HandleProc(AuraEffect const* effect, ProcEventInfo& eventInfo)
    {
        if (!roll_chance_f(effect->GetAmount() / 100.0f))
            return;

        uint32 spellId = GetSpellId(eventInfo.GetSpellInfo());
        GetUnitOwner()->CastCustomSpell(spellId, SPELLVALUE_BASE_POINT0, ProcDamage(eventInfo), eventInfo.GetActionTarget(), true);
    }

    virtual uint32 GetSpellId(SpellInfo const*) = 0;

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_soo_trinket_aoe::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 146136 - Cleave
class spell_item_soo_trinket_aoe_damage : public spell_item_soo_trinket_aoe
{
    uint32 GetSpellId(SpellInfo const* trigger) override
    {
        // Same logic as multistrike
        if (!trigger)
            return 146137;
        if (trigger->SchoolMask == SPELL_SCHOOL_MASK_NORMAL && trigger->DmgClass == SPELL_DAMAGE_CLASS_MELEE)
            return 146137;

        switch (GetUnitOwner()->getClass())
        {
            case CLASS_PALADIN:
                if (trigger->SchoolMask & SPELL_SCHOOL_HOLY)
                    return 146157;
                break;
            case CLASS_HUNTER:
                return 146162;
            case CLASS_PRIEST:
                if (trigger->SchoolMask & SPELL_SCHOOL_HOLY)
                    return 146157;
                return 146159;
            case CLASS_SHAMAN:
                return 146171;
            case CLASS_MAGE:
                if (trigger->SchoolMask & SPELL_SCHOOL_MASK_ARCANE)
                    return 146166;
                return 146160;
            case CLASS_WARLOCK:
                return 146159;
            case CLASS_DRUID:
                return 146158;
            case CLASS_MONK:
                return 146172;
        }
        // By default - melee
        return 146137;
    }
};

// 148233 - Cleave
class spell_item_soo_trinket_aoe_heal : public spell_item_soo_trinket_aoe
{
    uint32 GetSpellId(SpellInfo const* trigger) override
    {
        // I don't know how this must work
        return trigger->SchoolMask & SPELL_SCHOOL_MASK_NATURE ? 148235 : 148234;
    }
};

// 146137, 146157, 146158, 146159, 146160, 146162, 146166, 146171, 146172, 148234, 148235
class spell_item_soo_trinket_aoe_effect : public SpellScript
{
    PrepareSpellScript(spell_item_soo_trinket_aoe_effect);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        targets.remove(GetExplTargetUnit());
    }

    void Register() override
    {
        auto const* spellInfo = sSpellMgr->GetSpellInfo(m_scriptSpellId);
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_soo_trinket_aoe_effect::FilterTargets, EFFECT_0, spellInfo->Effects[EFFECT_0].TargetB.GetTarget());
    }
};

// 146346 - Life Steal
class spell_item_juggernauts_focusing_crystal : public AuraScript
{
    PrepareAuraScript(spell_item_juggernauts_focusing_crystal);

    enum { SPELL_LIFE_STEAL = 146347 };

    void HandleProc(AuraEffect const* effect, ProcEventInfo& eventInfo)
    {
        if (int32 heal = CalculatePct(ProcDamage(eventInfo), effect->GetAmount() / 100.0f))
            GetUnitOwner()->CastCustomSpell(SPELL_LIFE_STEAL, SPELLVALUE_BASE_POINT0, heal, GetUnitOwner(), true);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_juggernauts_focusing_crystal::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

std::vector<std::pair<uint32, uint32>> legendaryCloakAnimations
{
    { 146195, 148957 },
    { 146197, 148954 },
    { 146199, 148956 },
    { 146193, 148958 },
};

// 146195 - Flurry of Xuen
// 146197 - Essence of Yu'lon
// 146199 - Spirit of Chi-Ji
// 146193 - Endurance of Niuzao
class spell_item_legendary_cloak : public AuraScript
{
    PrepareAuraScript(spell_item_legendary_cloak);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (GetUnitOwner()->GetMap()->IsDungeon())
            return true;
        if (GetUnitOwner()->GetMap()->IsBattlegroundOrArena())
            return false;
        if (GetId() != 146199 && eventInfo.GetActionTarget() && eventInfo.GetActionTarget()->GetAffectingPlayer())
            return false;
        return true;
    }

    void CalculatePeriodic(AuraEffect const*, bool&, int32& amplitude)
    {
        amplitude = GetId() == 146195 || GetId() == 146197 ? 55000 : 50000;
    }

    void HandleTick(AuraEffect const*)
    {
        if (!GetUnitOwner()->IsInCombat())
            for (auto&& itr : legendaryCloakAnimations)
                if (itr.first == GetId())
                    GetUnitOwner()->CastSpell(GetUnitOwner(), itr.second, true);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_legendary_cloak::CheckProc);
        DoEffectCalcPeriodic += AuraEffectCalcPeriodicFn(spell_item_legendary_cloak::CalculatePeriodic, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_legendary_cloak::HandleTick, EFFECT_1, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 148957 - Flurry of Xuen
// 148954 - Essence of Yu'lon
// 148956 - Spirit of Chi-Ji
// 148958 - Endurance of Niuzao
class spell_item_legendary_cloak_animation_reset : public AuraScript
{
    PrepareAuraScript(spell_item_legendary_cloak_animation_reset);

    void HandleRemove(AuraEffect const*, AuraEffectHandleModes)
    {
        for (auto&& itr : legendaryCloakAnimations)
            if (GetId() == itr.second)
                if (AuraEffect* periodic = GetUnitOwner()->GetAuraEffect(itr.first, EFFECT_0))
                    periodic->ResetPeriodic();
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_item_legendary_cloak_animation_reset::HandleRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 146194 - Flurry of Xuen
class spell_item_legendary_cloak_flurry_of_huen : public AuraScript
{
    PrepareAuraScript(spell_item_legendary_cloak_flurry_of_huen);

    void HandleTriggerMelee(AuraEffect const* effect)
    {
        if (GetUnitOwner()->getClass() == CLASS_HUNTER)
            PreventDefaultAction();
        else if (effect->GetTickNumber() % 3 == 0)
            GetUnitOwner()->SendPlaySpellVisual(33874, GetUnitOwner()->GetGUID(), 0.0f);
    }

    void HandleTriggerRanged(AuraEffect const* effect)
    {
        PreventDefaultAction();
        if (GetUnitOwner()->getClass() == CLASS_HUNTER)
        {
            if (Unit* target = ObjectAccessor::GetUnit(*GetUnitOwner(), GetUnitOwner()->GetTarget()))
                if (GetUnitOwner()->IsValidAttackTarget(target))
                    GetUnitOwner()->CastSpell(target, effect->GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, true);
        }
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_legendary_cloak_flurry_of_huen::HandleTriggerMelee, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_legendary_cloak_flurry_of_huen::HandleTriggerRanged, EFFECT_1, SPELL_AURA_PERIODIC_TRIGGER_SPELL);
    }
};

enum 
{
    SPELL_ESSENCE_OF_YU_LON_DAMAGE   = 148008,
};

// 146197 - Essence of Yu'lon
class spell_item_legendary_cloak_essence_of_yu_lon : public AuraScript
{
    PrepareAuraScript(spell_item_legendary_cloak_essence_of_yu_lon);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        if (!eventInfo.GetActionTarget())
            return false;

        if (eventInfo.GetSpellInfo() && eventInfo.GetSpellInfo()->Id == SPELL_ESSENCE_OF_YU_LON_DAMAGE)
            return false;
        return true;
    }

    void HandleProc(AuraEffect const* effect, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        if (auto const* spellInfo = sSpellMgr->GetSpellInfo(SPELL_ESSENCE_OF_YU_LON_DAMAGE))
        {
            int32 amount = GetUnitOwner()->SpellDamageBonusDone(eventInfo.GetActionTarget(), spellInfo, uint32(spellInfo->Effects[EFFECT_0].BasePoints), DOT);
            GetUnitOwner()->CastCustomSpell(effect->GetSpellInfo()->Effects[effect->GetEffIndex()].TriggerSpell, SPELLVALUE_BASE_POINT0, amount / 5, eventInfo.GetActionTarget(), true);
        }
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_legendary_cloak_essence_of_yu_lon::CheckProc);
        OnEffectProc += AuraEffectProcFn(spell_item_legendary_cloak_essence_of_yu_lon::HandleProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// 146198 - Essence of Yu'lon
class spell_item_legendary_cloak_essence_of_yu_lon_periodic : public AuraScript
{
    PrepareAuraScript(spell_item_legendary_cloak_essence_of_yu_lon_periodic);

    void HandleTick(AuraEffect const* effect)
    {
        if (Unit* caster = GetCaster())
            caster->CastCustomSpell(SPELL_ESSENCE_OF_YU_LON_DAMAGE, SPELLVALUE_BASE_POINT0, effect->GetAmount(), GetTarget(), true);
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_legendary_cloak_essence_of_yu_lon_periodic::HandleTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 146193 - Endurance of Niuzao
class spell_item_legendary_cloak_endurance_of_niuzao : public AuraScript
{
    PrepareAuraScript(spell_item_legendary_cloak_endurance_of_niuzao);

    enum { SPELL_ENDURANCE_OF_NIUZAO = 148010 };

    bool Load() override
    {
        return GetUnitOwner()->GetTypeId() == TypeID::TYPEID_PLAYER;
    }

    void CalcualteAmount(AuraEffect const*, int32& amount, bool&)
    {
        amount = -1;
    }

    void HandleAbsorb(AuraEffect*, DamageInfo& damageInfo, uint32& absorbed)
    {
        if (GetSpecRole(GetPlayerSpec(GetUnitOwner()->ToPlayer())) != ROLES_TANK)
            return;

        if (!GetUnitOwner()->GetMap()->IsDungeon())
            if ((damageInfo.GetAttacker() && damageInfo.GetAttacker()->GetAffectingPlayer()) || GetUnitOwner()->GetMap()->IsBattlegroundOrArena())
                return;

        if (damageInfo.GetDamage() >= GetUnitOwner()->GetHealth())
        {
            if (GetUnitOwner()->HasAura(SPELL_ENDURANCE_OF_NIUZAO))
                return;
            absorbed = damageInfo.GetDamage();
            GetUnitOwner()->CastSpell(GetUnitOwner(), SPELL_ENDURANCE_OF_NIUZAO, true);
        }
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_legendary_cloak_endurance_of_niuzao::CalcualteAmount, EFFECT_0, SPELL_AURA_SCHOOL_ABSORB);
        OnEffectAbsorb += AuraEffectAbsorbFn(spell_item_legendary_cloak_endurance_of_niuzao::HandleAbsorb, EFFECT_0);
    }
};

// 146199 - Spirit of Chi-Ji
class spell_item_legendary_cloak_spirit_of_chi_ji_proc : public AuraScript
{
    PrepareAuraScript(spell_item_legendary_cloak_spirit_of_chi_ji_proc);

    bool CheckProc(ProcEventInfo& eventInfo)
    {
        return eventInfo.GetHealInfo()->GetOverheal() != ProcHeal(eventInfo);
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_legendary_cloak_spirit_of_chi_ji_proc::CheckProc);
    }
};

// 146200 - Spirit of Chi-Ji
class spell_item_legendary_cloak_spirit_of_chi_ji : public AuraScript
{
    PrepareAuraScript(spell_item_legendary_cloak_spirit_of_chi_ji);

    enum { SPELL_SPIRIT_OF_CHI_JI_HEAL = 148009 };

    uint32 overhealAmount = 0;

    void HandleProc(ProcEventInfo& eventInfo)
    {
        overhealAmount += eventInfo.GetHealInfo()->GetOverheal();
    }

    void HandleTick(AuraEffect const*)
    {
        if (overhealAmount)
        {
            GetUnitOwner()->CastCustomSpell(SPELL_SPIRIT_OF_CHI_JI_HEAL, SPELLVALUE_BASE_POINT0, overhealAmount, GetUnitOwner(), true);
            overhealAmount = 0;
        }
    }

    void Register() override
    {
        OnProc += AuraProcFn(spell_item_legendary_cloak_spirit_of_chi_ji::HandleProc);
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_item_legendary_cloak_spirit_of_chi_ji::HandleTick, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 148009 - Spirit of Chi-Ji
class spell_item_spirit_of_chi_ji_heal : public spell_smart_heal
{
    PrepareSpellScript(spell_item_spirit_of_chi_ji_heal);

    uint32 targetCount = 0;

    void SelectTargets(std::list<WorldObject*>& targets)
    {
        ApplySmartHeal(targets, 5);
        targetCount = targets.size();
    }

    void HandleHit()
    {
        if (targetCount)
            SetHitHeal(GetHitHeal() / targetCount);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_spirit_of_chi_ji_heal::SelectTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ALLY);
        OnHit += SpellHitFn(spell_item_spirit_of_chi_ji_heal::HandleHit);
    }
};

enum MedalionSpells
{
    CELESTIAL_DEFENDER_MALE   = 148369,
    CELESTIAL_DEFENDER_FEMALE = 149229
};

// Celestial Defender's Medallion - 103685
class spell_item_celestial_defender : public SpellScript
{
    PrepareSpellScript(spell_item_celestial_defender);

    void HandleDummy(SpellEffIndex /* index */)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, caster->getGender() == GENDER_MALE ? CELESTIAL_DEFENDER_MALE : CELESTIAL_DEFENDER_FEMALE, true);
    }

    void Register()
    {
        OnEffectHit += SpellEffectFn(spell_item_celestial_defender::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// Spectral Grog - 104316
class spell_item_spectral_grog : public SpellScript
{
    PrepareSpellScript(spell_item_spectral_grog);

    void HandleDummy(SpellEffIndex /*index*/)
    {
        if (Unit* caster = GetCaster())
            caster->CastSpell(caster, caster->getGender() == GENDER_MALE ? 148564 : 148563, true);
    }

    void Register()
    {
        OnEffectHit += SpellEffectFn(spell_item_spectral_grog::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 127284 - Symbiotic Growth
class spell_item_symbiotic_growth : public SpellScript
{
    PrepareSpellScript(spell_item_symbiotic_growth);

    void HandleCast()
    {
        if (uint32 overrideAura = GetAuraId())
            GetCaster()->CastSpell(GetCaster(), overrideAura, true);
    }

    uint32 GetAuraId()
    {
        switch (GetCaster()->getClass())
        {
            case CLASS_DEATH_KNIGHT:
                return 129712;
            case CLASS_HUNTER:
                return 129713;
            case CLASS_MAGE:
                return 129714;
            case CLASS_MONK:
                return 129715;
            case CLASS_PALADIN:
                return 129716;
            case CLASS_PRIEST:
                return 129717;
            case CLASS_ROGUE:
                return 129718;
            case CLASS_SHAMAN:
                return 129719;
            case CLASS_WARLOCK:
                return 129720;
            case CLASS_WARRIOR:
                return 129721;
            default:
                break;
        }
        return 0;
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_item_symbiotic_growth::HandleCast);
    }
};

// 129712 - Symbiotic Growth
// 129713 - Symbiotic Growth
// 129714 - Symbiotic Growth
// 129715 - Symbiotic Growth
// 129716 - Symbiotic Growth
// 129717 - Symbiotic Growth
// 129718 - Symbiotic Growth
// 129719 - Symbiotic Growth
// 129720 - Symbiotic Growth
// 129721 - Symbiotic Growth
class spell_item_symbiotic_growth_aura : public AuraScript
{
    PrepareAuraScript(spell_item_symbiotic_growth_aura);

    uint32 spec = 0;

    bool Load() override
    {
        if (GetUnitOwner()->GetTypeId() != TypeID::TYPEID_PLAYER)
            return false;

        spec = GetPlayerSpec(GetUnitOwner()->ToPlayer());
        return true;
    }

    void CalculateAmount(AuraEffect const*, int32& amount, bool&)
    {
        amount = GetSpellId();
    }

    void Update(uint32 diff)
    {
        if (GetPlayerSpec(GetCaster()->ToPlayer()) != spec)
            Remove();
    }

    uint32 GetSpellId()
    {
        switch (GetPlayerSpec(GetCaster()->ToPlayer()))
        {
            case SPEC_WARRIOR_ARMS:
            case SPEC_WARRIOR_FURY:
                return 122294;
            case SPEC_WARRIOR_PROTECTION:
                return 122286;
            case SPEC_PALADIN_HOLY:
                return 113269;
            case SPEC_PALADIN_PROTECTION:
                return 113075;
            case SPEC_PALADIN_RETRIBUTION:
                return 122287;
            case SPEC_HUNTER_BEAST_MASTERY:
            case SPEC_HUNTER_MARKSMANSHIP:
            case SPEC_HUNTER_SURVIVAL:
                return 113073;
            case SPEC_ROGUE_ASSASSINATION:
            case SPEC_ROGUE_COMBAT:
            case SPEC_ROGUE_SUBTLETY:
                return 113613;
            case SPEC_PRIEST_SHADOW:
                return 113277;
            case SPEC_PRIEST_HOLY:
                return 113275;
            case SPEC_PRIEST_DISCIPLINE:
                return 113506;
            case SPEC_DEATH_KNIGHT_FROST:
            case SPEC_DEATH_KNIGHT_UNHOLY:
                return 113516;
            case SPEC_DEATH_KNIGHT_BLOOD:
                return 113072;
            case SPEC_SHAMAN_ELEMENTAL:
            case SPEC_SHAMAN_ENHANCEMENT:
                return 113286;
            case SPEC_SHAMAN_RESTORATION:
                return 113289;
            case SPEC_MAGE_ARCANE:
            case SPEC_MAGE_FIRE:
            case SPEC_MAGE_FROST:
                return 113074;
            case SPEC_WARLOCK_AFFLICTION:
            case SPEC_WARLOCK_DEMONOLOGY:
            case SPEC_WARLOCK_DESTRUCTION:
                return 113295;
            case SPEC_MONK_BREWMASTER:
                return 113306;
            case SPEC_MONK_WINDWALKER:
                return 127361;
            case SPEC_MONK_MISTWEAVER:
                return 113275;
        }
        return 0;
    }

    void Register() override
    {
        DoEffectCalcAmount += AuraEffectCalcAmountFn(spell_item_symbiotic_growth_aura::CalculateAmount, EFFECT_0, SPELL_AURA_OVERRIDE_ACTIONBAR_SPELLS);
    }
};

// 146315 - Item - Heals Proc Int
class spell_item_heals_proc_int : public AuraScript
{
    PrepareAuraScript(spell_item_heals_proc_int);

    bool CheckProc(ProcEventInfo&)
    {
        if (Player* player = GetUnitOwner()->ToPlayer())
            if (GetSpecRole(GetPlayerSpec(player)) == ROLES_HEALER)
                return true;
        return false;
    }

    void Register() override
    {
        DoCheckProc += AuraCheckProcFn(spell_item_heals_proc_int::CheckProc);
    }
};

// 98681 - Chirping Box. Reward for achievement 5860 - The 'Unbeatable?' Pterodactyl: BEATEN.
class spell_item_chirping_box : public SpellScript
{
    PrepareSpellScript(spell_item_chirping_box);

    enum
    {
        ITEM_BLUE_MINI_JOUSTER = 65661,
        ITEM_GOLD_MINI_JOUSTER = 65662,
    };

    void HandleCast()
    {
        uint32 itemId = ITEM_BLUE_MINI_JOUSTER;
        ItemTemplate const* blue = sObjectMgr->GetItemTemplate(ITEM_BLUE_MINI_JOUSTER);
        if (GetCaster()->ToPlayer()->HasItemCount(blue->ItemId) || GetCaster()->ToPlayer()->HasSpell(blue->Spells[1].SpellId))
            itemId = ITEM_GOLD_MINI_JOUSTER;

        GetCaster()->ToPlayer()->AddItem(itemId, 1);
    }

    void Register() override
    {
        OnCast += SpellCastFn(spell_item_chirping_box::HandleCast);
    }
};

enum PhilosopherProcs
{
    SPELL_STRENGHT_PROC  = 60229,
    SPELL_AGILITY_PROC   = 60233,
    SPELL_INTELLECT_PROC = 60234
};

const std::vector<uint32> procAuras = { SPELL_STRENGHT_PROC, SPELL_AGILITY_PROC, SPELL_INTELLECT_PROC  };
const std::vector<Stats> procStats =  { STAT_STRENGTH,       STAT_AGILITY,       STAT_INTELLECT        };

// Zen Alchemist Stone - 105547
class spell_item_zen_alchemist_stone : public AuraScript
{
    PrepareAuraScript(spell_item_zen_alchemist_stone);

    void OnProc(AuraEffect const* aurEff, ProcEventInfo& eventInfo)
    {
        PreventDefaultAction();

        Player* player = GetTarget()->ToPlayer();
        if (player->HasSpellCooldown(GetSpellInfo()->Id))
            return;

        Stats maxStatValue = STAT_STRENGTH;
        for (int8 i = 0; i < 3; i++)
            if (player->GetStat(procStats[i]) >= player->GetStat(procStats[maxStatValue]))
                maxStatValue = (Stats)i;

        // Can proc just on damage spell, also check for absorbed damage, because all damage can be absorbed but it's still damage spell
        if (eventInfo.GetDamageInfo() && eventInfo.GetDamageInfo()->GetDamage() == 0 && eventInfo.GetDamageInfo()->GetAbsorb() == 0)
            return;

        player->AddSpellCooldown(GetSpellInfo()->Id, 0, time(NULL) + 55);

        player->CastSpell(player, procAuras[maxStatValue], true);
        if (AuraEffect* aura = player->GetAuraEffect(procAuras[maxStatValue], EFFECT_0))
            aura->ChangeAmount(aurEff->GetAmount());
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_zen_alchemist_stone::OnProc, EFFECT_0, SPELL_AURA_PROC_TRIGGER_SPELL);
    }
};

// Blood Soaked Invitation 136149
class spell_item_blood_soaked_invitation : public SpellScript
{
    PrepareSpellScript(spell_item_blood_soaked_invitation);

    void HandleHordeDummy(SpellEffIndex index)
    {
        if (Player* caster = GetCaster()->ToPlayer())
            if (caster->GetTeam() == HORDE)
                caster->CastSpell(caster, GetSpellInfo()->Effects[index].BasePoints);
    }

    void HandleAllianceDummy(SpellEffIndex index)
    {
        if (Player* caster = GetCaster()->ToPlayer())
            if (caster->GetTeam() != HORDE)
                caster->CastSpell(caster, GetSpellInfo()->Effects[index].BasePoints);
    }

    void Register()
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_blood_soaked_invitation::HandleHordeDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnEffectHitTarget += SpellEffectFn(spell_item_blood_soaked_invitation::HandleAllianceDummy, EFFECT_1, SPELL_EFFECT_DUMMY);
    }
};

// Ai-Li Skymirror 129803
class spell_item_ai_li_skymirror : public SpellScript
{
    PrepareSpellScript(spell_item_ai_li_skymirror);

    void HandleCopyImage(SpellEffIndex index)
    {
        if (Player* target = GetHitPlayer())
            target->CastSpell(GetCaster(), GetSpellInfo()->Effects[index].BasePoints, true);
    }

    void Register()
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_ai_li_skymirror::HandleCopyImage, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

enum BananaSpells
{
    SPELL_MAGIC_BANANA_EFF = 129618,
};

// 440. Summoned by 129620 - Magic Banana
class sat_magic_banana : public IAreaTriggerOnce
{
    bool CheckTriggering(WorldObject* object) override
    {
        return object && object->ToPlayer() && object->ToPlayer()->IsAlive() && !object->ToPlayer()->GetMap()->IsBattleArena();
    }

    void OnTrigger(WorldObject* target) override
    {
        if (Player* itr = target->ToPlayer())
            itr->CastSpell(itr, SPELL_MAGIC_BANANA_EFF, true);
    }
};

// Party GRENADE eff 51508
class spell_item_party_grenade_eff : public SpellScript
{
    PrepareSpellScript(spell_item_party_grenade_eff);

    void HandleDance(SpellEffIndex index)
    {
        if (Player* target = GetHitPlayer())
            target->HandleEmoteStateCommand(EMOTE_STATE_DANCE);
    }

    void Register()
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_party_grenade_eff::HandleDance, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// Party GRENADE 51510
class spell_item_party_grenade : public AuraScript
{
    PrepareAuraScript(spell_item_party_grenade);

    void OnAuraEffectRemove(AuraEffect const* aurEff, AuraEffectHandleModes mode)
    {
        if (Player* owner = GetOwner()->ToPlayer())
            owner->HandleEmoteStateCommand(EMOTE_STATE_NONE);
    }

    void OnAuraEffectApply(AuraEffect const* aurEff, AuraEffectHandleModes mode)
    {
        if (Player* owner = GetOwner()->ToPlayer())
            owner->CastSpell(owner, GetSpellInfo()->Effects[EFFECT_0].BasePoints, true);
    }

    void Register() override
    {
        OnEffectRemove += AuraEffectRemoveFn(spell_item_party_grenade::OnAuraEffectRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
        OnEffectApply += AuraEffectApplyFn(spell_item_party_grenade::OnAuraEffectApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
    }
};

enum seesawSpells
{
    SPELL_SEESAW_VEHICLE = 142096,
};

// Seesaw 144399
class spell_item_seesaw : public SpellScript
{
    PrepareSpellScript(spell_item_seesaw);

    void HandleDance(SpellEffIndex index)
    {
        if (Unit* target = GetHitUnit())
            target->CastSpell(target, SPELL_SEESAW_VEHICLE, true);
    }

    void Register()
    {
        OnEffectHitTarget += SpellEffectFn(spell_item_seesaw::HandleDance, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 71610, 71641 - Echoes of Light (Althor's Abacus)
class spell_item_echoes_of_light : public SpellScript
{
    PrepareSpellScript(spell_item_echoes_of_light);

    void FilterTargets(std::list<WorldObject*>& targets)
    {
        if (targets.size() < 2)
            return;

        targets.sort([](WorldObject const* a, WorldObject const* b) { return Skyfire::HealthPctOrderPred()(a->ToUnit(), b->ToUnit()); }); // only units reach here

        WorldObject* target = targets.front();
        targets.clear();
        targets.push_back(target);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_item_echoes_of_light::FilterTargets, EFFECT_0, TARGET_UNIT_DEST_AREA_ALLY);
    }
};

// 7434 - Fate Rune of Unsurpassed Vigor
enum FateRuneOfUnsurpassedVigor
{
    SPELL_UNSURPASSED_VIGOR = 25733
};

class spell_item_fate_rune_of_unsurpassed_vigor : public AuraScript
{
    PrepareAuraScript(spell_item_fate_rune_of_unsurpassed_vigor);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return sSpellMgr->GetSpellInfo(SPELL_UNSURPASSED_VIGOR) != nullptr;
    }

    void HandleProc(AuraEffect const* /*aurEff*/, ProcEventInfo& /*eventInfo*/)
    {
        PreventDefaultAction();
        GetTarget()->CastSpell(GetTarget(), SPELL_UNSURPASSED_VIGOR, true);
    }

    void Register() override
    {
        OnEffectProc += AuraEffectProcFn(spell_item_fate_rune_of_unsurpassed_vigor::HandleProc, EFFECT_0, SPELL_AURA_DUMMY);
    }
};

// 84421 - Loot-A-Rang
class spell_item_loot_a_rang : public SpellScript
{
    PrepareSpellScript(spell_item_loot_a_rang);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        if (Player* player = GetCaster()->ToPlayer())
        {
            std::list<Creature*> corpses;
            auto check = [=](Creature const* creature)
            {
                if (creature->IsAlive())
                    return false;
                if (!player->IsWithinDist(creature, 40.0f))
                    return false;
                return player->isAllowedToLoot(creature);
            };
            Skyfire::CreatureListSearcher<decltype(check)> searcher{ player, corpses, check };
            player->VisitNearbyGridObject(40.0f, searcher);

            // find the nearest corpse
            Creature* nearest = nullptr;
            float minDist = 40.0f;
            for (Creature* c : corpses)
            {
                float dist = player->GetExactDist(c);
                if (dist < minDist)
                {
                    minDist = dist;
                    nearest = c;
                }
            }

            if (nearest)
                player->SendLoot(nearest->GetGUID(), LootType::LOOT_CORPSE, true);
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_item_loot_a_rang::HandleDummy, EFFECT_0, SPELL_EFFECT_CREATE_ITEM);
    }
};

} // namespace

void AddSC_item_spell_scripts_mop()
{
    new spell_item_stay_of_execution();
    new spell_item_flameseers_staff_flamebreaker();
    new spell_script<spell_item_wormhole_pandaria>("spell_item_wormhole_pandaria");
    new spell_script<spell_item_flippable_table>("spell_item_flippable_table");
    new aura_script<spell_item_stardust_no_2>("spell_item_stardust_no_2");
    new spell_script<spell_jewelcrafting_daily_quests_cata>("spell_jewelcrafting_daily_quests_cata");
    new spell_script<spell_item_alchemists_flask>("spell_item_alchemists_flask");
    new aura_script<spell_item_swarmkeepers_speed>("spell_item_swarmkeepers_speed");
    new aura_script<spell_item_arrival_of_the_naaru>("spell_item_arrival_of_the_naaru");
    new spell_script<spell_item_teleport_with_error>("spell_item_teleport_with_error");
    new spell_script<spell_item_summon_sword_dancers>("spell_item_summon_sword_dancers");
    new aura_script<spell_item_spark_of_zandalari_proc_aura>("spell_item_spark_of_zandalari_proc_aura");
    new aura_script<spell_item_spark_of_zandalari>("spell_item_spark_of_zandalari");
    new aura_script<spell_item_relic_of_zuldazar_shield>("spell_item_relic_of_zuldazar_shield");
    new spell_script<spell_item_relic_of_zuldazar>("spell_item_relic_of_zuldazar");
    new aura_script<spell_item_lightning_chalice_proc_aura>("spell_item_lightning_chalice_proc_aura");
    new aura_script<spell_infinite_power>("spell_infinite_power");
    new spell_script<spell_item_hardened_shell>("spell_item_hardened_shell");
    new aura_script<spell_item_soul_barrier>("spell_item_soul_barrier");
    new aura_script<spell_item_proc_ji_kuns_rising_winds>("spell_item_proc_ji_kuns_rising_winds");
    new aura_script<spell_item_tot_stack_trinket>("spell_item_tot_stack_trinket");
    new aura_script<spell_item_rune_of_re_organization>("spell_item_rune_of_re_organization");
    new spell_script<spell_chief_engineer_jards_journal>("spell_chief_engineer_jards_journal");
    new spell_script<spell_learn_some_ingredient_and_its_uses>("spell_learn_some_ingredient_and_its_uses");
    new aura_script<spell_memory_of_mr_smite>("spell_memory_of_mr_smite");
    new spell_script<spell_item_potion_of_illusion>("spell_item_potion_of_illusion");
    new aura_script<spell_item_multistrike_trinket_damage>("spell_item_multistrike_trinket_damage");
    new aura_script<spell_item_multistrike_trinket_heal>("spell_item_multistrike_trinket_heal");
    new aura_script<spell_item_evil_eye_of_galakras>("spell_item_evil_eye_of_galakras");
    new aura_script<spell_item_assurance_of_consequence>("spell_item_assurance_of_consequence");
    new aura_script<spell_item_vial_of_living_corruption>("spell_item_vial_of_living_corruption");
    new aura_script<spell_item_restless_stat_trinket>("spell_item_restless_stat_trinket");
    new aura_script<spell_item_soo_stack_trinket>("spell_item_soo_stack_trinket");
    new aura_script<spell_item_soo_trinket_aoe_damage>("spell_item_soo_trinket_aoe_damage");
    new aura_script<spell_item_soo_trinket_aoe_heal>("spell_item_soo_trinket_aoe_heal");
    new spell_script<spell_item_soo_trinket_aoe_effect>("spell_item_soo_trinket_aoe_effect");
    new aura_script<spell_item_juggernauts_focusing_crystal>("spell_item_juggernauts_focusing_crystal");
    new aura_script<spell_item_legendary_cloak>("spell_item_legendary_cloak");
    new aura_script<spell_item_legendary_cloak_animation_reset>("spell_item_legendary_cloak_animation_reset");
    new aura_script<spell_item_legendary_cloak_flurry_of_huen>("spell_item_legendary_cloak_flurry_of_huen");
    new aura_script<spell_item_legendary_cloak_essence_of_yu_lon>("spell_item_legendary_cloak_essence_of_yu_lon");
    new aura_script<spell_item_legendary_cloak_essence_of_yu_lon_periodic>("spell_item_legendary_cloak_essence_of_yu_lon_periodic");
    new aura_script<spell_item_legendary_cloak_endurance_of_niuzao>("spell_item_legendary_cloak_endurance_of_niuzao");
    new aura_script<spell_item_legendary_cloak_spirit_of_chi_ji_proc>("spell_item_legendary_cloak_spirit_of_chi_ji_proc");
    new aura_script<spell_item_legendary_cloak_spirit_of_chi_ji>("spell_item_legendary_cloak_spirit_of_chi_ji");
    new spell_script<spell_item_spirit_of_chi_ji_heal>("spell_item_spirit_of_chi_ji_heal");
    new spell_script<spell_item_celestial_defender>("spell_item_celestial_defender");
    new spell_script<spell_item_spectral_grog>("spell_item_spectral_grog");
    new spell_script<spell_item_symbiotic_growth>("spell_item_symbiotic_growth");
    new aura_script<spell_item_symbiotic_growth_aura>("spell_item_symbiotic_growth_aura");
    new aura_script<spell_item_heals_proc_int>("spell_item_heals_proc_int");
    new spell_script<spell_item_chirping_box>("spell_item_chirping_box");
    new aura_script<spell_item_zen_alchemist_stone>("spell_item_zen_alchemist_stone");
    new spell_script<spell_item_blood_soaked_invitation>("spell_item_blood_soaked_invitation");
    new spell_script<spell_item_ai_li_skymirror>("spell_item_ai_li_skymirror");
    new atrigger_script<sat_magic_banana>("sat_magic_banana");
    new spell_script<spell_item_party_grenade_eff>("spell_item_party_grenade_eff");
    new aura_script<spell_item_party_grenade>("spell_item_party_grenade");
    new spell_script<spell_item_seesaw>("spell_item_seesaw");
    new spell_script<spell_item_echoes_of_light>("spell_item_echoes_of_light");
    new aura_script<spell_item_fate_rune_of_unsurpassed_vigor>("spell_item_fate_rune_of_unsurpassed_vigor");
    new spell_script<spell_item_loot_a_rang>("spell_item_loot_a_rang");
}
