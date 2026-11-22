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
#include "ScriptedEscortAI.h"
#include "InstanceScript.h"
#include "Player.h"
#include "Pet.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "DBCStores.h"
#include "DynamicObject.h"
#include "MoveSplineInit.h"
#include "SpellAuras.h"
#include "SpellScript.h"
#include "Spell.h"
#include "SpellMgr.h"
#include "SpellCalculations.h"
#include "Weather.h"
#include "WorldPacket.h"
#include "Opcodes.h"

namespace LoaCompat
{
    // LoA phase masks. SkyFire phases by phase id and ignores the mask, so LoA's SetPhaseMask hid nothing. Each mask bit
    // above bit 0 becomes a private phase id (LOA_PHASE_BASE + bit, no Phase.dbc id is that high); bit 0 is the normal
    // world (169, the fallback phase). Mask 1: no phase (seen by everyone); 256: only in phase LOA_PHASE_BASE + 8, i.e.
    // hidden from players; 17: 169 plus LOA_PHASE_BASE + 4 (still seen by everyone). Spawns hidden in LoA's DB
    // (phaseMask 256) get `phaseId` LOA_PHASE_BASE + 8 in our SQL.
    static uint32 const LOA_PHASE_BASE = 990000;
    inline void SetPhaseMask(WorldObject* obj, uint32 mask, bool update)
    {
        if (!obj)
            return;
        obj->SetPhaseMask(mask, false);
        bool hadLoaPhase = false;
        for (uint32 bit = 1; bit < 32; ++bit)
            if (obj->IsPhased(LOA_PHASE_BASE + bit))
            {
                hadLoaPhase = true;
                obj->SetPhased(LOA_PHASE_BASE + bit, false, false);
            }
        bool other = (mask & ~1u) != 0;
        if (other)
        {
            for (uint32 bit = 1; bit < 32; ++bit)
                if (mask & (1u << bit))
                    obj->SetPhased(LOA_PHASE_BASE + bit, false, true);
            if (mask & 1)
                obj->SetPhased(169, false, true);
            else if (obj->IsPhased(169))
                obj->SetPhased(169, false, false);
        }
        else if (hadLoaPhase && obj->IsPhased(169))
            obj->SetPhased(169, false, false);
        if (update && obj->IsInWorld())
            obj->UpdateObjectVisibility();
    }
    // LoA InstanceScript::DoNearTeleportPlayers
    inline void NearTeleportPlayers(InstanceScript* instance, Position const& pos, bool casting = false)
    {
        if (!instance || !instance->instance)
            return;
        Map::PlayerList const& players = instance->instance->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                player->NearTeleportTo(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), pos.GetOrientation(), casting);
    }

    // LoA InstanceScript::DoStartMovie (the instance script's OnMovieEnded runs when each player's client ends it)
    inline void StartMovie(InstanceScript* instance, uint32 movieId)
    {
        if (!instance || !instance->instance)
            return;
        Map::PlayerList const& players = instance->instance->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                player->SendMovieStart(movieId);
    }

    // LoA Unit::RemoveAuraFromStack with a stack count
    inline void RemoveAuraFromStack(Unit* unit, uint32 spellId, uint64 casterGUID, AuraRemoveMode mode, uint32 num)
    {
        if (!unit)
            return;
        for (uint32 i = 0; i < num && unit->HasAura(spellId, casterGUID); ++i)
            unit->RemoveAuraFromStack(spellId, casterGUID, mode);
    }

    // LoA InstanceScript::DoRemoveAuraFromStackOnPlayers
    inline void RemoveAuraFromStackOnPlayers(InstanceScript* instance, uint32 spellId, uint64 casterGUID = 0, AuraRemoveMode mode = AURA_REMOVE_BY_DEFAULT, uint32 num = 1)
    {
        if (!instance || !instance->instance)
            return;
        Map::PlayerList const& players = instance->instance->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                RemoveAuraFromStack(player, spellId, casterGUID, mode, num);
    }

    // LoA InstanceScript::DoSetAlternatePowerOnPlayers (named apart from the MoP raid branches' copy)
    inline void SetAltPowerOnPlayers(InstanceScript* instance, int32 value)
    {
        if (!instance || !instance->instance)
            return;
        Map::PlayerList const& players = instance->instance->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                player->SetPower(POWER_ALTERNATE_POWER, value);
    }

    // LoA WorldObject::IsSpawnedInLFRDungeon: SkyFire has its own raid finder difficulty
    inline bool IsSpawnedInLFRDungeon(WorldObject const* obj)
    {
        Map const* map = obj ? obj->FindMap() : NULL;
        return map && map->IsRaid() && map->GetDifficulty() == DIFFICULTY_25MAN_LFR;
    }

    // LoA ScriptedAI::CheckInArea: evade when the creature leaves its area
    inline bool CheckInArea(Creature* me, uint32 areaId)
    {
        if (me->GetAreaId() != areaId)
        {
            me->AI()->EnterEvadeMode();
            return false;
        }
        return true;
    }

    // LoA Unit::ApplyUberImmune: immune to the movement-impairing and loss-of-control mechanics (except disarm)
    inline void ApplyUberImmune(Unit* unit, uint32 spellId, bool apply)
    {
        if (!unit)
            return;
        if (apply)
            unit->RemoveAurasWithMechanic(IMMUNE_TO_MOVEMENT_IMPAIRMENT_AND_LOSS_CONTROL_MASK, AURA_REMOVE_BY_DEFAULT, spellId);
        for (uint32 mech = MECHANIC_CHARM; mech != MECHANIC_WOUNDED; ++mech)
            if (mech != MECHANIC_DISARM && ((1 << mech) & IMMUNE_TO_MOVEMENT_IMPAIRMENT_AND_LOSS_CONTROL_MASK))
                unit->ApplySpellImmune(spellId, IMMUNITY_MECHANIC, mech, apply);
    }
    // LoA Position::NormalizePitch
    inline float NormalizePitch(float o)
    {
        if (o > -float(M_PI) && o < float(M_PI))
            return o;
        return Position::NormalizeOrientation(o + float(M_PI)) - float(M_PI);
    }

    // LoA InstanceScript::DoKilledMonsterKredit: quest credit for every player in the instance who has the quest
    inline void DoKilledMonsterKredit(InstanceScript* instance, uint32 questId, uint32 entry, uint64 guid = 0)
    {
        if (!instance || !instance->instance)
            return;
        Map::PlayerList const& players = instance->instance->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->GetQuestStatus(questId) == QUEST_STATUS_INCOMPLETE)
                    player->KilledMonsterCredit(entry, guid);
    }

    // LoA InstanceScript::DoModifyPlayerCurrencies
    inline void DoModifyPlayerCurrencies(InstanceScript* instance, uint32 id, int32 value)
    {
        if (!instance || !instance->instance)
            return;
        Map::PlayerList const& players = instance->instance->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                player->ModifyCurrency(id, value);
    }

    // LoA instance scripts keep door data in a std::vector; SkyFire's LoadDoorData wants a {0}-terminated array.
    inline DoorData const* TerminatedDoorData(std::vector<DoorData>& data)
    {
        if (data.empty() || data.back().entry != 0)
        {
            DoorData end = { 0, 0, DOOR_TYPE_ROOM, 0 };
            data.push_back(end);
        }
        return &data[0];
    }

    // ...and LoA's door arrays have no terminator either: copy them once into a terminated vector.
    template<size_t N>
    inline DoorData const* TerminatedDoorData(DoorData const (&data)[N])
    {
        static std::map<DoorData const*, std::vector<DoorData> > copies;   // per array (two arrays can have the same size)
        std::vector<DoorData>& copy = copies[&data[0]];
        if (copy.empty())
        {
            copy.assign(data, data + N);
            if (copy.back().entry != 0)
            {
                DoorData end = { 0, 0, DOOR_TYPE_ROOM, 0 };
                copy.push_back(end);
            }
        }
        return &copy[0];
    }
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
    // LoA MotionMaster::MoveSplinePath: one spline from the current position through the given points
    inline void MoveSplinePath(Unit* owner, Position const* path, uint32 count, bool fly, bool walk, float speed, bool cyclic = false)
    {
        if (owner->isMoving())
            owner->StopMoving();

        Movement::MoveSplineInit init(owner);
        init.Path().push_back(G3D::Vector3(owner->GetPositionX(), owner->GetPositionY(), owner->GetPositionZ()));
        for (uint32 i = 0; i < count; ++i)
            init.Path().push_back(G3D::Vector3(path[i].GetPositionX(), path[i].GetPositionY(), path[i].GetPositionZ()));

        init.SetWalk(walk);
        if (fly)
            init.SetFly();
        if (cyclic)
            init.SetCyclic();
        if (speed)
            init.SetVelocity(speed);
        init.Launch();
    }

    // LoA WorldObject::GetWMOAreaId: WMOAreaTable.dbc id of the WMO group the object stands in (0 = none)
    inline uint32 GetWMOAreaId(WorldObject const* obj)
    {
        uint32 mogpFlags;
        int32 adtId, rootId, groupId;
        if (obj->GetMap()->GetAreaInfo(obj->GetPositionX(), obj->GetPositionY(), obj->GetPositionZ(), mogpFlags, adtId, rootId, groupId))
            if (WMOAreaTableEntry const* wmoEntry = GetWMOAreaTableEntryByTripple(rootId, adtId, groupId))
                return wmoEntry->Id;
        return 0;
    }

    // LoA UnitAI::DoCast(SelectAggroTarget, ...): cast on a selected target, falling back to an
    // easier selection (first position, then any distance) when nothing matches
    inline void DoCastSelected(UnitAI* ai, Unit* me, SelectAggroTarget targetType, uint32 spellId, bool triggered = false,
        uint32 position = 0, float dist = 0.0f, bool playerOnly = true, int32 aura = 0)
    {
        Unit* target = ai->SelectTarget(targetType, position, dist, playerOnly, aura);
        if (!target)
        {
            if (position)
                target = ai->SelectTarget(targetType, 0, dist, playerOnly, aura);
            else if (dist > 0.0f)
                target = ai->SelectTarget(targetType, position, 0.0f, playerOnly, aura);
        }

        if (target)
            me->CastSpell(target, spellId, triggered);
    }

    // LoA Unit::GetFirstMinionByEntry: first summoned creature with this entry that the unit controls.
    inline Unit* GetFirstMinionByEntry(Unit* owner, uint32 entry)
    {
        for (Unit::ControlList::const_iterator itr = owner->m_Controlled.begin(); itr != owner->m_Controlled.end(); ++itr)
            if ((*itr)->GetEntry() == entry && (*itr)->ToCreature() && (*itr)->ToCreature()->IsSummon())
                return *itr;
        return NULL;
    }

    // LoA GetFarthestPlayerInArea (ScriptedCreature): farthest non-GM player within range.
    inline Player* GetFarthestPlayerInArea(WorldObject* owner, float range)
    {
        Player* farthest = NULL;
        float dist = 0.0f;
        std::list<Player*> players;
        GetPlayerListInGrid(players, owner, range);
        for (std::list<Player*>::const_iterator itr = players.begin(); itr != players.end(); ++itr)
        {
            if ((*itr)->IsGameMaster())
                continue;
            float d = (*itr)->GetDistance2d(owner);
            if (d > dist)
            {
                dist = d;
                farthest = *itr;
            }
        }
        return farthest;
    }

    // LoA WorldObject::GetRandomPoint(pos, dist) returning the point.
    inline Position RandomPoint(WorldObject const* obj, Position const& center, float dist)
    {
        Position pos;
        obj->GetRandomPoint(center, dist, pos);
        return pos;
    }

    // LoA Unit::CastSpell(Position const&, ...): cast at a position.
    inline void CastAtPos(Unit* caster, Position const& pos, uint32 spellId, bool triggered)
    {
        caster->CastSpell(pos.GetPositionX(), pos.GetPositionY(), pos.GetPositionZ(), spellId, triggered);
    }

    // LoA Unit::CastCustomSpell(x, y, z, spellId, bp0, bp1, bp2, triggered): cast at a position with base points.
    inline void CastCustomAtPos(Unit* caster, float x, float y, float z, uint32 spellId, int32 const* bp0, int32 const* bp1, int32 const* bp2, bool triggered)
    {
        SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(spellId);
        if (!spellInfo)
            return;
        SpellCastTargets targets;
        targets.SetDst(x, y, z, caster->GetOrientation());
        CustomSpellValues values;
        if (bp0) values.AddSpellMod(SPELLVALUE_BASE_POINT0, *bp0);
        if (bp1) values.AddSpellMod(SPELLVALUE_BASE_POINT1, *bp1);
        if (bp2) values.AddSpellMod(SPELLVALUE_BASE_POINT2, *bp2);
        caster->CastSpell(targets, spellInfo, &values, triggered ? TRIGGERED_FULL_MASK : TRIGGERED_NONE);
    }

    // LoA InstanceScript::DoSetAlternatePowerOnPlayers.
    inline void SetAlternatePowerOnPlayers(InstanceScript* instance, int32 value)
    {
        if (!instance || !instance->instance)
            return;
        Map::PlayerList const& players = instance->instance->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                player->SetPower(POWER_ALTERNATE_POWER, value);
    }

    // LoA AuraScript::SetGuid / Aura::SetScriptGuid: aura scripts that take the call derive from AuraGuidHook too.
    struct AuraGuidHook
    {
        virtual ~AuraGuidHook() { }
        virtual void SetGuid(uint32 type, uint64 guid) = 0;
    };

    inline void SetScriptGuid(Aura* aura, uint32 type, uint64 guid)
    {
        if (!aura)
            return;
        for (std::list<AuraScript*>::iterator itr = aura->m_loadedScripts.begin(); itr != aura->m_loadedScripts.end(); ++itr)
            if (AuraGuidHook* hook = dynamic_cast<AuraGuidHook*>(*itr))
                hook->SetGuid(type, guid);
    }

    // LoA IAreaTriggerAura::IsInBox: target inside an axis-aligned box around the trigger's caster.
    inline bool IsInBox(Unit* center, Unit* target, float extentsX, float extentsY, float extentsZ)
    {
        if (!center || !target)
            return false;
        return std::fabs(target->GetPositionX() - center->GetPositionX()) <= extentsX
            && std::fabs(target->GetPositionY() - center->GetPositionY()) <= extentsY
            && std::fabs(target->GetPositionZ() - center->GetPositionZ()) <= extentsZ / 2.0f;
    }

    // LoA Map::SetZoneMusic / SetZoneWeather / SetZoneOverrideLight. SkyFire's Map keeps no per-zone state, so these
    // only send the packet to the players who are in the zone now: a player who enters later does not get it.
    inline void SendZonePacket(Map* map, uint32 zoneId, WorldPacket* data)
    {
        if (!map)
            return;
        Map::PlayerList const& players = map->GetPlayers();
        for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            if (Player* player = itr->GetSource())
                if (player->GetZoneId() == zoneId)
                    player->SendDirectMessage(data);
    }

    inline void SetZoneMusic(Map* map, uint32 zoneId, uint32 musicId)
    {
        WorldPacket data(SMSG_PLAY_MUSIC, 4);
        data << uint32(musicId);
        SendZonePacket(map, zoneId, &data);
    }

    inline void SetZoneWeather(Map* map, uint32 zoneId, WeatherState weatherId, float intensity)
    {
        WorldPacket data(SMSG_WEATHER, 4 + 4 + 1);
        data << uint32(weatherId);
        data << float(intensity);
        data.WriteBit(false);              // Abrupt
        data.FlushBits();
        SendZonePacket(map, zoneId, &data);
    }

    // transitionTime in milliseconds; overrideLightId 0 goes back to the area's own light.
    inline void SetZoneOverrideLight(Map* map, uint32 zoneId, uint32 areaLightId, uint32 overrideLightId, uint32 transitionTime)
    {
        WorldPacket data(SMSG_OVERRIDE_LIGHT, 12);
        data << uint32(areaLightId);       // Light.dbc entry (map default)
        data << uint32(overrideLightId);   // Light.dbc entry (override)
        data << uint32(transitionTime);
        SendZonePacket(map, zoneId, &data);
    }

    // Does the creature have the power for this spell (first SpellPower.dbc row that applies)? For CasterMovement.
    inline bool HasPowerFor(Creature* me, SpellInfo const* spell)
    {
        if (!spell)
            return false;
        for (uint32 i = 0; i < sSpellPowerStore.GetNumRows(); ++i)
        {
            SpellPowerEntry const* spellPower = sSpellPowerStore.LookupEntry(i);
            if (!spellPower || spellPower->spellId != spell->Id)
                continue;
            if (spellPower->ShapeShiftSpellID && !me->HasAura(spellPower->ShapeShiftSpellID))
                continue;
            if (spellPower->powerType > uint32(POWER_ENERGY))
                return true;
            Powers power = Powers(spellPower->powerType);
            Skyfire::Spells::SpellPowerCostCalculationData costData =
            {
                spellPower->manaCost,
                spellPower->manaPerSecond,
                spellPower->ManaCostPercentageFloat,
                spellPower->ChannelCostPercentageFloat,
                int32(power),
                me->GetCreateHealth(),
                power == POWER_MANA ? me->GetCreateMana() : uint32(me->GetMaxPower(power))
            };
            return uint32(me->GetPower(power)) >= Skyfire::Spells::CalculateSpellPowerCosts(costData).PowerCost;
        }
        return true;
    }

} // namespace LoaCompat

