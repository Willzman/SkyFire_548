/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Quality-of-life helpers: level/spec/quality gear and riding.
*/

#include "QoL.h"
#include "Config.h"
#include "DBCStores.h"
#include "DatabaseEnv.h"
#include "Item.h"
#include "ItemPrototype.h"
#include "Log.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "SharedDefines.h"
#include "SpellInfo.h"
#include "SpellMgr.h"

#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <sstream>
#include <string>
#include <unordered_map>
#include <vector>

PlayerQoL* PlayerQoL::instance()
{
    static PlayerQoL instance;
    return &instance;
}

namespace
{
    // Player Dual Wield (Spell.dbc). Class-specific Dual Wield spells exist
    // but this is the generic one used to fill an off-hand slot.
    uint32 const SPELL_DUAL_WIELD = 674;
    uint32 const SPELL_ARMOR_CLOTH = 9078;
    uint32 const SPELL_ARMOR_LEATHER = 9077;
    uint32 const SPELL_ARMOR_MAIL = 8737;
    uint32 const SPELL_ARMOR_MAIL_PLATE_CLASS = 119811;
    uint32 const SPELL_ARMOR_PLATE = 750;

    enum GearRole { GEAR_ROLE_TANK, GEAR_ROLE_HEALER, GEAR_ROLE_DPS };

    uint8 const TankClasses[]   = { CLASS_WARRIOR, CLASS_PALADIN, CLASS_DEATH_KNIGHT, CLASS_DRUID, CLASS_MONK };
    uint8 const HealerClasses[] = { CLASS_PALADIN, CLASS_PRIEST, CLASS_SHAMAN, CLASS_DRUID, CLASS_MONK };

    char const* RoleName(GearRole role)
    {
        switch (role)
        {
            case GEAR_ROLE_TANK:   return "tank";
            case GEAR_ROLE_HEALER: return "healer";
            default:               return "dps";
        }
    }

    char const* SpecName(uint32 specId)
    {
        switch (specId)
        {
            case SPEC_MAGE_ARCANE:            return "Arcane";
            case SPEC_MAGE_FIRE:              return "Fire";
            case SPEC_MAGE_FROST:             return "Frost";
            case SPEC_PALADIN_HOLY:           return "Holy";
            case SPEC_PALADIN_PROTECTION:     return "Protection";
            case SPEC_PALADIN_RETRIBUTION:    return "Retribution";
            case SPEC_WARRIOR_ARMS:           return "Arms";
            case SPEC_WARRIOR_FURY:           return "Fury";
            case SPEC_WARRIOR_PROTECTION:     return "Protection";
            case SPEC_DRUID_BALANCE:          return "Balance";
            case SPEC_DRUID_FERAL:            return "Feral";
            case SPEC_DRUID_GUARDIAN:         return "Guardian";
            case SPEC_DRUID_RESTORATION:      return "Restoration";
            case SPEC_DEATH_KNIGHT_BLOOD:     return "Blood";
            case SPEC_DEATH_KNIGHT_FROST:     return "Frost";
            case SPEC_DEATH_KNIGHT_UNHOLY:    return "Unholy";
            case SPEC_HUNTER_BEAST_MASTERY:   return "Beast Mastery";
            case SPEC_HUNTER_MARKSMANSHIP:    return "Marksmanship";
            case SPEC_HUNTER_SURVIVAL:        return "Survival";
            case SPEC_PRIEST_DISCIPLINE:      return "Discipline";
            case SPEC_PRIEST_HOLY:            return "Holy";
            case SPEC_PRIEST_SHADOW:          return "Shadow";
            case SPEC_ROGUE_ASSASSINATION:    return "Assassination";
            case SPEC_ROGUE_COMBAT:           return "Combat";
            case SPEC_ROGUE_SUBTLETY:         return "Subtlety";
            case SPEC_SHAMAN_ELEMENTAL:       return "Elemental";
            case SPEC_SHAMAN_ENHANCEMENT:     return "Enhancement";
            case SPEC_SHAMAN_RESTORATION:     return "Restoration";
            case SPEC_WARLOCK_AFFLICTION:     return "Affliction";
            case SPEC_WARLOCK_DEMONOLOGY:     return "Demonology";
            case SPEC_WARLOCK_DESTRUCTION:    return "Destruction";
            case SPEC_MONK_BREWMASTER:        return "Brewmaster";
            case SPEC_MONK_WINDWALKER:        return "Windwalker";
            case SPEC_MONK_MISTWEAVER:        return "Mistweaver";
            default:                          return "None";
        }
    }

    char const* QualityName(int quality)
    {
        switch (quality)
        {
            case ITEM_QUALITY_POOR:      return "poor";
            case ITEM_QUALITY_NORMAL:    return "common";
            case ITEM_QUALITY_UNCOMMON:  return "uncommon";
            case ITEM_QUALITY_RARE:      return "rare";
            case ITEM_QUALITY_EPIC:      return "epic";
            case ITEM_QUALITY_LEGENDARY: return "legendary";
            default:                     return "unknown";
        }
    }

    char const* SafeRaceName(uint8 race)
    {
        char const* name = GetRaceName(race, LOCALE_enUS);
        return name ? name : "?";
    }

    char const* SafeClassName(uint8 cls)
    {
        char const* name = GetClassName(cls, LOCALE_enUS);
        return name ? name : "?";
    }

