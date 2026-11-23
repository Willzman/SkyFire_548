/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

/*
 * Holiday spell scripts ported to Project SkyFire from TrinityCore (3.3.5 branch,
 * src/server/scripts/Events: love_is_in_the_air.cpp, lunar_festival.cpp, hallows_end.cpp,
 * midsummer.cpp, brewfest.cpp; GPL v2 or later). Only the scripts the fork had no
 * counterpart for.
 */

#include "Containers.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellMgr.h"
#include "SpellScript.h"

namespace
{

bool HolidaySpellsExist(std::initializer_list<uint32> spells)
{
    for (uint32 spell : spells)
        if (!sSpellMgr->GetSpellInfo(spell))
            return false;
    return true;
}

/*######
## Love is in the Air
######*/

enum LoveIsInTheAir
{
    SPELL_HEAVILY_PERFUMED          = 71507,
    SPELL_SERVICE_UNIFORM           = 71450
};

// 71507 - Heavily Perfumed (quests 24536, 24655: Something Stinks)
class spell_love_is_in_the_air_heavily_perfumed : public AuraScript
{
    PrepareAuraScript(spell_love_is_in_the_air_heavily_perfumed);

    bool Validate(SpellInfo const* spellInfo) override
    {
        return HolidaySpellsExist({ uint32(spellInfo->Effects[EFFECT_0].CalcValue()) });
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), uint32(GetSpellInfo()->Effects[EFFECT_0].CalcValue()));
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_love_is_in_the_air_heavily_perfumed::AfterRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 71508 - Recently Analyzed
class spell_love_is_in_the_air_recently_analyzed : public AuraScript
{
    PrepareAuraScript(spell_love_is_in_the_air_recently_analyzed);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return HolidaySpellsExist({ SPELL_HEAVILY_PERFUMED });
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        if (GetTargetApplication()->GetRemoveMode() == AURA_REMOVE_BY_EXPIRE)
            GetTarget()->CastSpell(GetTarget(), SPELL_HEAVILY_PERFUMED);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_love_is_in_the_air_recently_analyzed::AfterRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

// 69438 - Sample Satisfaction (quests 24629, 24635, 24636)
class spell_love_is_in_the_air_sample_satisfaction : public AuraScript
{
    PrepareAuraScript(spell_love_is_in_the_air_sample_satisfaction);

    void OnPeriodic(AuraEffect const* /*aurEff*/)
    {
        if (roll_chance_i(30))
            Remove();
    }

    void Register() override
    {
        OnEffectPeriodic += AuraEffectPeriodicFn(spell_love_is_in_the_air_sample_satisfaction::OnPeriodic, EFFECT_0, SPELL_AURA_PERIODIC_DUMMY);
    }
};

// 71522, 71539 - Crown Chemical Co. Supplies
class spell_love_is_in_the_air_cancel_service_uniform : public SpellScript
{
    PrepareSpellScript(spell_love_is_in_the_air_cancel_service_uniform);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->RemoveAurasDueToSpell(SPELL_SERVICE_UNIFORM);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_love_is_in_the_air_cancel_service_uniform::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 68529 - Perfume Immune, 68530 - Cologne Immune (items 49351, 49352: the neutralizers)
class spell_love_is_in_the_air_perfume_cologne_immune : public SpellScript
{
    PrepareSpellScript(spell_love_is_in_the_air_perfume_cologne_immune);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->RemoveAurasDueToSpell(uint32(GetEffectValue()));
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_love_is_in_the_air_perfume_cologne_immune::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
        OnEffectHit += SpellEffectFn(spell_love_is_in_the_air_perfume_cologne_immune::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Lunar Festival
######*/

enum LunarFestival
{
    SPELL_ELUNES_BLESSING_QUEST_CREDIT  = 26394
};

// 26393 - Elune's Blessing
class spell_lunar_festival_elunes_blessing : public SpellScript
{
    PrepareSpellScript(spell_lunar_festival_elunes_blessing);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return HolidaySpellsExist({ SPELL_ELUNES_BLESSING_QUEST_CREDIT });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_ELUNES_BLESSING_QUEST_CREDIT);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_lunar_festival_elunes_blessing::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Hallow's End
######*/

enum HallowsEndTc
{
    SPELL_HALLOWS_END_CANDY_ORANGE_GIANT            = 24924,
    SPELL_HALLOWS_END_CANDY_SKELETON                = 24925,
    SPELL_HALLOWS_END_CANDY_PIRATE                  = 24926,
    SPELL_HALLOWS_END_CANDY_GHOST                   = 24927,
    SPELL_HALLOWS_END_CANDY_FEMALE_DEFIAS_PIRATE    = 44742,
    SPELL_HALLOWS_END_CANDY_MALE_DEFIAS_PIRATE      = 44743,

    SPELL_CREATE_WATER_BUCKET_BARREL_SPLASH         = 43244,
    SPELL_JUST_LOOTED_WATER_BARREL                  = 44410
};

// 24930 - Hallow's End Candy
class spell_hallow_end_candy : public SpellScript
{
    PrepareSpellScript(spell_hallow_end_candy);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return HolidaySpellsExist({ SPELL_HALLOWS_END_CANDY_ORANGE_GIANT, SPELL_HALLOWS_END_CANDY_SKELETON,
            SPELL_HALLOWS_END_CANDY_PIRATE, SPELL_HALLOWS_END_CANDY_GHOST });
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->CastSpell(GetCaster(), RAND(SPELL_HALLOWS_END_CANDY_ORANGE_GIANT, SPELL_HALLOWS_END_CANDY_SKELETON,
            SPELL_HALLOWS_END_CANDY_PIRATE, SPELL_HALLOWS_END_CANDY_GHOST), true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_hallow_end_candy::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 24926 - Hallow's End Candy (pirate costume by gender)
class spell_hallow_end_candy_pirate : public AuraScript
{
    PrepareAuraScript(spell_hallow_end_candy_pirate);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return HolidaySpellsExist({ SPELL_HALLOWS_END_CANDY_FEMALE_DEFIAS_PIRATE, SPELL_HALLOWS_END_CANDY_MALE_DEFIAS_PIRATE });
    }

    uint32 CostumeFor(Unit* target) const
    {
        return target->getGender() == GENDER_FEMALE ? SPELL_HALLOWS_END_CANDY_FEMALE_DEFIAS_PIRATE : SPELL_HALLOWS_END_CANDY_MALE_DEFIAS_PIRATE;
    }

    void HandleApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), CostumeFor(GetTarget()), true);
    }