// LoA CasterMovement (ScriptedCreature.h): keeps a caster at spell range, and sends it into melee when it is silenced,
// out of power or has every listed spell on cooldown.
class CasterMovement
{
    public:
        CasterMovement(Creature* me, uint32 updateInterval = 500) : _me(me), _updateInterval(updateInterval) { }
        virtual ~CasterMovement() { }

        virtual void Chase(Unit* target) { UpdateMovement(target, true); }

        virtual void Update(uint32 diff, Unit* victim = NULL)
        {
            if (_me->HasUnitState(UNIT_STATE_CASTING | UNIT_STATE_LOST_CONTROL))
                return;

            if (_movementUpdateTimer > diff)
            {
                _movementUpdateTimer -= diff;
                return;
            }
            _movementUpdateTimer = _updateInterval;

            if (!victim && !(victim = _me->GetVictim()))
            {
                if (_me->IsGuardian())
                {
                    if (_me->GetMotionMaster()->GetCurrentMovementGeneratorType() == FOLLOW_MOTION_TYPE)
                        return;

                    _chasingInMelee = false;
                    if (Unit* owner = _me->GetOwner())
                        _me->GetMotionMaster()->MoveFollow(owner, PET_FOLLOW_DIST, _me->GetFollowAngle());
                }
                return;
            }

            UpdateMovement(victim);
        }