    std::string ToLowerCopy(std::string value)
    {
        std::transform(value.begin(), value.end(), value.begin(),
            [](unsigned char c) { return char(std::tolower(c)); });
        return value;
    }

    bool ContainsWord(std::string const& haystackLower, std::string const& word)
    {
        if (word.empty() || haystackLower.empty())
            return false;

        size_t pos = 0;
        while ((pos = haystackLower.find(word, pos)) != std::string::npos)
        {
            bool const beforeOk = (pos == 0)
                || !std::isalpha(static_cast<unsigned char>(haystackLower[pos - 1]));
            size_t const end = pos + word.size();
            bool const afterOk = (end >= haystackLower.size())
                || !std::isalpha(static_cast<unsigned char>(haystackLower[end]));
            if (beforeOk && afterOk)
                return true;
            ++pos;
        }
        return false;
    }

    // Designer / QA / art templates are often AllowableClass = -1, so the class
    // bitmask cannot catch them. Names like "59 TEST Green Rogue Legs" and
    // "5.4 Raid - Normal - ..." must be excluded by name.
    bool IsDesignerJunkName(std::string const& nameLower)
    {
        if (nameLower.empty())
            return true;

        auto startsWithDigitDot = [](std::string const& s) -> bool
        {
            if (s.size() < 3 || !std::isdigit(static_cast<unsigned char>(s[0])))
                return false;
            size_t i = 1;
            while (i < s.size() && std::isdigit(static_cast<unsigned char>(s[i])))
                ++i;
            return i < s.size() && s[i] == '.';
        };

        if (startsWithDigitDot(nameLower))
            return true;

        if (ContainsWord(nameLower, "test") || ContainsWord(nameLower, "nyi")
            || ContainsWord(nameLower, "unused") || ContainsWord(nameLower, "placeholder")
            || ContainsWord(nameLower, "wildcard") || ContainsWord(nameLower, "undetermined"))
            return true;

        static char const* const junk[] =
        {
            "qa ",
            " qa",
            "art template",
            "artwork ",
            "monster -",
            "raid - normal",
            "raid - heroic",
            "raid - flex",
            "raid - lfr",
            "raid - looking",
            "boss x loot",
            "zzold",
            "raid d0",
            "ptr ",
            "loot x -",
            "pvprogue",
            "pvpdruid",
            "pvpwarrior",
            "pvpmage",
            "pvppriest",
            "pvpwarlock",
            "pvpshaman",
            "pvphunter",
            "pvppaladin",
            "pvpmonk",
            "pvpdeath",
        };
        for (char const* token : junk)
            if (nameLower.find(token) != std::string::npos)
                return true;

        if (nameLower.compare(0, 3, "ph ") == 0 || nameLower.compare(0, 4, "old ") == 0
            || nameLower.compare(0, 3, "zg ") == 0)
            return true;

        return false;
    }

    bool NameIsForOtherClass(std::string const& nameLower, uint8 cls)
    {
        struct ClassToken { uint8 cls; char const* token; };
        static ClassToken const tokens[] =
        {
            { CLASS_WARRIOR,      "warrior" },
            { CLASS_PALADIN,      "paladin" },
            { CLASS_HUNTER,       "hunter" },
            { CLASS_ROGUE,        "rogue" },
            { CLASS_PRIEST,       "priest" },
            { CLASS_DEATH_KNIGHT, "death knight" },
            { CLASS_DEATH_KNIGHT, "deathknight" },
            { CLASS_SHAMAN,       "shaman" },
            { CLASS_MAGE,         "mage" },
            { CLASS_WARLOCK,      "warlock" },
            { CLASS_MONK,         "monk" },
            { CLASS_DRUID,        "druid" },
        };

        bool hasOwnClass = false;
        bool hasOtherClass = false;
        for (ClassToken const& token : tokens)
        {
            if (!ContainsWord(nameLower, token.token))
                continue;
            if (token.cls == cls)
                hasOwnClass = true;
            else
                hasOtherClass = true;
        }
        return hasOtherClass && !hasOwnClass;
    }

    bool ItemAllowedForPlayer(Player* player, uint32 entry)
    {
        ItemTemplate const* proto = sObjectMgr->GetItemTemplate(entry);
        if (!proto || !player)
            return false;

        if (player->CanUseItem(proto) != EQUIP_ERR_OK)
            return false;

        std::string const nameLower = ToLowerCopy(proto->Name1);
        if (IsDesignerJunkName(nameLower))
            return false;
        if (NameIsForOtherClass(nameLower, player->getClass()))
            return false;

        return true;
    }

    std::string SqlIn(std::initializer_list<uint32> values)
    {
        std::ostringstream out;
        bool first = true;
        for (uint32 value : values)
        {
            if (!first)
                out << ',';
            first = false;
            out << value;
        }
        return out.str();
    }

    std::string WeaponWhere(std::initializer_list<uint32> subclasses, std::initializer_list<uint32> invTypes)
    {
        return "`class`=" + std::to_string(uint32(ITEM_CLASS_WEAPON))
            + " AND subclass IN (" + SqlIn(subclasses) + ")"
            + " AND InventoryType IN (" + SqlIn(invTypes) + ")";
    }