    void HandleRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->RemoveAurasDueToSpell(CostumeFor(GetTarget()));
    }

    void Register() override
    {
        AfterEffectApply += AuraEffectApplyFn(spell_hallow_end_candy_pirate::HandleApply, EFFECT_0, SPELL_AURA_MOD_INCREASE_SWIM_SPEED, AURA_EFFECT_HANDLE_REAL);
        AfterEffectRemove += AuraEffectRemoveFn(spell_hallow_end_candy_pirate::HandleRemove, EFFECT_0, SPELL_AURA_MOD_INCREASE_SWIM_SPEED, AURA_EFFECT_HANDLE_REAL);
    }
};

// 42144 - Headless Horseman - Create Water Bucket
class spell_hallow_end_create_water_bucket : public SpellScript
{
    PrepareSpellScript(spell_hallow_end_create_water_bucket);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return HolidaySpellsExist({ SPELL_CREATE_WATER_BUCKET_BARREL_SPLASH, SPELL_JUST_LOOTED_WATER_BARREL });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        target->CastSpell(target, SPELL_CREATE_WATER_BUCKET_BARREL_SPLASH);
        target->CastSpell(target, SPELL_JUST_LOOTED_WATER_BARREL);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_hallow_end_create_water_bucket::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

/*######
## Midsummer Fire Festival
######*/

enum MidsummerTc
{
    SPELL_TORCH_TOSSING_TRAINING        = 45716,
    SPELL_TORCH_TOSSING_PRACTICE        = 46630,
    SPELL_BRAZIERS_HIT                  = 45724,

    SPELL_STAMP_OUT_BONFIRE_ART_KIT     = 46903,
    SPELL_STAMP_OUT_BONFIRE_DUMMY       = 45437
};

// Cleansing Flames (the stolen city flames): each creates that city's flame item
uint32 CleansingFlamesCreateSpell(uint32 spellId)
{
    switch (spellId)
    {
        case 29126: return 29099; // Darnassus
        case 29137: return 29101; // Stormwind
        case 29135: return 29102; // Ironforge
        case 29136: return 29130; // Orgrimmar
        case 29138: return 29132; // Thunder Bluff
        case 29139: return 29133; // Undercity
        case 46672: return 46689; // Silvermoon
        case 46671: return 46690; // Exodar
        default:    return 0;
    }
}

// 29126, 29135, 29136, 29137, 29138, 29139, 46671, 46672 - Cleansing Flames
class spell_midsummer_cleansing_flames : public SpellScript
{
    PrepareSpellScript(spell_midsummer_cleansing_flames);

