/*
 * This file is part of Project SkyFire https://www.projectskyfire.org.
 * See COPYRIGHT file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 */

/*
 * Small stand-ins for Legends-of-Azeroth-Pandaria-5.4.8 core helpers that the ported
 * Pandaria raid/dungeon scripts call and SkyFire's core doesn't have (PLAN.md P1).
 * Behaviour follows LoA's versions (UnitAI.cpp target selectors, InstanceScript.cpp
 * DoRemoveBloodLustDebuffSpellOnPlayers, Map::GetFirstPlayerInInstance,
 * Creature::FixateOnTarget, WorldObject::IsInAxe), simplified where SkyFire lacks the
 * underlying system (spell history, threat fixate).
 */

#ifndef SKYFIRE_PANDARIA_LOA_COMPAT_H
#define SKYFIRE_PANDARIA_LOA_COMPAT_H

#include "ScriptedCreature.h"
#include "InstanceScript.h"
#include "Player.h"
#include "Pet.h"
#include "Map.h"
#include "ObjectAccessor.h"

namespace LoaCompat
{
    enum Roles
    {
        ROLES_DPS    = 0,
        ROLES_TANK   = 1,
        ROLES_HEALER = 2,
    };

    // ChrSpecialization.dbc ids
    enum Specs
    {
        SPEC_MAGE_ARCANE = 62, SPEC_MAGE_FIRE = 63, SPEC_MAGE_FROST = 64,
        SPEC_PALADIN_HOLY = 65, SPEC_PALADIN_PROTECTION = 66, SPEC_PALADIN_RETRIBUTION = 70,
        SPEC_WARRIOR_ARMS = 71, SPEC_WARRIOR_FURY = 72, SPEC_WARRIOR_PROTECTION = 73,
        SPEC_DRUID_BALANCE = 102, SPEC_DRUID_FERAL = 103, SPEC_DRUID_GUARDIAN = 104, SPEC_DRUID_RESTORATION = 105,
        SPEC_DEATH_KNIGHT_BLOOD = 250, SPEC_DEATH_KNIGHT_FROST = 251, SPEC_DEATH_KNIGHT_UNHOLY = 252,
        SPEC_HUNTER_BEAST_MASTERY = 253, SPEC_HUNTER_MARKSMANSHIP = 254, SPEC_HUNTER_SURVIVAL = 255,
        SPEC_PRIEST_DISCIPLINE = 256, SPEC_PRIEST_HOLY = 257, SPEC_PRIEST_SHADOW = 258,
        SPEC_ROGUE_ASSASSINATION = 259, SPEC_ROGUE_COMBAT = 260, SPEC_ROGUE_SUBTLETY = 261,
        SPEC_SHAMAN_ELEMENTAL = 262, SPEC_SHAMAN_ENHANCEMENT = 263, SPEC_SHAMAN_RESTORATION = 264,
        SPEC_WARLOCK_AFFLICTION = 265, SPEC_WARLOCK_DEMONOLOGY = 266, SPEC_WARLOCK_DESTRUCTION = 267,
        SPEC_MONK_BREWMASTER = 268, SPEC_MONK_WINDWALKER = 269, SPEC_MONK_MISTWEAVER = 270,
    };

    inline uint32 GetSpec(Player const* player)
    {
        return player ? player->GetTalentSpecialization(player->GetActiveSpec()) : 0;
    }

    inline uint32 GetSpecRole(uint32 spec)
    {
        switch (spec)
        {
            case SPEC_PALADIN_PROTECTION: case SPEC_WARRIOR_PROTECTION: case SPEC_DRUID_GUARDIAN:
            case SPEC_DEATH_KNIGHT_BLOOD: case SPEC_MONK_BREWMASTER:
                return ROLES_TANK;
            case SPEC_PALADIN_HOLY: case SPEC_DRUID_RESTORATION: case SPEC_PRIEST_DISCIPLINE:
            case SPEC_PRIEST_HOLY: case SPEC_SHAMAN_RESTORATION: case SPEC_MONK_MISTWEAVER:
                return ROLES_HEALER;
            default:
                return ROLES_DPS;
        }
    }

    inline uint32 GetRole(Player const* player) { return GetSpecRole(GetSpec(player)); }

    inline Player const* SelectablePlayer(WorldObject const* target)
    {
        if (!target)
            return nullptr;
        Player const* player = target->ToPlayer();
        if (!player || player->IsGameMaster())
            return nullptr;
        return player;
    }

    // Casters and ranged (LoA CasterSpecTargetSelector)
    inline bool IsCaster(Player const* p)
    {
        switch (p->getClass())
        {
            case CLASS_MAGE: case CLASS_PRIEST: case CLASS_WARLOCK: case CLASS_HUNTER:
                return true;
            default:
                break;
        }
        uint32 spec = GetSpec(p);
        return spec == SPEC_MONK_MISTWEAVER || spec == SPEC_DRUID_BALANCE || spec == SPEC_DRUID_RESTORATION
            || spec == SPEC_SHAMAN_ELEMENTAL || spec == SPEC_SHAMAN_RESTORATION || spec == SPEC_PALADIN_HOLY;
    }