    uint8 SpecTabForRole(uint8 cls, GearRole role)
    {
        switch (cls)
        {
            case CLASS_WARRIOR:      return role == GEAR_ROLE_TANK ? 2 : 0;
            case CLASS_PALADIN:      return role == GEAR_ROLE_TANK ? 1 : (role == GEAR_ROLE_HEALER ? 0 : 2);
            case CLASS_DEATH_KNIGHT: return role == GEAR_ROLE_TANK ? 0 : 1;
            case CLASS_PRIEST:       return role == GEAR_ROLE_HEALER ? 0 : 2;
            case CLASS_SHAMAN:       return role == GEAR_ROLE_HEALER ? 2 : 0;
            case CLASS_MONK:         return role == GEAR_ROLE_TANK ? 0 : (role == GEAR_ROLE_HEALER ? 1 : 2);
            case CLASS_DRUID:        return role == GEAR_ROLE_TANK ? 2 : (role == GEAR_ROLE_HEALER ? 3 : 0);
            case CLASS_HUNTER:       return 0;
            case CLASS_ROGUE:        return 0;
            case CLASS_MAGE:         return 2;
            case CLASS_WARLOCK:      return 0;
            default:                 return 0;
        }
    }

    uint32 SpecIdForRole(uint8 cls, GearRole role)
    {
        uint32 const* specs = GetClassSpecializations(cls);
        if (!specs)
            return 0;
        return specs[SpecTabForRole(cls, role)];
    }

    uint8 ArmorTypeForClass(uint8 cls)
    {
        switch (cls)
        {
            case CLASS_WARRIOR:
            case CLASS_PALADIN:
            case CLASS_DEATH_KNIGHT: return ITEM_SUBCLASS_ARMOR_PLATE;
            case CLASS_HUNTER:
            case CLASS_SHAMAN:       return ITEM_SUBCLASS_ARMOR_MAIL;
            case CLASS_ROGUE:
            case CLASS_DRUID:
            case CLASS_MONK:         return ITEM_SUBCLASS_ARMOR_LEATHER;
            default:                 return ITEM_SUBCLASS_ARMOR_CLOTH;
        }
    }

    uint32 PrimaryStatForClassRole(uint8 cls, GearRole role, uint32 specId)
    {
        switch (specId)
        {
            case SPEC_SHAMAN_ENHANCEMENT:
            case SPEC_DRUID_FERAL:
            case SPEC_DRUID_GUARDIAN:
            case SPEC_HUNTER_BEAST_MASTERY:
            case SPEC_HUNTER_MARKSMANSHIP:
            case SPEC_HUNTER_SURVIVAL:
            case SPEC_ROGUE_ASSASSINATION:
            case SPEC_ROGUE_COMBAT:
            case SPEC_ROGUE_SUBTLETY:
            case SPEC_MONK_WINDWALKER:
            case SPEC_MONK_BREWMASTER:
                return ITEM_MOD_AGILITY;
            case SPEC_SHAMAN_ELEMENTAL:
            case SPEC_SHAMAN_RESTORATION:
            case SPEC_DRUID_BALANCE:
            case SPEC_DRUID_RESTORATION:
            case SPEC_MONK_MISTWEAVER:
                return ITEM_MOD_INTELLECT;
            default:
                break;
        }

        switch (cls)
        {
            case CLASS_WARRIOR:
            case CLASS_DEATH_KNIGHT: return ITEM_MOD_STRENGTH;
            case CLASS_PALADIN:      return role == GEAR_ROLE_HEALER ? ITEM_MOD_INTELLECT : ITEM_MOD_STRENGTH;
            case CLASS_HUNTER:
            case CLASS_ROGUE:        return ITEM_MOD_AGILITY;
            case CLASS_MONK:         return role == GEAR_ROLE_HEALER ? ITEM_MOD_INTELLECT : ITEM_MOD_AGILITY;
            case CLASS_DRUID:
            case CLASS_SHAMAN:
            default:                 return ITEM_MOD_INTELLECT;
        }
    }

    GearRole RoleFromSpec(uint8 cls, uint32 specId)
    {
        if (specId)
        {
            for (uint8 tankClass : TankClasses)
                if (tankClass == cls && specId == SpecIdForRole(cls, GEAR_ROLE_TANK))
                    return GEAR_ROLE_TANK;
            for (uint8 healerClass : HealerClasses)
                if (healerClass == cls && specId == SpecIdForRole(cls, GEAR_ROLE_HEALER))
                    return GEAR_ROLE_HEALER;
        }
        return GEAR_ROLE_DPS;
    }

    std::unordered_map<std::string, std::vector<uint32>> g_itemQueryCache;

    void ClearItemQueryCache()
    {
        g_itemQueryCache.clear();
    }

