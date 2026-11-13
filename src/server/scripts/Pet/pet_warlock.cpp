/*
* This file is part of Project SkyFire https://www.projectskyfire.org. 
* See LICENSE.md file for Copyright information
*/

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_sha_".
 */

#include "ObjectAccessor.h"
#include "Pet.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "SpellAuraEffects.h"
#include "SpellAuras.h"
#include "SpellMgr.h"

enum WarlockPetSpells
{
    SPELL_WARLOCK_FIREBOLT              = 104318,
    SPELL_WARLOCK_DOOM_BOLT             = 85692,
    SPELL_WARLOCK_MASTER_DEMONOLOGIST   = 115556,
    SPELL_WARLOCK_MASTERY_DEMONOLOGY    = 77219,
    SPELL_WARLOCK_PET_FEL_ENERGY        = 123746,
    SPELL_WARLOCK_DEMONIC_GATEWAY_TELE_GREEN  = 113896,
    SPELL_WARLOCK_DEMONIC_GATEWAY_TELE_PURPLE = 120729,
    SPELL_WARLOCK_DEMONIC_GATEWAY_AURA        = 113901,
    SPELL_WARLOCK_DEMONIC_GATEWAY_COOLDOWN    = 113942,
    SPELL_WARLOCK_GLYPH_OF_GATEWAY_ATTUNEMENT = 135557,
    SPELL_WARLOCK_PVP_SET_4P_BONUS            = 143395,
    SPELL_BG_HORDE_FLAG                       = 23333,
    SPELL_BG_ALLIANCE_FLAG                    = 23335
};

enum WarlockPetNpcs
{
    NPC_WARLOCK_GATEWAY_GREEN           = 59262,
    NPC_WARLOCK_GATEWAY_PURPLE          = 59271
};

static uint32 const DemonicGatewayPurpleCharge[5] = { 113915, 113916, 113917, 113918, 113919 };
static uint32 const DemonicGatewayGreenCharge[5]  = { 113903, 113911, 113912, 113913, 113914 };

static void ApplyWarlockGuardianAuras(Creature* me)
{
    Unit* owner = me->GetOwner();
    if (owner && owner->HasAura(SPELL_WARLOCK_MASTERY_DEMONOLOGY) && !me->HasAura(SPELL_WARLOCK_MASTER_DEMONOLOGIST))
        me->CastSpell(me, SPELL_WARLOCK_MASTER_DEMONOLOGIST, true);
    if (!me->HasAura(SPELL_WARLOCK_PET_FEL_ENERGY))
        me->CastSpell(me, SPELL_WARLOCK_PET_FEL_ENERGY, true);
}

// 11859 - Doomguard, 59000 - Terrorguard
class npc_doomguard : public CreatureScript
{
public:
    npc_doomguard() : CreatureScript("npc_doomguard") { }

    struct npc_doomguardAI : public ScriptedAI
    {
        npc_doomguardAI(Creature* creature) : ScriptedAI(creature) { }

        void Reset() OVERRIDE
        {
            ApplyWarlockGuardianAuras(me);
        }

        void AttackStart(Unit* victim) OVERRIDE
        {
            AttackStartCaster(victim, 30.0f);
        }

        void UpdateAI(uint32 /*diff*/) OVERRIDE
        {
            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            DoCastVictim(SPELL_WARLOCK_DOOM_BOLT);
        }
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_doomguardAI(creature);
    }
};

// 89 - Infernal, 58997 - Abyssal
class npc_warl_infernal : public CreatureScript
{
public:
    npc_warl_infernal() : CreatureScript("npc_warl_infernal") { }

    struct npc_warl_infernalAI : public ScriptedAI
    {
        npc_warl_infernalAI(Creature* creature) : ScriptedAI(creature)
        {
            _defendWarlock = false;
        }

        void Reset() OVERRIDE
        {
            ApplyWarlockGuardianAuras(me);
        }