    // Melee damage dealers (LoA MeeleSpecTargetSelector)
    inline bool IsMelee(Player const* p)
    {
        uint32 spec = GetSpec(p);
        switch (p->getClass())
        {
            case CLASS_ROGUE:        return true;
            case CLASS_WARRIOR:      return spec != SPEC_WARRIOR_PROTECTION;
            case CLASS_PALADIN:      return spec == SPEC_PALADIN_RETRIBUTION;
            case CLASS_MONK:         return spec == SPEC_MONK_WINDWALKER;
            case CLASS_DRUID:        return spec == SPEC_DRUID_FERAL;
            case CLASS_SHAMAN:       return spec == SPEC_SHAMAN_ENHANCEMENT;
            case CLASS_DEATH_KNIGHT: return spec != SPEC_DEATH_KNIGHT_BLOOD;
            default:                 return false;
        }
    }

    // LoA InstanceScript::DoRemoveBloodLustDebuffSpellOnPlayers (cooldown reset part left out:
    // SkyFire has no SpellHistory)
    inline void RemoveBloodLustDebuffs(Map* map)
    {
        static uint32 const debuffs[] = { 57723 /*Exhaustion*/, 57724 /*Sated*/, 80354 /*Temporal Displacement*/, 95809 /*Insanity*/ };
        if (!map)
            return;
        Map::PlayerList const& players = map->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                for (uint32 spell : debuffs)
                {
                    player->RemoveAurasDueToSpell(spell);
                    if (Pet* pet = player->GetPet())
                        pet->RemoveAurasDueToSpell(spell);
                }
    }

    // LoA InstanceScript::GetEncountersDoneCount: bosses done, from SkyFire's completed-encounter mask
    inline uint32 EncountersDone(uint32 completedMask)
    {
        uint32 count = 0;
        for (; completedMask; completedMask &= completedMask - 1)
            ++count;
        return count;
    }

    // LoA Map::GetFirstPlayerInInstance
    inline Player* GetFirstPlayerInInstance(Map* map)
    {
        if (!map)
            return nullptr;
        Map::PlayerList const& players = map->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->IsInWorld() && player->GetGroup())
                    return player;
        if (!players.isEmpty())
            return players.begin()->GetSource();
        return nullptr;
    }

    // LoA Creature::FixateOnTarget, without threat fixate (not in SkyFire): huge threat and taunt immunity
    inline void FixateOnTarget(Creature* me, uint64 targetGUID, uint32 /*timer*/ = 0)
    {
        if (Unit* target = ObjectAccessor::GetUnit(*me, targetGUID))
        {
            me->DeleteThreatList();
            me->AddThreat(target, 10000000.0f);
            if (me->AI())
                me->AI()->AttackStart(target);
            me->ApplySpellImmune(0, IMMUNITY_STATE, SPELL_AURA_MOD_TAUNT, true);
        }
    }

    // LoA WorldObject::IsInAxe: is 'self' on the line from obj1 towards obj2 (within size yards)?
    inline bool IsInAxe(WorldObject const* self, WorldObject const* obj1, WorldObject const* obj2, float size = 0.0f)
    {
        if (!obj1 || !obj2)
            return false;
        float dist = self->GetExactDist2d(obj1->GetPositionX(), obj1->GetPositionY());
        if (!size)
            size = self->GetObjectSize() / 2;
        float angle = obj1->GetAngle(obj2);
        return (size * size) >= self->GetExactDist2dSq(obj1->GetPositionX() + std::cos(angle) * dist, obj1->GetPositionY() + std::sin(angle) * dist);
    }
} // namespace LoaCompat

// LoA UnitAI.h spec target selectors (true = valid target). Usable with remove_if / SelectTarget.
// MeeleSpecTargetSelector and TankSpecTargetSelector live in the core (AI/CoreAI/UnitAI.h) with the same rules.
#define LOA_SPEC_SELECTOR(Name, Test)                                                   \
    struct Name                                                                          \
    {                                                                                    \
        Name(uint32 spellId = 0) : _spellId(spellId) { }                                 \
        bool operator()(WorldObject const* target) const                                 \
        {                                                                                \
            Player const* p = LoaCompat::SelectablePlayer(target);                       \
            if (!p || (_spellId && p->HasAura(_spellId)))                                \
                return false;                                                            \
            return (Test);                                                               \
        }                                                                                \
        uint32 _spellId;                                                                 \
    };

LOA_SPEC_SELECTOR(CasterSpecTargetSelector,  LoaCompat::IsCaster(p))
LOA_SPEC_SELECTOR(DpsSpecTargetSelector,     LoaCompat::GetRole(p) == LoaCompat::ROLES_DPS)
LOA_SPEC_SELECTOR(HealerSpecTargetSelector,  LoaCompat::GetRole(p) == LoaCompat::ROLES_HEALER)
LOA_SPEC_SELECTOR(NonTankSpecTargetSelector, LoaCompat::GetRole(p) != LoaCompat::ROLES_TANK)

#undef LOA_SPEC_SELECTOR

#endif // SKYFIRE_PANDARIA_LOA_COMPAT_H