    std::vector<uint32> QueryItemEntries(Player* player, std::string const& where, uint32 primaryStat,
        uint32 exclude, int minQuality, int maxQuality)
    {
        uint32 const level    = player->getLevel();
        uint32 const classBit = 1u << (player->getClass() - 1);
        uint32 const raceBit  = 1u << (player->getRace() - 1);
        uint32 const minReq   = level > 10 ? (level - 10) : 1;
        int qualityCap = std::max(0, std::min(maxQuality, int(ITEM_QUALITY_LEGENDARY)));
        int qualityMin = std::max(0, std::min(minQuality, qualityCap));

        std::ostringstream key;
        key << "v4|" << where << '|' << level << '|' << classBit << '|' << raceBit << '|'
            << minReq << '|' << qualityMin << '|' << qualityCap << '|' << primaryStat
            << '|' << exclude << '|' << uint32(player->getClass());
        std::string const cacheKey = key.str();
        auto cached = g_itemQueryCache.find(cacheKey);
        if (cached != g_itemQueryCache.end())
            return cached->second;

        std::ostringstream q;
        q << "SELECT entry FROM item_template WHERE " << where
          << " AND RequiredLevel <= " << level
          << " AND RequiredLevel >= " << minReq
          << " AND Quality BETWEEN " << qualityMin << " AND " << qualityCap
          << " AND duration = 0 AND startquest = 0"
          << " AND name NOT LIKE 'QA%'"
          << " AND name NOT LIKE '% TEST %'"
          << " AND name NOT LIKE '%(Test)%'"
          << " AND name NOT LIKE '%(TEST)%'"
          << " AND name NOT LIKE 'ZG %'"
          << " AND name NOT LIKE '%Raid D0%'"
          << " AND name NOT LIKE 'Monster -%'"
          << " AND name NOT LIKE 'Art Template%'"
          << " AND name NOT LIKE 'Artwork %'"
          << " AND name NOT LIKE '5.%'"
          << " AND name NOT LIKE '4.%'"
          << " AND name NOT LIKE '3.%'"
          << " AND name NOT LIKE '% Raid - %'"
          << " AND name NOT LIKE '%Wildcard%'"
          << " AND name NOT LIKE '%Undetermined%'"
          << " AND name NOT LIKE '%Boss X Loot%'"
          << " AND name NOT LIKE '%Placeholder%'"
          << " AND name NOT LIKE 'PH %'"
          << " AND name NOT LIKE '%NYI%'"
          << " AND name NOT LIKE 'ZZOLD%'"
          << " AND (Flags & " << uint32(ITEM_PROTO_FLAG_DEPRECATED) << ") = 0"
          << " AND NOT (Quality >= " << int(ITEM_QUALITY_RARE)
          << " AND ItemLevel < 10 AND RequiredLevel <= 10)"
          << " AND ItemLevel <= " << (level * 8u + 40u)
          << " AND ItemLevel >= " << (level > 5 ? (level > 10 ? level - 5 : 3) : 1)
          << " AND (AllowableClass = -1 OR (AllowableClass & " << classBit << "))"
          << " AND (AllowableRace = -1 OR (AllowableRace & " << raceBit << "))";

        if (exclude)
            q << " AND entry <> " << exclude;

        if (primaryStat)
            q << " AND (stat_type1=" << primaryStat << " OR stat_type2=" << primaryStat
              << " OR stat_type3=" << primaryStat << " OR stat_type4=" << primaryStat
              << " OR stat_type5=" << primaryStat << " OR stat_type6=" << primaryStat
              << " OR stat_type7=" << primaryStat << " OR stat_type8=" << primaryStat
              << " OR stat_type9=" << primaryStat << " OR stat_type10=" << primaryStat << ")";

        // Fetch extra rows so C++ class/junk filters can still leave a pool.
        q << " ORDER BY RequiredLevel DESC, ItemLevel DESC LIMIT 80";

        std::vector<uint32> entries;
        if (QueryResult result = WorldDatabase.Query(q.str().c_str()))
        {
            do
            {
                uint32 const entry = result->Fetch()[0].GetUInt32();
                if (!ItemAllowedForPlayer(player, entry))
                    continue;
                entries.push_back(entry);
                if (entries.size() >= 25)
                    break;
            } while (result->NextRow());
        }
        g_itemQueryCache.emplace(cacheKey, entries);
        return entries;
    }

    void LearnSpellIfMissing(Player* player, uint32 spellId)
    {
        if (!player || !spellId || player->HasSpell(spellId))
            return;
        player->learnSpell(spellId, false);
    }

    void LearnArmorProficiencies(Player* player)
    {
        if (!player)
            return;

        switch (player->getClass())
        {
            case CLASS_PRIEST:
            case CLASS_MAGE:
            case CLASS_WARLOCK:
                LearnSpellIfMissing(player, SPELL_ARMOR_CLOTH);
                break;
            case CLASS_ROGUE:
            case CLASS_DRUID:
            case CLASS_MONK:
                LearnSpellIfMissing(player, SPELL_ARMOR_CLOTH);
                LearnSpellIfMissing(player, SPELL_ARMOR_LEATHER);
                break;
            case CLASS_HUNTER:
            case CLASS_SHAMAN:
                LearnSpellIfMissing(player, SPELL_ARMOR_CLOTH);
                LearnSpellIfMissing(player, SPELL_ARMOR_LEATHER);
                LearnSpellIfMissing(player, SPELL_ARMOR_MAIL);
                break;
            case CLASS_WARRIOR:
            case CLASS_PALADIN:
            case CLASS_DEATH_KNIGHT:
                LearnSpellIfMissing(player, SPELL_ARMOR_CLOTH);
                LearnSpellIfMissing(player, SPELL_ARMOR_LEATHER);
                LearnSpellIfMissing(player, SPELL_ARMOR_MAIL_PLATE_CLASS);
                LearnSpellIfMissing(player, SPELL_ARMOR_PLATE);
                break;
            default:
                break;
        }

        player->UpdateSkillsToMaxSkillsForLevel();
    }

    void EnableDualWield(Player* player)
    {
        LearnSpellIfMissing(player, SPELL_DUAL_WIELD);
        player->SetCanDualWield(true);
    }

    bool EquipItemEntry(Player* player, uint32 entry)
    {
        if (!entry)
            return false;

        uint16 dest = 0;
        if (player->CanEquipNewItem(NULL_SLOT, dest, entry, false) != EQUIP_ERR_OK)
            return false;

        return player->EquipNewItem(dest, entry, true) != nullptr;
    }

