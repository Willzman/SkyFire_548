/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

#ifndef SKYFIRE_BUGREPORTHANDLER_H
#define SKYFIRE_BUGREPORTHANDLER_H

#include <string>

class Player;

// The Bug Report addon (shipped with the launcher) whispers itself with this
// prefix. See BugReportHandler.cpp for the messages.
#define BUG_REPORT_ADDON_PREFIX "SFBUG"

namespace BugReport
{
    // Handles one SFBUG addon message from the player and answers it.
    void HandleAddonMessage(Player* sender, std::string const& message);
}

#endif
