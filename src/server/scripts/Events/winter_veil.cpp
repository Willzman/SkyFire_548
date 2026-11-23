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
 * (Legends-of-Azeroth-Pandaria-5.4.8 src/server/scripts/Events/winter_veil.cpp, GPL v2 or later).
 * Mechanical API changes by skyfire_port_plan/tools/loa2sf.ps1, the rest by hand.
 */

#include "ScriptMgr.h"
#include "../Pandaria/pandaria_loa_compat.h"
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
#include "SceneMgr.h"

namespace
{

enum
{
    SPELL_RACER_SLAM_FIND_TARGET            = 49299,
    SPELL_RACER_SLAM_HIT_DESTINATION        = 49302,
    SPELL_RACER_SLAM_HIT_TIMING_MISSILE     = 49324,
    SPELL_RACER_SLAM_DEATH_ROOT_AND_PACIFY  = 49439,
    SPELL_RACER_SLAM_DEATH_SCENE_GET_DEST   = 49353,
    SPELL_RACER_SLAM_DEATH_SCENE_PARENT     = 49337,
    SPELL_RACER_KILL_COUNTER                = 49444,
    SPELL_CANNON_DUMMY                      = 92690,    // Probably wrong spell
    SPELL_CANNON_DAMGE                      = 92694,    // Probably wrong spell

    NPC_CRASHIN_THRASHIN_RACER_BLUE         = 40281,
    NPC_CRASHIN_THRASHIN_RACER_RED          = 27664,
    NPC_CRASHIN_THRASHIN_FLYER              = 73743,
    NPC_CRASHIN_THRASHIN_DUMMY              = 27674,
};

// 49297 - Racer Rocket Slam
class spell_racer_slam_slamming : public SpellScript
{
    PrepareSpellScript(spell_racer_slam_slamming);

    void HandleCast()
    {
        auto check = [this](Unit* target)
        {
            if (!GetCaster()->IsInDist(target, 30))
                return false;
            return GetCaster()->HasInArc(M_PI / 6, target);
        };
        UnitList targets;
        Skyfire::UnitListSearcher<decltype(check)> searcher{ GetCaster(), targets, check };
        GetCaster()->VisitNearbyObject(30, searcher);

        Unit* target = nullptr;
        for (auto&& itr : targets)
        {
            if (itr == GetCaster())
                continue;

            if (itr->GetEntry() == NPC_CRASHIN_THRASHIN_RACER_BLUE || itr->GetEntry() == NPC_CRASHIN_THRASHIN_RACER_RED)
            {
                target = itr->ToUnit();
                break;
            }
            if (itr->GetEntry() == NPC_CRASHIN_THRASHIN_DUMMY)
                target = itr->ToUnit();
        }

        if (target)
        {
            GetCaster()->CastSpell(target, SPELL_RACER_SLAM_HIT_DESTINATION, true);
            GetCaster()->CastSpell(target, SPELL_RACER_SLAM_HIT_TIMING_MISSILE, true);
        }
    }

    void Register() override
    {
        AfterCast += SpellCastFn(spell_racer_slam_slamming::HandleCast);
    }
};

// 49325 - Racer Slam, resolve
class spell_racer_slam_hit_resolve : public SpellScript
{
    PrepareSpellScript(spell_racer_slam_hit_resolve);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        targets.remove_if([this](WorldObject const* target)
        {
            if (target == GetCaster())
                return true;
            return target->GetEntry() != NPC_CRASHIN_THRASHIN_RACER_BLUE && target->GetEntry() != NPC_CRASHIN_THRASHIN_RACER_RED;
        });

        targets.sort(Skyfire::ObjectDistanceOrderPred(GetCaster()));
        if (!targets.empty())
            targets.resize(1);
    }