    uint32 EquipBestForSlot(Player* player, std::string const& where, uint32 primaryStat, uint32 exclude,
        int minQuality, int maxQuality, bool exactQuality)
    {
        constexpr size_t kRandomPool = 8;
        int tryMax = maxQuality;
        int tryMin = exactQuality ? maxQuality : minQuality;
        int const stopAt = minQuality;

        while (tryMax >= stopAt && tryMin >= 0)
        {
            uint32 const passStats[2] = { primaryStat, 0 };
            int const passes = primaryStat ? 2 : 1;

            for (int p = 0; p < passes; ++p)
            {
                std::vector<uint32> entries = QueryItemEntries(player, where, passStats[p], exclude,
                    tryMin, tryMax);
                if (entries.empty())
                    continue;

                size_t const pool = std::min(entries.size(), kRandomPool);
                for (size_t i = 0; i + 1 < pool; ++i)
                {
                    size_t const j = i + size_t(std::rand() % int(pool - i));
                    std::swap(entries[i], entries[j]);
                }

                for (uint32 entry : entries)
                    if (EquipItemEntry(player, entry))
                        return entry;
            }

            if (!exactQuality)
                break;

            --tryMax;
            tryMin = tryMax;
        }
        return 0;
    }

    void ClearEquipment(Player* player)
    {
        for (uint8 slot = EQUIPMENT_SLOT_START; slot < EQUIPMENT_SLOT_END; ++slot)
        {
            if (slot == EQUIPMENT_SLOT_BODY || slot == EQUIPMENT_SLOT_TABARD)
                continue;
            if (player->GetItemByPos(INVENTORY_SLOT_BAG_0, slot))
                player->DestroyItem(INVENTORY_SLOT_BAG_0, slot, true);
        }
    }

