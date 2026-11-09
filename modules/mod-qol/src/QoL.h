/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Quality-of-life GM helpers (gear, riding, and future utilities).
*/

#ifndef SF_PLAYER_QOL_H
#define SF_PLAYER_QOL_H

#include "Common.h"
#include <string>

class Player;

class PlayerQoL
{
public:
    static PlayerQoL* instance();

    void LoadConfig();
    bool IsEnabled() const { return _enabled; }
    int GetMinQuality() const { return _minQuality; }
    int GetMaxQuality() const { return _maxQuality; }
    bool UseExactQuality() const { return _exactQuality; }

    // Equips level-appropriate items for the player's class/spec.
    // roleOverride: -1 keep current, 0 tank, 1 healer, 2 dps.
    // specOverride: 0 keep current specialization; otherwise a ChrSpecialization id.
    // qualityOverride: -1 use conf Min/Max; otherwise ITEM_QUALITY_*.
    bool GearPlayer(Player* player, int roleOverride, uint32 specOverride,
        int qualityOverride, std::string* report = nullptr);

    // Teaches riding ranks + continent flying licenses, then one random
    // ground mount and one random flying mount.
    bool TeachRiding(Player* player, std::string* report = nullptr);

private:
    PlayerQoL() = default;

    bool _enabled = true;
    int _minQuality = 2;   // ITEM_QUALITY_UNCOMMON
    int _maxQuality = 4;   // ITEM_QUALITY_EPIC
    bool _exactQuality = true;
};

#define sQoL PlayerQoL::instance()

#endif