        // Attacks whatever is closest to its landing point, then falls back to defending the warlock
        bool SelectLandingTarget()
        {
            if (_defendWarlock)
                return false;

            Unit* target = me->SelectNearestTarget(15.0f);
            if (target)
                AttackStart(target);
            else
                _defendWarlock = true;

            return target != NULL;
        }

        void UpdateAI(uint32 /*diff*/) OVERRIDE
        {
            if (!SelectLandingTarget() && !UpdateVictim())
                return;

            DoMeleeAttackIfReady();
        }

    private:
        bool _defendWarlock;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_warl_infernalAI(creature);
    }
};

// 416 - Imp, 1860 - Voidwalker, 1863 - Succubus, 417 - Felhunter, 17252 - Felguard
// Only the guardians summoned by Grimoire of Service (111859, 111895, 111896, 111897, 111898);
// the warlock's real pet uses PetAI. From Legends of Azeroth, with the basic attack repeated on its cooldown.
class npc_grimoire_of_service_pet : public CreatureScript
{
public:
    npc_grimoire_of_service_pet() : CreatureScript("npc_grimoire_of_service_pet") { }

    struct npc_grimoire_of_service_petAI : public ScriptedAI
    {
        npc_grimoire_of_service_petAI(Creature* creature) : ScriptedAI(creature)
        {
            _basicAttack = 0;
            _specialAbility = 0;
            _basicAttackTimer = 0;
            _started = false;
            _needFelstorm = false;

            switch (me->GetEntry())
            {
                case 416:   _basicAttack = 3110;  _specialAbility = 89808; break; // Firebolt, Singe Magic
                case 1860:  _basicAttack = 3716;  _specialAbility = 17735; break; // Torment, Suffering
                case 417:   _basicAttack = 54049; _specialAbility = 19647; break; // Shadow Bite, Spell Lock
                case 1863:  _basicAttack = 7814;  _specialAbility = 6358;  break; // Lash of Pain, Seduction
                case 17252: _basicAttack = 30213; _specialAbility = 89766; _needFelstorm = true; break; // Legion Strike, Axe Toss
                default:
                    break;
            }
        }

        void Reset() OVERRIDE
        {
            ApplyWarlockGuardianAuras(me);
        }

        void AttackStart(Unit* victim) OVERRIDE
        {
            if (me->GetEntry() == 416)
                AttackStartCaster(victim, 30.0f);
            else
                ScriptedAI::AttackStart(victim);
        }

        // The demon uses its special ability once, on the warlock's target (the Imp on the warlock)
        void Start()
        {
            _started = true;

            Unit* owner = me->GetOwner();
            if (!owner)
                return;

            Unit* victim = ObjectAccessor::GetUnit(*me, owner->GetTarget());
            if (victim && !me->IsValidAttackTarget(victim))
                victim = NULL;

            if (victim)
                AttackStart(victim);

            Unit* abilityTarget = me->GetEntry() == 416 ? owner : victim;
            if (abilityTarget && _specialAbility)
            {
                me->CastSpell(abilityTarget, _specialAbility, false);
                if (me->GetEntry() == 417)
                    me->CastSpell(abilityTarget, 19505, true); // Devour Magic
            }
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (!_started)
                Start();

            if (_basicAttackTimer > diff)
                _basicAttackTimer -= diff;
            else
                _basicAttackTimer = 0;

            if (!UpdateVictim())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (_needFelstorm && me->IsWithinMeleeRange(me->GetVictim()))
            {
                me->CastSpell(me, 89751, true); // Felstorm
                _needFelstorm = false;
            }

            if (_basicAttack && !_basicAttackTimer)
            {
                if (SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(_basicAttack))
                {
                    DoCastVictim(_basicAttack);
                    _basicAttackTimer = std::max<uint32>(spellInfo->GetRecoveryTime(), 1500);
                }
            }

            DoMeleeAttackIfReady();
        }