    void GearWeapons(Player* player, GearRole role, uint32 specId, int minQuality, int maxQuality, bool exactQuality)
    {
        uint8 const cls = player->getClass();
        uint32 const primary = PrimaryStatForClassRole(cls, role, specId);

        auto equip = [&](std::string const& where) -> bool
        {
            return EquipBestForSlot(player, where, primary, 0, minQuality, maxQuality, exactQuality) != 0;
        };

        std::string const oneHand = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_AXE, ITEM_SUBCLASS_WEAPON_MACE, ITEM_SUBCLASS_WEAPON_SWORD },
            { INVTYPE_WEAPON, INVTYPE_WEAPONMAINHAND });
        std::string const oneHandBroad = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_AXE, ITEM_SUBCLASS_WEAPON_MACE, ITEM_SUBCLASS_WEAPON_SWORD,
              ITEM_SUBCLASS_WEAPON_FIST_WEAPON, ITEM_SUBCLASS_WEAPON_DAGGER },
            { INVTYPE_WEAPON, INVTYPE_WEAPONMAINHAND, INVTYPE_WEAPONOFFHAND });
        std::string const twoHandStr = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_AXE2, ITEM_SUBCLASS_WEAPON_MACE2, ITEM_SUBCLASS_WEAPON_POLEARM,
              ITEM_SUBCLASS_WEAPON_SWORD2 },
            { INVTYPE_2HWEAPON });
        std::string const twoHandStaffPole = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_POLEARM, ITEM_SUBCLASS_WEAPON_STAFF },
            { INVTYPE_2HWEAPON });
        std::string const staff = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_STAFF },
            { INVTYPE_2HWEAPON });
        std::string const casterOneHand = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_MACE, ITEM_SUBCLASS_WEAPON_DAGGER },
            { INVTYPE_WEAPON, INVTYPE_WEAPONMAINHAND });
        std::string const casterSwordDagger = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_SWORD, ITEM_SUBCLASS_WEAPON_DAGGER },
            { INVTYPE_WEAPON, INVTYPE_WEAPONMAINHAND });
        std::string const shamanOneHand = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_AXE, ITEM_SUBCLASS_WEAPON_MACE, ITEM_SUBCLASS_WEAPON_FIST_WEAPON,
              ITEM_SUBCLASS_WEAPON_DAGGER },
            { INVTYPE_WEAPON, INVTYPE_WEAPONMAINHAND, INVTYPE_WEAPONOFFHAND });
        std::string const druidOneHand = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_MACE, ITEM_SUBCLASS_WEAPON_FIST_WEAPON },
            { INVTYPE_WEAPON, INVTYPE_WEAPONMAINHAND });
        std::string const monkOneHand = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_AXE, ITEM_SUBCLASS_WEAPON_MACE, ITEM_SUBCLASS_WEAPON_SWORD,
              ITEM_SUBCLASS_WEAPON_FIST_WEAPON },
            { INVTYPE_WEAPON, INVTYPE_WEAPONMAINHAND });
        std::string const dagger = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_DAGGER },
            { INVTYPE_WEAPON, INVTYPE_WEAPONMAINHAND, INVTYPE_WEAPONOFFHAND });
        std::string const ranged = WeaponWhere(
            { ITEM_SUBCLASS_WEAPON_BOW, ITEM_SUBCLASS_WEAPON_GUN, ITEM_SUBCLASS_WEAPON_CROSSBOW },
            { INVTYPE_RANGED, INVTYPE_RANGEDRIGHT });
        std::string const shield =
            "`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND subclass=" + std::to_string(uint32(ITEM_SUBCLASS_ARMOR_SHIELD))
            + " AND InventoryType=" + std::to_string(uint32(INVTYPE_SHIELD));
        std::string const held =
            "`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND InventoryType=" + std::to_string(uint32(INVTYPE_HOLDABLE));

        switch (cls)
        {
            case CLASS_HUNTER:
                equip(ranged);
                break;
            case CLASS_WARRIOR:
                if (role == GEAR_ROLE_TANK)
                {
                    if (!equip(oneHand))
                        equip(twoHandStr);
                    equip(shield);
                }
                else if (!equip(twoHandStr))
                {
                    equip(oneHand);
                    equip(shield);
                }
                break;
            case CLASS_PALADIN:
                if (role == GEAR_ROLE_DPS)
                {
                    if (!equip(twoHandStr))
                    {
                        equip(oneHand);
                        equip(shield);
                    }
                }
                else
                {
                    equip(oneHand);
                    equip(shield);
                }
                break;
            case CLASS_DEATH_KNIGHT:
                if (!equip(twoHandStr))
                    equip(oneHand);
                break;
            case CLASS_ROGUE:
                EnableDualWield(player);
                if (specId == SPEC_ROGUE_ASSASSINATION)
                {
                    uint32 const mh = EquipBestForSlot(player, dagger, primary, 0,
                        minQuality, maxQuality, exactQuality);
                    uint32 oh = 0;
                    if (mh)
                        oh = EquipBestForSlot(player, dagger, primary, mh,
                            minQuality, maxQuality, exactQuality);
                    if (!mh)
                        EquipBestForSlot(player, oneHandBroad, primary, 0,
                            minQuality, maxQuality, exactQuality);
                    if (!oh)
                    {
                        uint32 exclude = 0;
                        if (Item* equipped = player->GetItemByPos(INVENTORY_SLOT_BAG_0, EQUIPMENT_SLOT_MAINHAND))
                            exclude = equipped->GetEntry();
                        EquipBestForSlot(player, oneHandBroad, primary, exclude,
                            minQuality, maxQuality, exactQuality);
                    }
                }
                else
                {
                    equip(oneHandBroad);
                    equip(oneHandBroad);
                }
                break;
            case CLASS_SHAMAN:
                if (specId == SPEC_SHAMAN_ENHANCEMENT)
                {
                    EnableDualWield(player);
                    equip(shamanOneHand);
                    equip(shamanOneHand);
                }
                else
                {
                    equip(shamanOneHand);
                    equip(shield);
                }
                break;
            case CLASS_MONK:
                if (!equip(twoHandStaffPole))
                {
                    equip(monkOneHand);
                    equip(held);
                }
                break;
            case CLASS_DRUID:
                if (!equip(twoHandStaffPole))
                {
                    equip(druidOneHand);
                    equip(held);
                }
                break;
            case CLASS_PRIEST:
                if (!equip(staff))
                {
                    equip(casterOneHand);
                    equip(held);
                }
                break;
            case CLASS_MAGE:
            case CLASS_WARLOCK:
                if (!equip(staff))
                {
                    equip(casterSwordDagger);
                    equip(held);
                }
                break;
            default:
                break;
        }
    }

    void GearSlots(Player* player, GearRole role, uint32 specId, int minQuality, int maxQuality, bool exactQuality)
    {
        uint8 const cls = player->getClass();
        uint32 const primary = PrimaryStatForClassRole(cls, role, specId);
        std::string const armorType =
            "`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND subclass=" + std::to_string(uint32(ArmorTypeForClass(cls)));

        ClearEquipment(player);

        auto equipOne = [&](std::string const& where, uint32 exclude) -> uint32
        {
            return EquipBestForSlot(player, where, primary, exclude, minQuality, maxQuality, exactQuality);
        };

        equipOne(armorType + " AND InventoryType=" + std::to_string(uint32(INVTYPE_HEAD)), 0);
        equipOne(armorType + " AND InventoryType=" + std::to_string(uint32(INVTYPE_SHOULDERS)), 0);
        equipOne(armorType + " AND InventoryType IN ("
            + std::to_string(uint32(INVTYPE_CHEST)) + "," + std::to_string(uint32(INVTYPE_ROBE)) + ")", 0);
        equipOne(armorType + " AND InventoryType=" + std::to_string(uint32(INVTYPE_WAIST)), 0);
        equipOne(armorType + " AND InventoryType=" + std::to_string(uint32(INVTYPE_LEGS)), 0);
        equipOne(armorType + " AND InventoryType=" + std::to_string(uint32(INVTYPE_FEET)), 0);
        equipOne(armorType + " AND InventoryType=" + std::to_string(uint32(INVTYPE_WRISTS)), 0);
        equipOne(armorType + " AND InventoryType=" + std::to_string(uint32(INVTYPE_HANDS)), 0);

        equipOne("`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND InventoryType=" + std::to_string(uint32(INVTYPE_NECK)), 0);
        equipOne("`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND InventoryType=" + std::to_string(uint32(INVTYPE_CLOAK)), 0);

        uint32 ring1 = equipOne("`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND InventoryType=" + std::to_string(uint32(INVTYPE_FINGER)), 0);
        equipOne("`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND InventoryType=" + std::to_string(uint32(INVTYPE_FINGER)), ring1);
        uint32 trinket1 = equipOne("`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND InventoryType=" + std::to_string(uint32(INVTYPE_TRINKET)), 0);
        equipOne("`class`=" + std::to_string(uint32(ITEM_CLASS_ARMOR))
            + " AND InventoryType=" + std::to_string(uint32(INVTYPE_TRINKET)), trinket1);

        GearWeapons(player, role, specId, minQuality, maxQuality, exactQuality);
    }
}