        bool IsChasingInMelee() const { return _chasingInMelee; }
        bool IsUnableToCast() const { return _unableToCast; }

        CasterMovement& Spell(uint32 spellId)
        {
            CasterDistanceBySpell(spellId, !_spells.empty());
            _spells.push_back(spellId);
            return *this;
        }
        CasterMovement& MeleeDistance(float distance) { _meleeDistance = distance; return *this; }
        CasterMovement& CasterDistance(float distance) { _casterDistance = distance; return *this; }
        CasterMovement& CasterDistanceBySpell(uint32 spellId, bool onlyCloser = false)
        {
            // LoA asserts on an unknown spell; here it keeps the current distance
            if (SpellInfo const* spell = sSpellMgr->GetSpellInfo(spellId))
                if (float range = spell->GetMaxRange(false, _me))
                    if (!onlyCloser || _casterDistance > range - 5.0f)
                        _casterDistance = std::max(NOMINAL_MELEE_RANGE, range - 5.0f); // 5 yards less: spells measure range from the combat reach
            return *this;
        }
        CasterMovement& MeleeWhenUnableToCast(bool on = true) { _meleeWhenUnableToCast = on; return *this; }

    protected:
        Creature* _me;
        uint32 _updateInterval;

        std::vector<uint32> _spells;
        float _meleeDistance = 0.0f;
        float _casterDistance = 30.0f;
        bool _meleeWhenUnableToCast = true;