    private:
        uint32 _basicAttack;
        uint32 _specialAbility;
        uint32 _basicAttackTimer;
        bool _started;
        bool _needFelstorm;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        switch (creature->GetUInt32Value(UNIT_FIELD_CREATED_BY_SPELL))
        {
            case 111859:
            case 111895:
            case 111896:
            case 111897:
            case 111898:
                return new npc_grimoire_of_service_petAI(creature);
            default:
                return NULL;    // anything else with these entries keeps its normal AI
        }
    }
};

class npc_wild_imp : public CreatureScript
{
public:
    npc_wild_imp() : CreatureScript("npc_wild_imp") { }

    struct npc_wild_impAI : public ScriptedAI
    {
        uint32 charges;

        npc_wild_impAI(Creature* creature) : ScriptedAI(creature)
        {
            charges = 10;
            me->SetReactState(REACT_ASSIST);
        }

        void Reset()
        {
            me->SetReactState(REACT_ASSIST);
            ApplyWarlockGuardianAuras(me);

            if (me->GetOwner())
                if (me->GetOwner()->GetVictim())
                    AttackStart(me->GetOwner()->GetVictim());
        }

        void UpdateAI(uint32 diff)
        {
            if (me->GetReactState() != REACT_ASSIST)
                me->SetReactState(REACT_ASSIST);

            if (!me->GetOwner())
                return;

            if (!me->GetOwner()->ToPlayer())
                return;

            if (me->HasUnitState(UNIT_STATE_CASTING))
                return;

            if (!charges)
            {
                me->DespawnOrUnsummon();
                return;
            }

            if ((me->GetVictim() || me->GetOwner()->getAttackerForHelper()))
            {
                me->CastSpell(me->GetVictim() ? me->GetVictim() : me->GetOwner()->getAttackerForHelper(), SPELL_WARLOCK_FIREBOLT, false);
                me->GetOwner()->EnergizeBySpell(me->GetOwner(), SPELL_WARLOCK_FIREBOLT, 5, POWER_DEMONIC_FURY);
                charges--;
            }
            else if (Pet* pet = me->GetOwner()->ToPlayer()->GetPet())
            {
                if (pet->getAttackerForHelper())
                {
                    me->CastSpell(me->GetVictim() ? me->GetVictim() : pet->getAttackerForHelper(), SPELL_WARLOCK_FIREBOLT, false);
                    me->GetOwner()->EnergizeBySpell(me->GetOwner(), SPELL_WARLOCK_FIREBOLT, 5, POWER_DEMONIC_FURY);
                    charges--;
                }
            }
        }
    };

    CreatureAI* GetAI(Creature* creature) const
    {
        return new npc_wild_impAI(creature);
    }
};

// 59262 - Demonic Gateway (green), 59271 - Demonic Gateway (purple)
class npc_demonic_gateway : public CreatureScript
{
public:
    npc_demonic_gateway() : CreatureScript("npc_demonic_gateway") { }

    struct npc_demonic_gatewayAI : public ScriptedAI
    {
        npc_demonic_gatewayAI(Creature* creature) : ScriptedAI(creature)
        {
            _attunementTimer = 200;
            me->SetReactState(REACT_PASSIVE);
        }

        void UpdateAI(uint32 diff) OVERRIDE
        {
            if (_attunementTimer <= diff)
            {
                if (Unit* warlock = me->GetOwner())
                    if (warlock->HasAura(SPELL_WARLOCK_GLYPH_OF_GATEWAY_ATTUNEMENT) && warlock->IsInDist(me, 2.0f))
                        DoTeleportIfCan(warlock);
                _attunementTimer = 200;
            }
            else
                _attunementTimer -= diff;
        }

        void OnSpellClick(Unit* clicker, bool& /*result*/) OVERRIDE
        {
            if (clicker->GetUInt32Value(UNIT_FIELD_FLAGS) & (UNIT_FLAG_PACIFIED | UNIT_FLAG_CONFUSED | UNIT_FLAG_FLEEING | UNIT_FLAG_STUNNED))
                return;
            if (clicker->HasAuraWithMechanic(1 << MECHANIC_POLYMORPH))
                return;

            DoTeleportIfCan(clicker);
        }