namespace
{
    std::string ResolveModuleConfigPath()
    {
        std::string mainConfig = sConfigMgr->GetFilename();
        std::string::size_type slash = mainConfig.find_last_of("/\\");
        std::string directory = (slash != std::string::npos) ? mainConfig.substr(0, slash + 1) : "";
        return directory + "qol.conf";
    }
}

void PlayerQoL::LoadConfig()
{
    std::string configPath = ResolveModuleConfigPath();
    if (!sConfigMgr->LoadMore(configPath.c_str()))
        SF_LOG_ERROR("modules", "[mod-qol] Could not read config file '%s'; using defaults.",
            configPath.c_str());

    _enabled = sConfigMgr->GetBoolDefault("QoL.Enable", true);
    _minQuality = sConfigMgr->GetIntDefault("QoL.Gear.MinQuality", int(ITEM_QUALITY_UNCOMMON));
    _maxQuality = sConfigMgr->GetIntDefault("QoL.Gear.MaxQuality", int(ITEM_QUALITY_EPIC));
    _exactQuality = sConfigMgr->GetBoolDefault("QoL.Gear.ExactQuality", true);

    if (_minQuality < int(ITEM_QUALITY_POOR))
        _minQuality = int(ITEM_QUALITY_POOR);
    if (_maxQuality > int(ITEM_QUALITY_LEGENDARY))
        _maxQuality = int(ITEM_QUALITY_LEGENDARY);
    if (_minQuality > _maxQuality)
        std::swap(_minQuality, _maxQuality);

    ClearItemQueryCache();

    if (_enabled)
        SF_LOG_INFO("modules", "[mod-qol] Enabled (gear quality %s-%s, exact=%s).",
            QualityName(_minQuality), QualityName(_maxQuality), _exactQuality ? "yes" : "no");
    else
        SF_LOG_INFO("modules", "[mod-qol] Disabled via configuration.");
}

bool PlayerQoL::GearPlayer(Player* player, int roleOverride, uint32 specOverride,
    int qualityOverride, std::string* report)
{
    if (!player)
    {
        if (report)
            *report = "No player.";
        return false;
    }

    uint32 specId = 0;
    GearRole role = GEAR_ROLE_DPS;

    if (specOverride)
    {
        if (ChrSpecializationEntry const* entry = sChrSpecializationStore.LookupEntry(specOverride))
        {
            if (entry->classId == player->getClass())
                specId = specOverride;
        }
        if (!specId)
        {
            specId = player->GetTalentSpecialization(player->GetActiveSpec());
            if (!specId)
                specId = SpecIdForRole(player->getClass(), GEAR_ROLE_DPS);
            role = RoleFromSpec(player->getClass(), specId);
        }
        else
            role = RoleFromSpec(player->getClass(), specId);
    }
    else if (roleOverride >= 0)
    {
        role = GearRole(std::min(roleOverride, int(GEAR_ROLE_DPS)));
        specId = SpecIdForRole(player->getClass(), role);
    }
    else
    {
        specId = player->GetTalentSpecialization(player->GetActiveSpec());
        if (!specId)
            specId = SpecIdForRole(player->getClass(), GEAR_ROLE_DPS);
        role = RoleFromSpec(player->getClass(), specId);
    }

    int qualityCap = qualityOverride < 0
        ? _maxQuality
        : std::max(0, std::min(qualityOverride, int(ITEM_QUALITY_LEGENDARY)));
    int qualityFloor = _minQuality;
    bool exact = false;
    if (qualityOverride >= 0 && _exactQuality)
        exact = true;
    else if (qualityOverride >= 0)
        qualityFloor = std::min(qualityFloor, qualityCap);
    if (qualityFloor > qualityCap)
        qualityFloor = qualityCap;

    LearnArmorProficiencies(player);
    GearSlots(player, role, specId, qualityFloor, qualityCap, exact);
    player->SaveToDB();

    std::ostringstream out;
    out << "Geared " << player->GetName()
        << ": level " << uint32(player->getLevel()) << ' '
        << SafeRaceName(player->getRace()) << ' ' << SafeClassName(player->getClass())
        << ", spec " << SpecName(specId) << " (" << RoleName(role) << "), gear ";
    if (exact)
        out << QualityName(qualityCap);
    else
    {
        out << QualityName(qualityFloor);
        if (qualityFloor != qualityCap)
            out << '-' << QualityName(qualityCap);
    }
    out << '.';

    if (report)
        *report = out.str();

    SF_LOG_INFO("modules", "[mod-qol] %s", out.str().c_str());
    return true;
}

namespace
{
    // Trainable riding ranks / licenses (Spell.dbc). The paired "Allows the
    // player to ride..." spells are not the ones trainers teach.
    uint32 const SPELL_APPRENTICE_RIDING = 33388;
    uint32 const SPELL_JOURNEYMAN_RIDING = 33391;
    uint32 const SPELL_EXPERT_RIDING = 34090;
    uint32 const SPELL_ARTISAN_RIDING = 34091;
    uint32 const SPELL_MASTER_RIDING = 90265;
    uint32 const SPELL_FLIGHT_MASTERS_LICENSE = 90267;
    uint32 const SPELL_COLD_WEATHER_FLYING = 54197;
    uint32 const SPELL_WISDOM_OF_THE_FOUR_WINDS = 115913;
    uint32 const SPELL_CLOUD_SERPENT_RIDING = 130487;