        uint32 _movementUpdateTimer = 0;
        bool _chasingInMelee = false;
        bool _unableToCast = false;

        void UpdateMovement(Unit* target, bool force = false)
        {
            _unableToCast = false;
            if (_meleeWhenUnableToCast)
            {
                _unableToCast = _me->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_SILENCED);
                if (!_unableToCast && !_spells.empty())
                {
                    _unableToCast = true;
                    for (uint32 spell : _spells)
                        if (!_me->HasSpellCooldown(spell) && LoaCompat::HasPowerFor(_me, sSpellMgr->GetSpellInfo(spell)))
                        {
                            _unableToCast = false;
                            break;
                        }
                }
            }

            if (!_unableToCast)
            {
                if (_chasingInMelee || force)
                {
                    if (!_me->GetMotionMaster()->GetMotionSlot(MOTION_SLOT_CONTROLLED))
                        _me->StopMoving();
                    _me->GetMotionMaster()->MoveChase(target, _casterDistance, 0.0f);
                    _chasingInMelee = false;
                }
            }
            else if (!_chasingInMelee || force)
            {
                if (!_me->GetMotionMaster()->GetMotionSlot(MOTION_SLOT_CONTROLLED))
                    _me->StopMoving();
                _me->GetMotionMaster()->MoveChase(target, std::max(0.01f, _meleeDistance));
                _chasingInMelee = true;
            }
        }
};

// LoA EscortAI (ScriptedEscortAI.h) is SkyFire's npc_escortAI with two differences: WaypointReached also gets a path
// id and is optional, and Start has no run argument (the script calls SetRun, before or after Start).
struct EscortAI : public npc_escortAI
{
    explicit EscortAI(Creature* creature) : npc_escortAI(creature), _run(false) { }

    virtual void WaypointReached(uint32 /*waypointId*/, uint32 /*pathId*/) { }
    void WaypointReached(uint32 pointId) override { WaypointReached(pointId, 0); }

    void SetRun(bool on = true)
    {
        _run = on;
        npc_escortAI::SetRun(on);
    }

    void Start(bool isActiveAttacker = true, uint64 playerGUID = 0, Quest const* quest = NULL, bool instantRespawn = false, bool canLoopPath = false)
    {
        npc_escortAI::Start(isActiveAttacker, _run, playerGUID, quest, instantRespawn, canLoopPath);
    }

    private:
        bool _run;
};

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