    void HandleHit(SpellEffIndex)
    {
        GetCaster()->CastSpell(GetHitUnit(), SPELL_RACER_SLAM_DEATH_ROOT_AND_PACIFY, true);
        GetCaster()->CastSpell(GetCaster(), SPELL_RACER_KILL_COUNTER, true);
        GetCaster()->CastSpell(GetHitUnit(), SPELL_RACER_SLAM_DEATH_SCENE_GET_DEST, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_racer_slam_hit_resolve::SelectTarget, EFFECT_0, TARGET_UNIT_DEST_AREA_ENTRY);
        OnEffectHitTarget += SpellEffectFn(spell_racer_slam_hit_resolve::HandleHit, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 49353 - Racer Slam, death scene: car flip Get Dest
// Removes the racer control aura from the owner two seconds after the crash.
class RemoveAuraDelayedEvent : public BasicEvent
{
    public:
        RemoveAuraDelayedEvent(Unit* owner, uint32 spellId) : _owner(owner), _spellId(spellId) { }

        bool Execute(uint64 /*time*/, uint32 /*diff*/) override
        {
            _owner->RemoveAurasDueToSpell(_spellId);
            return true;
        }

    private:
        Unit* _owner;
        uint32 _spellId;
};

class spell_racer_slam_death_scene_car_flip_get_dest : public SpellScript
{
    PrepareSpellScript(spell_racer_slam_death_scene_car_flip_get_dest);

    Position pos;

    void HandleDest(SpellEffIndex)
    {
        pos = GetHitDest()->GetPosition();
    }

    void HandleScript(SpellEffIndex)
    {
        GetHitUnit()->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), SPELL_RACER_SLAM_DEATH_SCENE_PARENT, true);
        if (Unit* player = GetHitUnit()->GetOwner())
        {
            uint32 spellId = GetHitUnit()->GetUInt32Value(UNIT_FIELD_CREATED_BY_SPELL);
            player->m_Events.AddEvent(new RemoveAuraDelayedEvent(player, spellId), player->m_Events.CalculateTime(2 * IN_MILLISECONDS));
        }
    }

    void Register() override
    {
        OnEffectHit += SpellEffectFn(spell_racer_slam_death_scene_car_flip_get_dest::HandleDest, EFFECT_0, SPELL_EFFECT_DUMMY);
        OnEffectHitTarget += SpellEffectFn(spell_racer_slam_death_scene_car_flip_get_dest::HandleScript, EFFECT_1, SPELL_EFFECT_SCRIPT_EFFECT);
    }
};

// 148581 - Rocket Attack
class spell_rocket_attack : public SpellScript
{
    PrepareSpellScript(spell_rocket_attack);

    void SelectTarget(std::list<WorldObject*>& targets)
    {
        if (targets.empty())
            GetCaster()->CastSpell(GetCaster(), SPELL_CANNON_DUMMY, true);
        else
            GetCaster()->CastSpell(GetCaster(), SPELL_CANNON_DAMGE, true);
    }

    void Register() override
    {
        OnObjectAreaTargetSelect += SpellObjectAreaTargetSelectFn(spell_rocket_attack::SelectTarget, EFFECT_0, TARGET_UNIT_CONE_ENTRY);
    }
};

// 73743
struct npc_crashing_thrashin_flyer : public NullCreatureAI
{
    npc_crashing_thrashin_flyer(Creature* c) : NullCreatureAI(c)
    {
        me->AddUnitMovementFlag(MOVEMENTFLAG_FLYING);
        me->SetMaxHealth(100);
        me->SetHealth(100);
        me->setRegeneratingHealth(false);
    }

    void Unsummoned() override
    {
        if (Unit* player = me->GetOwner())
            player->RemoveAurasDueToSpell(me->GetUInt32Value(UNIT_FIELD_CREATED_BY_SPELL));
    }

    void JustDied(Unit* killer) override
    {
        if (Player* player = killer->GetAffectingPlayer())
            player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_KILL_CREATURE, me->GetEntry(), 1, 0, me);
    }
};

} // namespace

void AddSC_event_winter_veil()
{
    new spell_script<spell_racer_slam_slamming>("spell_racer_slam_slamming");
    new spell_script<spell_racer_slam_hit_resolve>("spell_racer_slam_hit_resolve");
    new spell_script<spell_racer_slam_death_scene_car_flip_get_dest>("spell_racer_slam_death_scene_car_flip_get_dest");
    new spell_script<spell_rocket_attack>("spell_rocket_attack");
    new creature_script<npc_crashing_thrashin_flyer>("npc_crashing_thrashin_flyer");
}