    uint32 const AllianceGroundMounts[] = { 458, 470, 472, 6648, 6777, 6898 };
    uint32 const HordeGroundMounts[]    = { 580, 6654, 8395, 10796, 17462, 18989, 34795 };
    uint32 const NeutralGroundMounts[]  = { 30174 };
    uint32 const AllianceFlyingMounts[] = { 32235, 32239, 32240 };
    uint32 const HordeFlyingMounts[]    = { 32243, 32244, 32245 };
    uint32 const NeutralFlyingMounts[]  = { 123992 };

    char const* SpellDisplayName(uint32 spellId)
    {
        if (SpellInfo const* info = sSpellMgr->GetSpellInfo(spellId))
            if (info->SpellName && info->SpellName[0])
                return info->SpellName;
        return "Unknown";
    }

    bool LearnSpellIndependent(Player* player, uint32 spellId)
    {
        if (!player || !spellId)
            return false;
        if (player->HasSpell(spellId))
            return false;
        if (!sSpellMgr->GetSpellInfo(spellId))
            return false;
        player->learnSpell(spellId, false);
        return true;
    }

    uint32 LearnRandomMount(Player* player, uint32 const* primary, size_t primaryCount,
        uint32 const* fallback, size_t fallbackCount)
    {
        if (!player)
            return 0;

        auto tryPool = [&](uint32 const* list, size_t count) -> uint32
        {
            if (!list || !count)
                return 0;

            std::vector<uint32> shuffled(list, list + count);
            for (size_t i = shuffled.size(); i > 1; --i)
                std::swap(shuffled[i - 1], shuffled[std::rand() % i]);

            for (uint32 mount : shuffled)
            {
                if (!mount || player->HasSpell(mount) || !player->IsSpellFitByClassAndRace(mount))
                    continue;
                player->learnSpell(mount, false);
                return mount;
            }
            return 0;
        };

        if (uint32 mount = tryPool(primary, primaryCount))
            return mount;
        if (uint32 mount = tryPool(fallback, fallbackCount))
            return mount;

        auto alreadyHas = [&](uint32 const* list, size_t count) -> uint32
        {
            for (size_t i = 0; i < count; ++i)
                if (list[i] && player->HasSpell(list[i]))
                    return list[i];
            return 0;
        };

        if (uint32 existing = alreadyHas(primary, primaryCount))
            return existing;
        return alreadyHas(fallback, fallbackCount);
    }
}

bool PlayerQoL::TeachRiding(Player* player, std::string* report)
{
    if (!player)
    {
        if (report)
            *report = "No player.";
        return false;
    }

    struct RidingSpell { uint32 id; };
    RidingSpell const ranks[] =
    {
        { SPELL_APPRENTICE_RIDING },
        { SPELL_JOURNEYMAN_RIDING },
        { SPELL_EXPERT_RIDING },
        { SPELL_ARTISAN_RIDING },
        { SPELL_MASTER_RIDING },
        { SPELL_FLIGHT_MASTERS_LICENSE },
        { SPELL_COLD_WEATHER_FLYING },
        { SPELL_WISDOM_OF_THE_FOUR_WINDS },
        { SPELL_CLOUD_SERPENT_RIDING },
    };

    uint32 learnedRanks = 0;
    for (RidingSpell const& rank : ranks)
        if (LearnSpellIndependent(player, rank.id))
            ++learnedRanks;

    bool const alliance = player->GetTeam() == ALLIANCE;
    uint32 const ground = alliance
        ? LearnRandomMount(player, AllianceGroundMounts, sizeof(AllianceGroundMounts) / sizeof(AllianceGroundMounts[0]),
            NeutralGroundMounts, sizeof(NeutralGroundMounts) / sizeof(NeutralGroundMounts[0]))
        : LearnRandomMount(player, HordeGroundMounts, sizeof(HordeGroundMounts) / sizeof(HordeGroundMounts[0]),
            NeutralGroundMounts, sizeof(NeutralGroundMounts) / sizeof(NeutralGroundMounts[0]));
    uint32 const flying = alliance
        ? LearnRandomMount(player, AllianceFlyingMounts, sizeof(AllianceFlyingMounts) / sizeof(AllianceFlyingMounts[0]),
            NeutralFlyingMounts, sizeof(NeutralFlyingMounts) / sizeof(NeutralFlyingMounts[0]))
        : LearnRandomMount(player, HordeFlyingMounts, sizeof(HordeFlyingMounts) / sizeof(HordeFlyingMounts[0]),
            NeutralFlyingMounts, sizeof(NeutralFlyingMounts) / sizeof(NeutralFlyingMounts[0]));

    player->SaveToDB();

    std::ostringstream out;
    out << "Riding for " << player->GetName() << ':';
    if (learnedRanks)
        out << " taught " << learnedRanks << " new skill(s)/license(s).";
    else
        out << " skills already known.";
    if (ground)
        out << " Ground mount: " << SpellDisplayName(ground) << '.';
    else
        out << " No usable ground mount found.";
    if (flying)
        out << " Flying mount: " << SpellDisplayName(flying) << '.';
    else
        out << " No usable flying mount found.";

    if (report)
        *report = out.str();

    SF_LOG_INFO("modules", "[mod-qol] %s", out.str().c_str());
    return true;
}