    bool Validate(SpellInfo const* spellInfo) override
    {
        uint32 create = CleansingFlamesCreateSpell(spellInfo->Id);
        return create && sSpellMgr->GetSpellInfo(create);
    }

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), CleansingFlamesCreateSpell(GetSpellInfo()->Id));
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_midsummer_cleansing_flames::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

// 45443 - Stamp Out Bonfire, Event
class spell_midsummer_stamp_out_bonfire_event : public SpellScript
{
    PrepareSpellScript(spell_midsummer_stamp_out_bonfire_event);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return HolidaySpellsExist({ SPELL_STAMP_OUT_BONFIRE_ART_KIT, SPELL_STAMP_OUT_BONFIRE_DUMMY });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        Unit* caster = GetCaster();
        caster->CastSpell(caster, SPELL_STAMP_OUT_BONFIRE_ART_KIT, true);
        caster->CastSpell(caster, SPELL_STAMP_OUT_BONFIRE_DUMMY, true);
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_midsummer_stamp_out_bonfire_event::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 46074 - Remove Torches
class spell_midsummer_remove_torches : public SpellScript
{
    PrepareSpellScript(spell_midsummer_remove_torches);

    void HandleDummy(SpellEffIndex /*effIndex*/)
    {
        Unit* target = GetHitUnit();
        target->RemoveAurasDueToSpell(SPELL_TORCH_TOSSING_TRAINING);
        target->RemoveAurasDueToSpell(SPELL_TORCH_TOSSING_PRACTICE);
        target->RemoveAurasDueToSpell(SPELL_BRAZIERS_HIT);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_midsummer_remove_torches::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
    }
};

/*######
## Brewfest
######*/

enum BrewfestTc
{
    SPELL_RENTAL_RACING_RAM             = 43883,
    SPELL_PORT_TO_GRIM_GUZZLER          = 47523,
    SPELL_BOTM_VOMIT_BREW_VOMIT_VISUAL  = 49867
};

// 43876 - Dismount Ram
class spell_brewfest_dismount_ram : public SpellScript
{
    PrepareSpellScript(spell_brewfest_dismount_ram);

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetCaster()->RemoveAurasDueToSpell(SPELL_RENTAL_RACING_RAM);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_brewfest_dismount_ram::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 49466 - Mole Machine Portal Schedule
class spell_brewfest_mole_machine_portal_schedule : public SpellScript
{
    PrepareSpellScript(spell_brewfest_mole_machine_portal_schedule);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return HolidaySpellsExist({ SPELL_PORT_TO_GRIM_GUZZLER });
    }

    void HandleScript(SpellEffIndex /*effIndex*/)
    {
        GetHitUnit()->CastSpell(GetHitUnit(), SPELL_PORT_TO_GRIM_GUZZLER);
    }

    void Register() override
    {
        OnEffectHitTarget += SpellEffectFn(spell_brewfest_mole_machine_portal_schedule::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 49869 - Nauseous (Brew of the Month)
class spell_brewfest_botm_nauseous : public AuraScript
{
    PrepareAuraScript(spell_brewfest_botm_nauseous);

    bool Validate(SpellInfo const* /*spellInfo*/) override
    {
        return HolidaySpellsExist({ SPELL_BOTM_VOMIT_BREW_VOMIT_VISUAL });
    }

    void AfterRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
    {
        GetTarget()->CastSpell(GetTarget(), SPELL_BOTM_VOMIT_BREW_VOMIT_VISUAL, true);
    }

    void Register() override
    {
        AfterEffectRemove += AuraEffectRemoveFn(spell_brewfest_botm_nauseous::AfterRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
    }
};

} // namespace

void AddSC_event_holiday_events_tc()
{
    new aura_script<spell_love_is_in_the_air_heavily_perfumed>("spell_love_is_in_the_air_heavily_perfumed");
    new aura_script<spell_love_is_in_the_air_recently_analyzed>("spell_love_is_in_the_air_recently_analyzed");
    new aura_script<spell_love_is_in_the_air_sample_satisfaction>("spell_love_is_in_the_air_sample_satisfaction");
    new spell_script<spell_love_is_in_the_air_cancel_service_uniform>("spell_love_is_in_the_air_cancel_service_uniform");
    new spell_script<spell_love_is_in_the_air_perfume_cologne_immune>("spell_love_is_in_the_air_perfume_cologne_immune");
    new spell_script<spell_lunar_festival_elunes_blessing>("spell_lunar_festival_elunes_blessing");
    new spell_script<spell_hallow_end_candy>("spell_hallow_end_candy");
    new aura_script<spell_hallow_end_candy_pirate>("spell_hallow_end_candy_pirate");
    new spell_script<spell_hallow_end_create_water_bucket>("spell_hallow_end_create_water_bucket");
    new spell_script<spell_midsummer_cleansing_flames>("spell_midsummer_cleansing_flames");
    new spell_script<spell_midsummer_stamp_out_bonfire_event>("spell_midsummer_stamp_out_bonfire_event");
    new spell_script<spell_midsummer_remove_torches>("spell_midsummer_remove_torches");
    new spell_script<spell_brewfest_dismount_ram>("spell_brewfest_dismount_ram");
    new spell_script<spell_brewfest_mole_machine_portal_schedule>("spell_brewfest_mole_machine_portal_schedule");
    new aura_script<spell_brewfest_botm_nauseous>("spell_brewfest_botm_nauseous");
}
