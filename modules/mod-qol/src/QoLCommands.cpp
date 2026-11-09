/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* .qol commands (gear, riding) and a .gear shortcut.
*/

#include "QoL.h"
#include "Chat.h"
#include "DBCStores.h"
#include "Group.h"
#include "GroupReference.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "RBAC.h"
#include "ScriptMgr.h"
#include "SharedDefines.h"

#include <algorithm>
#include <cctype>
#include <sstream>
#include <string>
#include <vector>

class qol_world_script : public WorldScript
{
public:
    qol_world_script() : WorldScript("qol_world_script") { }

    void OnConfigLoad(bool /*reload*/) override
    {
        sQoL->LoadConfig();
    }
};

class qol_commandscript : public CommandScript
{
public:
    qol_commandscript() : CommandScript("qol_commandscript") { }

    std::vector<ChatCommand> GetCommands() const override
    {
        static std::vector<ChatCommand> qolCommandTable =
        {
            { "reload", rbac::RBAC_PERM_COMMAND_GM, true,  &HandleQoLReloadCommand,  "", },
            { "gear",   rbac::RBAC_PERM_COMMAND_GM, true,  &HandleGearCommand,       "", },
            { "riding", rbac::RBAC_PERM_COMMAND_GM, true,  &HandleRidingCommand,     "", },
        };
        static std::vector<ChatCommand> commandTable =
        {
            { "qol",  rbac::RBAC_PERM_COMMAND_GM, true, nullptr, "", qolCommandTable },
            { "gear", rbac::RBAC_PERM_COMMAND_GM, true, &HandleGearCommand, "", },
        };
        return commandTable;
    }

    static bool HandleQoLReloadCommand(ChatHandler* handler, char const* /*args*/)
    {
        sQoL->LoadConfig();
        handler->PSendSysMessage("QoL config reloaded (enabled: %s, quality %d-%d, exact: %s).",
            sQoL->IsEnabled() ? "yes" : "no",
            sQoL->GetMinQuality(), sQoL->GetMaxQuality(),
            sQoL->UseExactQuality() ? "yes" : "no");
        return true;
    }