        void DoTeleportIfCan(Unit* clicker)
        {
            if (clicker->GetTypeId() != TypeID::TYPEID_PLAYER)
                return;

            if (clicker->HasAura(SPELL_WARLOCK_DEMONIC_GATEWAY_COOLDOWN))
                return;

            if (clicker->HasAura(SPELL_BG_HORDE_FLAG) || clicker->HasAura(SPELL_BG_ALLIANCE_FLAG))
                return;

            Unit* owner = me->GetOwner();
            if (!owner || !clicker->IsInRaidWith(owner))
                return;

            Aura* aura = owner->GetAura(SPELL_WARLOCK_DEMONIC_GATEWAY_AURA);
            if (!aura || !aura->GetCharges() || aura->GetCharges() > 5)
                return;

            bool purple = me->GetEntry() == NPC_WARLOCK_GATEWAY_PURPLE;
            std::list<TempSummon*> others;
            owner->GetSummons(others, purple ? NPC_WARLOCK_GATEWAY_GREEN : NPC_WARLOCK_GATEWAY_PURPLE);
            if (others.empty())
                return;

            uint8 charges = aura->GetCharges();
            Unit* target = others.front();
            me->RemoveAurasDueToSpell(purple ? DemonicGatewayPurpleCharge[charges - 1] : DemonicGatewayGreenCharge[charges - 1]);
            target->RemoveAurasDueToSpell(purple ? DemonicGatewayGreenCharge[charges - 1] : DemonicGatewayPurpleCharge[charges - 1]);

            aura->SetCharges(charges - 1);
            if (AuraEffect* aurEff = aura->GetEffect(EFFECT_0))
                aurEff->SetAmount(charges - 1);

            clicker->NearTeleportTo(me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), me->GetOrientation());

            uint32 teleportSpell = purple ? SPELL_WARLOCK_DEMONIC_GATEWAY_TELE_PURPLE : SPELL_WARLOCK_DEMONIC_GATEWAY_TELE_GREEN;
            uint64 targetGuid = target->GetGUID();
            int32 cooldownReduction = 0;
            if (AuraEffect const* bonus = owner->GetAuraEffect(SPELL_WARLOCK_PVP_SET_4P_BONUS, EFFECT_0))
                cooldownReduction = bonus->GetAmount() * IN_MILLISECONDS;

            clicker->m_Events.Schedule(1, [clicker, targetGuid, teleportSpell, cooldownReduction]()
            {
                Creature* gateway = ObjectAccessor::GetCreature(*clicker, targetGuid);
                if (!gateway)
                    return;

                clicker->CastSpell(gateway, teleportSpell, true);

                if (cooldownReduction)
                {
                    if (Aura* cooldown = clicker->GetAura(SPELL_WARLOCK_DEMONIC_GATEWAY_COOLDOWN))
                    {
                        cooldown->SetMaxDuration(cooldown->GetMaxDuration() - cooldownReduction);
                        cooldown->SetDuration(cooldown->GetMaxDuration());
                    }
                }
            });
        }

        void Unsummoned() OVERRIDE
        {
            if (Unit* owner = me->GetOwner())
                owner->RemoveAurasDueToSpell(SPELL_WARLOCK_DEMONIC_GATEWAY_AURA);
        }

    private:
        uint32 _attunementTimer;
    };

    CreatureAI* GetAI(Creature* creature) const OVERRIDE
    {
        return new npc_demonic_gatewayAI(creature);
    }
};

void AddSC_warlock_pet_scripts()
{
    new npc_doomguard();
    new npc_grimoire_of_service_pet();
    new npc_warl_infernal();
    new npc_wild_imp();
    new npc_demonic_gateway();
}
