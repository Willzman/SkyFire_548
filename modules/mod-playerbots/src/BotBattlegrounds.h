/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Playerbots module - battleground and arena queues.
*
* Bots take a battleground or arena invitation the way a client does (the
* enter-battle half of CMSG_BATTLEFIELD_PORT). With the fill settings on,
* random bots also queue next to a real player: both sides of a battleground,
* and an opposing bot team for an arena.
*
* World thread only (PlayerbotMgr::Update): the queues are not thread-safe.
*/

#ifndef _SF_BOT_BATTLEGROUNDS_H
#define _SF_BOT_BATTLEGROUNDS_H

#include "Define.h"

namespace BotBattlegrounds
{
    void Update(uint32 diff);
}

#endif // _SF_BOT_BATTLEGROUNDS_H