    static bool ParseRoleOrSpecToken(std::string token, int& roleOut, uint32& specOut)
    {
        std::transform(token.begin(), token.end(), token.begin(),
            [](unsigned char c) { return char(std::tolower(c)); });

        roleOut = -1;
        specOut = 0;

        if (token == "tank")
        {
            roleOut = 0;
            return true;
        }
        if (token == "healer" || token == "heal" || token == "heals" || token == "resto" || token == "restoration")
        {
            roleOut = 1;
            return true;
        }
        if (token == "dps" || token == "damage" || token == "dd")
        {
            roleOut = 2;
            return true;
        }

        if (token == "elemental" || token == "ele")
            specOut = SPEC_SHAMAN_ELEMENTAL;
        else if (token == "enhancement" || token == "enh" || token == "enhance")
            specOut = SPEC_SHAMAN_ENHANCEMENT;
        else if (token == "balance" || token == "moonkin" || token == "boomkin" || token == "boomie")
            specOut = SPEC_DRUID_BALANCE;
        else if (token == "feral")
            specOut = SPEC_DRUID_FERAL;
        else if (token == "guardian")
            specOut = SPEC_DRUID_GUARDIAN;
        else if (token == "retribution" || token == "ret")
            specOut = SPEC_PALADIN_RETRIBUTION;
        else if (token == "protection" || token == "prot")
        {
            roleOut = 0;
            return true;
        }
        else if (token == "holy")
        {
            roleOut = 1;
            return true;
        }
        else if (token == "shadow")
            specOut = SPEC_PRIEST_SHADOW;
        else if (token == "discipline" || token == "disc")
            specOut = SPEC_PRIEST_DISCIPLINE;
        else if (token == "windwalker" || token == "ww")
            specOut = SPEC_MONK_WINDWALKER;
        else if (token == "brewmaster" || token == "brm")
            specOut = SPEC_MONK_BREWMASTER;
        else if (token == "mistweaver" || token == "mw")
            specOut = SPEC_MONK_MISTWEAVER;
        else if (token == "beastmastery" || token == "beastmaster" || token == "bm")
            specOut = SPEC_HUNTER_BEAST_MASTERY;
        else if (token == "marksmanship" || token == "marks" || token == "mm")
            specOut = SPEC_HUNTER_MARKSMANSHIP;
        else if (token == "survival" || token == "surv")
            specOut = SPEC_HUNTER_SURVIVAL;
        else if (token == "affliction" || token == "aff")
            specOut = SPEC_WARLOCK_AFFLICTION;
        else if (token == "demonology" || token == "demo")
            specOut = SPEC_WARLOCK_DEMONOLOGY;
        else if (token == "destruction" || token == "destro")
            specOut = SPEC_WARLOCK_DESTRUCTION;
        else if (token == "arcane")
            specOut = SPEC_MAGE_ARCANE;
        else if (token == "fire")
            specOut = SPEC_MAGE_FIRE;
        else if (token == "frost")
            specOut = SPEC_MAGE_FROST;
        else if (token == "arms")
            specOut = SPEC_WARRIOR_ARMS;
        else if (token == "fury")
            specOut = SPEC_WARRIOR_FURY;
        else if (token == "assassination" || token == "mut")
            specOut = SPEC_ROGUE_ASSASSINATION;
        else if (token == "combat")
            specOut = SPEC_ROGUE_COMBAT;
        else if (token == "subtlety" || token == "sub")
            specOut = SPEC_ROGUE_SUBTLETY;
        else if (token == "blood")
            specOut = SPEC_DEATH_KNIGHT_BLOOD;
        else if (token == "unholy")
            specOut = SPEC_DEATH_KNIGHT_UNHOLY;
        else
            return false;

        return specOut != 0;
    }

    static bool SpecMatchesClass(uint32 specId, uint8 cls)
    {
        ChrSpecializationEntry const* entry = sChrSpecializationStore.LookupEntry(specId);
        return entry && entry->classId == cls;
    }

    static bool ParseQualityToken(std::string token, int& qualityOut)
    {
        std::transform(token.begin(), token.end(), token.begin(),
            [](unsigned char c) { return char(std::tolower(c)); });

        if (token.compare(0, 8, "quality=") == 0)
            token = token.substr(8);
        else if (token.compare(0, 2, "q=") == 0)
            token = token.substr(2);
        else if (!token.empty() && token[0] == '=')
            token = token.substr(1);

        if (token == "poor" || token == "grey" || token == "gray" || token == "trash")
            qualityOut = ITEM_QUALITY_POOR;
        else if (token == "common" || token == "white")
            qualityOut = ITEM_QUALITY_NORMAL;
        else if (token == "uncommon" || token == "green")
            qualityOut = ITEM_QUALITY_UNCOMMON;
        else if (token == "rare" || token == "blue")
            qualityOut = ITEM_QUALITY_RARE;
        else if (token == "epic" || token == "purple")
            qualityOut = ITEM_QUALITY_EPIC;
        else if (token == "legendary" || token == "orange")
            qualityOut = ITEM_QUALITY_LEGENDARY;
        else
            return false;

        return true;
    }

    static void SendUsage(ChatHandler* handler)
    {
        handler->SendSysMessage(
            "Usage: .qol gear [self|group|<name>] [tank|healer|dps|<spec>] "
            "[poor|common|uncommon|rare|epic|legendary]");
        handler->SendSysMessage(
            "Shortcut: .gear ...  Replaces equipped gear (except shirt/tabard) "
            "with level-appropriate items for the player's spec.");
    }

