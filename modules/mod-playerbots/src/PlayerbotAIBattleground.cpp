/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Playerbots module - what a bot does inside a battleground or arena.
*
* No per-map tactics: bots wait for the gates, then go for the nearest enemy
* player and fight. A bot that dies in a battleground releases to its
* graveyard and gets up there; in an arena it stays down until the match ends.
* Queueing and entering are BotBattlegrounds' job.
*/

#include "PlayerbotAI.h"
#include "engine/BotMovement.h"
#include "Battleground.h"
#include "Map.h"
#include "MotionMaster.h"
#include "Player.h"
#include "WorldSession.h"

namespace
{
    // Enemy players this close are fought; farther ones are walked toward.
    float const PVP_ENGAGE_RANGE = 40.0f;
    uint32 const PVP_ADVANCE_INTERVAL = 3 * IN_MILLISECONDS;
    uint32 const BG_RELEASE_MS = 5 * IN_MILLISECONDS;
    uint32 const BG_REVIVE_MS = 30 * IN_MILLISECONDS;

    Battleground* BattlegroundOf(Player const* bot)
    {
        Map* map = bot->GetMap();
        if (!map || !map->IsBattlegroundOrArena())
            return nullptr;
        return static_cast<BattlegroundMap*>(map)->GetBG();
    }
}

bool PlayerbotAI::IsInPvpMap() const
{
    return _bot && _bot->IsInWorld() && _bot->GetMap()->IsBattlegroundOrArena();
}

Unit* PlayerbotAI::SelectPvpTarget(float range) const
{
    if (!IsInPvpMap())
        return nullptr;

    // The map's own player list: safe to walk from this map's update thread.
    Player* best = nullptr;
    float bestDist = range;
    Map::PlayerList const& players = _bot->GetMap()->GetPlayers();
    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
    {
        Player* player = itr->GetSource();
        if (!player || player == _bot || !player->IsInWorld() || !player->IsAlive())
            continue;
        if (!_bot->IsValidAttackTarget(player) || !_bot->CanSeeOrDetect(player))
            continue;
        float const dist = _bot->GetDistance(player);
        if (dist >= bestDist)
            continue;
        bestDist = dist;
        best = player;
    }
    return best;
}

bool PlayerbotAI::HandleBattleground(uint32 elapsed)
{
    if (!_bot || _clientControlled)
        return false;
    Battleground* bg = BattlegroundOf(_bot);
    if (!bg)
        return false;

    // Behind the gates, and after the final whistle: stand and wait.
    if (bg->GetStatus() != STATUS_IN_PROGRESS)
        return true;

    if (_bot->IsInCombat() || !_bot->getAttackers().empty() || NeedsRestPublic() || BotMovement::IsCasting(_bot))
        return false;

    Unit* enemy = SelectPvpTarget(100000.0f);
    if (!enemy || _bot->GetDistance(enemy) <= PVP_ENGAGE_RANGE)
        return false;

    _pvpAdvanceMs += elapsed;
    if (_pvpAdvanceMs < PVP_ADVANCE_INTERVAL
        && _bot->GetMotionMaster()->GetCurrentMovementGeneratorType() == POINT_MOTION_TYPE)
        return true;
    _pvpAdvanceMs = 0;

    BotMovement::MoveTo(_bot, enemy->GetPositionX(), enemy->GetPositionY(), enemy->GetPositionZ());
    return true;
}

bool PlayerbotAI::HandleBattlegroundDeath(uint32 diff)
{
    Battleground* bg = BattlegroundOf(_bot);
    if (!bg || _clientControlled)
        return false;
    if (bg->isArena())
        return true;

    _deadMs += diff;
    if (_deadMs >= BG_RELEASE_MS && !_pvpReleased)
    {
        // Release to the battleground's graveyard (a teleport on this map).
        _pvpReleased = true;
        if (!_bot->HasFlag(PLAYER_FIELD_PLAYER_FLAGS, PLAYER_FLAGS_GHOST))
            _bot->BuildPlayerRepop();
        _bot->RepopAtGraveyard();
        if (_bot->IsBeingTeleportedNear())
            _bot->GetSession()->FinalizeBotTeleport();
        return true;
    }

    if (_deadMs >= BG_REVIVE_MS)
    {
        _deadMs = 0;
        _pvpReleased = false;
        _bot->ResurrectPlayer(1.0f, false);
        _bot->SpawnCorpseBones();
    }
    return true;
}