    static bool GearOne(ChatHandler* handler, Player* target, int roleOverride,
        uint32 specOverride, int qualityOverride)
    {
        if (specOverride && !SpecMatchesClass(specOverride, target->getClass()))
        {
            handler->PSendSysMessage("That specialization does not match %s's class.",
                target->GetName().c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string report;
        if (!sQoL->GearPlayer(target, roleOverride, specOverride, qualityOverride, &report))
        {
            handler->PSendSysMessage("%s", report.c_str());
            handler->SetSentErrorMessage(true);
            return false;
        }
        handler->PSendSysMessage("%s", report.c_str());
        return true;
    }

    static bool HandleGearCommand(ChatHandler* handler, char const* args)
    {
        if (!sQoL->IsEnabled())
        {
            handler->SendSysMessage("QoL is disabled in qol.conf.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        if (args && *args)
        {
            std::string first(args);
            std::transform(first.begin(), first.end(), first.begin(),
                [](unsigned char c) { return char(std::tolower(c)); });
            if (first == "reload")
                return HandleQoLReloadCommand(handler, "");
        }

        std::vector<std::string> tokens;
        if (args)
        {
            std::istringstream stream(args);
            std::string token;
            while (stream >> token)
                tokens.push_back(token);
        }

        std::string targetName;
        int roleOverride = -1;
        uint32 specOverride = 0;
        int qualityOverride = -1;
        bool gearGroup = false;

        for (std::string const& raw : tokens)
        {
            std::string lower = raw;
            std::transform(lower.begin(), lower.end(), lower.begin(),
                [](unsigned char c) { return char(std::tolower(c)); });

            if (lower == "help" || lower == "?")
            {
                SendUsage(handler);
                return true;
            }
            if (lower == "group" || lower == "party")
            {
                gearGroup = true;
                continue;
            }

            int quality = 0;
            if (ParseQualityToken(raw, quality))
            {
                qualityOverride = quality;
                continue;
            }

            int role = -1;
            uint32 spec = 0;
            if (ParseRoleOrSpecToken(raw, role, spec))
            {
                roleOverride = role;
                specOverride = spec;
                continue;
            }

            if (targetName.empty())
            {
                targetName = raw;
                continue;
            }

            handler->PSendSysMessage("Unknown gear token '%s'.", raw.c_str());
            SendUsage(handler);
            handler->SetSentErrorMessage(true);
            return false;
        }

        Player* sessionPlayer = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;

        if (gearGroup)
        {
            if (!sessionPlayer)
            {
                handler->SendSysMessage("Group gearing must be used in-game.");
                handler->SetSentErrorMessage(true);
                return false;
            }
            Group* group = sessionPlayer->GetGroup();
            if (!group)
            {
                handler->SendSysMessage("You are not in a group.");
                handler->SetSentErrorMessage(true);
                return false;
            }

            uint32 count = 0;
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* member = itr->GetSource();
                if (!member || !member->IsInWorld())
                    continue;
                if (specOverride && !SpecMatchesClass(specOverride, member->getClass()))
                    continue;
                if (GearOne(handler, member, roleOverride, specOverride, qualityOverride))
                    ++count;
            }
            handler->PSendSysMessage("Geared %u grouped player(s).", count);
            return count > 0;
        }

        Player* target = nullptr;
        if (targetName.empty() || targetName == "self"
            || (sessionPlayer && targetName == sessionPlayer->GetName()))
        {
            if (!targetName.empty() && (targetName == "self"
                || (sessionPlayer && targetName == sessionPlayer->GetName())))
                target = sessionPlayer;
            else
            {
                target = handler->getSelectedPlayer();
                if (!target)
                    target = sessionPlayer;
            }
        }
        else
        {
            std::string name = targetName;
            if (!normalizePlayerName(name))
            {
                handler->SendSysMessage("Invalid character name.");
                handler->SetSentErrorMessage(true);
                return false;
            }
            uint64 guid = sObjectMgr->GetPlayerGUIDByName(name);
            target = guid ? ObjectAccessor::FindPlayer(guid) : nullptr;
        }

        if (!target)
        {
            if (!sessionPlayer)
            {
                SendUsage(handler);
                handler->SetSentErrorMessage(true);
                return false;
            }
            handler->SendSysMessage("Player not found or not online.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        return GearOne(handler, target, roleOverride, specOverride, qualityOverride);
    }

    static Player* ResolveOnlineTarget(ChatHandler* handler, std::string const& targetName)
    {
        Player* sessionPlayer = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;
        if (targetName.empty() || targetName == "self"
            || (sessionPlayer && targetName == sessionPlayer->GetName()))
        {
            if (!targetName.empty() && (targetName == "self"
                || (sessionPlayer && targetName == sessionPlayer->GetName())))
                return sessionPlayer;

            Player* selected = handler->getSelectedPlayer();
            return selected ? selected : sessionPlayer;
        }

        std::string name = targetName;
        if (!normalizePlayerName(name))
            return nullptr;
        uint64 guid = sObjectMgr->GetPlayerGUIDByName(name);
        return guid ? ObjectAccessor::FindPlayer(guid) : nullptr;
    }

    static bool HandleRidingCommand(ChatHandler* handler, char const* args)
    {
        if (!sQoL->IsEnabled())
        {
            handler->SendSysMessage("QoL is disabled in qol.conf.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        std::string targetName;
        bool gearGroup = false;
        if (args)
        {
            std::istringstream stream(args);
            std::string token;
            while (stream >> token)
            {
                std::string lower = token;
                std::transform(lower.begin(), lower.end(), lower.begin(),
                    [](unsigned char c) { return char(std::tolower(c)); });
                if (lower == "group" || lower == "party")
                {
                    gearGroup = true;
                    continue;
                }
                if (lower == "help" || lower == "?")
                {
                    handler->SendSysMessage(
                        "Usage: .qol riding [self|group|<name>]");
                    handler->SendSysMessage(
                        "Teaches riding ranks, Flight Master's License, Cold Weather Flying, "
                        "Wisdom of the Four Winds, Cloud Serpent Riding, plus one ground and one flying mount.");
                    return true;
                }
                if (targetName.empty())
                    targetName = token;
                else
                {
                    handler->PSendSysMessage("Unknown riding token '%s'.", token.c_str());
                    handler->SetSentErrorMessage(true);
                    return false;
                }
            }
        }

        Player* sessionPlayer = handler->GetSession() ? handler->GetSession()->GetPlayer() : nullptr;

        auto teachOne = [&](Player* target) -> bool
        {
            std::string report;
            if (!sQoL->TeachRiding(target, &report))
            {
                handler->PSendSysMessage("%s", report.c_str());
                handler->SetSentErrorMessage(true);
                return false;
            }
            handler->PSendSysMessage("%s", report.c_str());
            return true;
        };

        if (gearGroup)
        {
            if (!sessionPlayer)
            {
                handler->SendSysMessage("Group riding must be used in-game.");
                handler->SetSentErrorMessage(true);
                return false;
            }
            Group* group = sessionPlayer->GetGroup();
            if (!group)
            {
                handler->SendSysMessage("You are not in a group.");
                handler->SetSentErrorMessage(true);
                return false;
            }

            uint32 count = 0;
            for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
            {
                Player* member = itr->GetSource();
                if (!member || !member->IsInWorld())
                    continue;
                if (teachOne(member))
                    ++count;
            }
            handler->PSendSysMessage("Updated riding for %u grouped player(s).", count);
            return count > 0;
        }

        Player* target = ResolveOnlineTarget(handler, targetName);
        if (!target)
        {
            if (!sessionPlayer)
            {
                handler->SendSysMessage("Usage: .qol riding [self|group|<name>]");
                handler->SetSentErrorMessage(true);
                return false;
            }
            handler->SendSysMessage("Player not found or not online.");
            handler->SetSentErrorMessage(true);
            return false;
        }

        return teachOne(target);
    }
};

void AddSC_qol()
{
    new qol_world_script();
    new qol_commandscript();
}
