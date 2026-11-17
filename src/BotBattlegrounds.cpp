/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

#include "BotBattlegrounds.h"
#include "ArenaTeam.h"
#include "Battleground.h"
#include "BattlegroundMgr.h"
#include "BattlegroundQueue.h"
#include "DBCStores.h"
#include "DisableMgr.h"
#include "Group.h"
#include "GroupMgr.h"
#include "Log.h"
#include "Map.h"
#include "MotionMaster.h"
#include "ObjectAccessor.h"
#include "Player.h"
#include "PlayerbotAI.h"
#include "PlayerbotMgr.h"
#include "SharedDefines.h"
#include "World.h"
#include "WorldSession.h"

#include <algorithm>
#include <set>
#include <tuple>
#include <vector>

namespace
{
    uint32 const UPDATE_INTERVAL = 2 * IN_MILLISECONDS;
    // A real player invited with the bots may still be on the way in.
    uint32 const EMPTY_BG_GRACE_MS = 3 * MINUTE * IN_MILLISECONDS;
    // Deserter, checked by Player::CanJoinToBattleground.
    uint32 const SPELL_DESERTER = 26013;

    uint32 updateTimer = 0;
    // Low GUIDs of the arena teams this module formed out of random bots.
    std::set<uint32> arenaGroups;

    // A queue a real player is waiting in (or a battleground one is playing in).
    struct Demand
    {
        BattlegroundQueueTypeId queue;
        BattlegroundBracketId bracket;

        bool operator<(Demand const& other) const
        {
            return std::tie(queue, bracket) < std::tie(other.queue, other.bracket);
        }
    };

    bool IsRealPlayer(Player const* player)
    {
        return player && player->IsInWorld() && player->GetSession() && !player->GetSession()->IsBot();
    }

    bool BracketOf(Battleground const* bgTemplate, Player const* player, BattlegroundBracketId& bracket)
    {
        PvPDifficultyEntry const* entry = GetBattlegroundBracketByLevel(bgTemplate->GetMapId(), player->getLevel());
        if (!entry)
            return false;
        bracket = entry->GetBracketId();
        return true;
    }

    Battleground* TemplateFor(BattlegroundQueueTypeId queue)
    {
        return sBattlegroundMgr->GetBattlegroundTemplate(BattlegroundMgr::BGTemplateId(queue));
    }

    void FinishTeleport(Player* bot)
    {
        if (bot->IsBeingTeleported())
            bot->GetSession()->FinalizeBotTeleport();
    }

    // The leave-queue half of WorldSession::HandleBattleFieldPortOpcode.
    void LeaveQueue(Player* bot, BattlegroundQueueTypeId queue)
    {
        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(queue);
        GroupQueueInfo ginfo;
        bool const queued = bgQueue.GetPlayerGroupInfoData(bot->GetGUID(), &ginfo);

        bot->RemoveBattlegroundQueueId(queue);
        if (!queued)
            return;
        bgQueue.RemovePlayer(bot->GetGUID(), true);

        Battleground* bgTemplate = TemplateFor(queue);
        BattlegroundBracketId bracket;
        if (!ginfo.ArenaType && bgTemplate && BracketOf(bgTemplate, bot, bracket))
            sBattlegroundMgr->ScheduleQueueUpdate(ginfo.ArenaMatchmakerRating, ginfo.ArenaType, queue,
                bgTemplate->GetTypeID(), bracket);
    }

    // The enter-battle half of WorldSession::HandleBattleFieldPortOpcode.
    void AcceptInvite(Player* bot, BattlegroundQueueTypeId queue)
    {
        if (bot->IsBeingTeleported())
            return;

        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(queue);
        GroupQueueInfo ginfo;
        if (!bgQueue.GetPlayerGroupInfoData(bot->GetGUID(), &ginfo) || !ginfo.IsInvitedToBGInstanceGUID)
            return;

        BattlegroundTypeId bgTypeId = BattlegroundMgr::BGTemplateId(queue);
        Battleground* bg = sBattlegroundMgr->GetBattleground(ginfo.IsInvitedToBGInstanceGUID,
            bgTypeId == BattlegroundTypeId::BATTLEGROUND_AA ? BattlegroundTypeId::BATTLEGROUND_TYPE_NONE : bgTypeId);
        if (!bg)
            return;
        bgTypeId = bg->GetTypeID();

        if (!ginfo.ArenaType && (!bot->CanJoinToBattleground(bg) || bot->getLevel() > bg->GetMaxLevel()))
        {
            LeaveQueue(bot, queue);
            return;
        }

        if (!bot->InBattleground())
            bot->SetBattlegroundEntryPoint();

        if (!bot->IsAlive())
        {
            bot->ResurrectPlayer(1.0f);
            bot->SpawnCorpseBones();
        }
        if (bot->IsInFlight())
        {
            bot->GetMotionMaster()->MovementExpired();
            bot->CleanupAfterTaxiFlight();
        }

        bgQueue.RemovePlayer(bot->GetGUID(), false);
        if (Battleground* current = bot->GetBattleground())
            current->RemovePlayerAtLeave(bot->GetGUID(), false, true);

        bot->SetBattlegroundId(bg->GetInstanceID(), bgTypeId);
        bot->SetBGTeam(ginfo.Team);
        sBattlegroundMgr->SendToBattleground(bot, ginfo.IsInvitedToBGInstanceGUID, bgTypeId);
        FinishTeleport(bot);

        SF_LOG_INFO("modules", "[mod-playerbots] Bot '%s' entered %s %u.", bot->GetName().c_str(),
            bg->isArena() ? "arena" : "battleground", bg->GetInstanceID());
    }

    // The solo half of WorldSession::HandleBattlemasterJoinOpcode.
    bool JoinBattleground(Player* bot, BattlegroundQueueTypeId queue)
    {
        Battleground* bgTemplate = TemplateFor(queue);
        if (!bgTemplate || bot->InBattleground() || bot->InBattlegroundQueue() || bot->isUsingLfg())
            return false;
        if (!bot->CanJoinToBattleground(bgTemplate) || !bot->HasFreeBattlegroundQueueId())
            return false;

        PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bgTemplate->GetMapId(), bot->getLevel());
        if (!bracketEntry)
            return false;

        BattlegroundTypeId const bgTypeId = bgTemplate->GetTypeID();
        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(queue);
        GroupQueueInfo* ginfo = bgQueue.AddGroup(bot, nullptr, bgTypeId, bracketEntry, 0, false, false, 0, 0);
        bot->AddBattlegroundQueueId(queue);
        bot->AddBattlegroundQueueJoinTime(bgTypeId, ginfo->JoinTime);
        sBattlegroundMgr->ScheduleQueueUpdate(0, 0, queue, bgTypeId, bracketEntry->GetBracketId());
        return true;
    }

    // WorldSession::HandleBattlemasterJoinArena for a group of bots.
    bool JoinArena(Player* leader, Group* group, uint8 arenaType)
    {
        Battleground* bgTemplate = sBattlegroundMgr->GetBattlegroundTemplate(BattlegroundTypeId::BATTLEGROUND_AA);
        if (!bgTemplate)
            return false;

        BattlegroundTypeId const bgTypeId = bgTemplate->GetTypeID();
        BattlegroundQueueTypeId const queue = BattlegroundMgr::BGQueueTypeId(bgTypeId, arenaType);
        PvPDifficultyEntry const* bracketEntry = GetBattlegroundBracketByLevel(bgTemplate->GetMapId(), leader->getLevel());
        if (!bracketEntry)
            return false;

        if (group->CanJoinBattlegroundQueue(bgTemplate, queue, arenaType, arenaType, true,
            ArenaTeam::GetSlotByType(arenaType)) != GroupJoinBattlegroundResult::ERR_BATTLEGROUND_NONE)
            return false;

        // Same ratings the core gives every team.
        uint32 const rating = 1;
        BattlegroundQueue& bgQueue = sBattlegroundMgr->GetBattlegroundQueue(queue);
        GroupQueueInfo* ginfo = bgQueue.AddGroup(leader, group, bgTypeId, bracketEntry, arenaType, true, false, rating, rating);
        for (GroupReference* itr = group->GetFirstMember(); itr != nullptr; itr = itr->next())
        {
            Player* member = itr->GetSource();
            if (!member)
                continue;
            member->AddBattlegroundQueueId(queue);
            member->AddBattlegroundQueueJoinTime(bgTypeId, ginfo->JoinTime);
        }
        sBattlegroundMgr->ScheduleQueueUpdate(rating, arenaType, queue, bgTypeId, bracketEntry->GetBracketId());
        return true;
    }

    // A random bot with nothing better to do.
    bool IsFreeBot(uint64 guid, Player*& bot)
    {
        if (!sPlayerbotMgr->IsRandomBot(guid))
            return false;
        PlayerbotAI* ai = sPlayerbotMgr->GetBotAI(guid);
        bot = ai ? ai->GetBot() : nullptr;
        if (!bot || !bot->IsInWorld() || ai->IsClientControlled() || ai->IsQuestTesting())
            return false;
        if (bot->GetGroup() || bot->InBattleground() || bot->InBattlegroundQueue() || bot->isUsingLfg())
            return false;
        if (bot->IsBeingTeleported() || bot->IsInCombat() || !bot->IsAlive() || bot->GetMap()->Instanceable())
            return false;
        return true;
    }

    void CollectDemand(std::set<Demand>& battlegrounds, std::set<Demand>& arenas)
    {
        SessionMap const& sessions = sWorld->GetAllSessions();
        for (SessionMap::const_iterator itr = sessions.begin(); itr != sessions.end(); ++itr)
        {
            Player* player = itr->second ? itr->second->GetPlayer() : nullptr;
            if (!IsRealPlayer(player))
                continue;

            for (uint32 slot = 0; slot < PLAYER_MAX_BATTLEGROUND_QUEUES; ++slot)
            {
                BattlegroundQueueTypeId const queue = player->GetBattlegroundQueueTypeId(slot);
                if (queue == BATTLEGROUND_QUEUE_NONE)
                    continue;
                Battleground* bgTemplate = TemplateFor(queue);
                Demand demand;
                demand.queue = queue;
                if (!bgTemplate || !BracketOf(bgTemplate, player, demand.bracket))
                    continue;
                (BattlegroundMgr::BGArenaType(queue) ? arenas : battlegrounds).insert(demand);
            }

            // A battleground in play keeps its queue alive, so leavers are replaced.
            Battleground* bg = player->GetBattleground();
            if (bg && !bg->isArena() && bg->GetStatus() != STATUS_WAIT_LEAVE)
            {
                Demand demand;
                demand.queue = BattlegroundMgr::BGQueueTypeId(bg->GetTypeID(), 0);
                demand.bracket = bg->GetBracketId();
                battlegrounds.insert(demand);
            }
        }
    }

    void FillBattleground(Demand const& demand, std::vector<uint64> const& guids)
    {
        Battleground* bgTemplate = TemplateFor(demand.queue);
        if (!bgTemplate || DisableMgr::IsDisabledFor(DISABLE_TYPE_BATTLEGROUND, uint32(bgTemplate->GetTypeID()), nullptr))
            return;

        uint32 const perTeam = std::min(bgTemplate->GetMaxPlayersPerTeam(), sPlayerbotMgr->GetJoinBgMaxPerTeam());

        // Bots already queued here or fighting in a battleground count toward the side.
        uint32 alliance = 0;
        uint32 horde = 0;
        for (uint64 guid : guids)
        {
            PlayerbotAI* ai = sPlayerbotMgr->GetBotAI(guid);
            Player* bot = ai ? ai->GetBot() : nullptr;
            if (!bot || !bot->IsInWorld())
                continue;
            Battleground* bg = bot->GetBattleground();
            bool const playing = bg && !bg->isArena() && bg->GetBracketId() == demand.bracket;
            if (!playing && bot->GetBattlegroundQueueIndex(demand.queue) >= PLAYER_MAX_BATTLEGROUND_QUEUES)
                continue;
            (bot->GetTeam() == ALLIANCE ? alliance : horde) += 1;
        }

        for (uint64 guid : guids)
        {
            if (alliance >= perTeam && horde >= perTeam)
                break;

            Player* bot = nullptr;
            if (!IsFreeBot(guid, bot))
                continue;
            uint32& side = bot->GetTeam() == ALLIANCE ? alliance : horde;
            if (side >= perTeam)
                continue;
            BattlegroundBracketId bracket;
            if (!BracketOf(bgTemplate, bot, bracket) || bracket != demand.bracket)
                continue;
            if (JoinBattleground(bot, demand.queue))
                ++side;
        }
    }

    void FillArena(Demand const& demand, std::vector<uint64> const& guids)
    {
        uint8 const arenaType = BattlegroundMgr::BGArenaType(demand.queue);
        Battleground* bgTemplate = sBattlegroundMgr->GetBattlegroundTemplate(BattlegroundTypeId::BATTLEGROUND_AA);
        if (!arenaType || !bgTemplate)
            return;

        // One bot team waiting in (or playing from) this queue is enough.
        for (uint32 lowGuid : arenaGroups)
        {
            Group* group = sGroupMgr->GetGroupByGUID(lowGuid);
            Player* leader = group ? ObjectAccessor::FindPlayer(group->GetLeaderGUID()) : nullptr;
            if (leader && (leader->GetBattlegroundQueueIndex(demand.queue) < PLAYER_MAX_BATTLEGROUND_QUEUES
                || leader->InBattleground()))
                return;
        }

        // Same faction and bracket, as CanJoinBattlegroundQueue demands of a team.
        std::vector<Player*> team;
        for (uint64 guid : guids)
        {
            Player* bot = nullptr;
            if (!IsFreeBot(guid, bot) || !bot->CanJoinToBattleground(bgTemplate))
                continue;
            BattlegroundBracketId bracket;
            if (!BracketOf(bgTemplate, bot, bracket) || bracket != demand.bracket)
                continue;
            if (!team.empty() && team.front()->GetTeam() != bot->GetTeam())
                continue;
            team.push_back(bot);
            if (team.size() == arenaType)
                break;
        }
        if (team.size() != arenaType)
            return;

        Group* group = new Group;
        if (!group->Create(team.front()))
        {
            delete group;
            return;
        }
        sGroupMgr->AddGroup(group);
        for (size_t i = 1; i < team.size(); ++i)
            group->AddMember(team[i]);

        if (group->GetMembersCount() != arenaType || !JoinArena(team.front(), group, arenaType))
        {
            group->Disband();
            return;
        }

        arenaGroups.insert(group->GetLowGUID());
        SF_LOG_INFO("modules", "[mod-playerbots] Queued a %uv%u arena team of bots led by '%s'.",
            uint32(arenaType), uint32(arenaType), team.front()->GetName().c_str());
    }

    // Bot arena teams break up once they are neither playing nor queued for a real player.
    void DisbandIdleArenaTeams(std::set<Demand> const& arenas)
    {
        for (auto itr = arenaGroups.begin(); itr != arenaGroups.end();)
        {
            Group* group = sGroupMgr->GetGroupByGUID(*itr);
            bool busy = false;
            if (group)
            {
                std::vector<Player*> members;
                for (GroupReference* ref = group->GetFirstMember(); ref != nullptr; ref = ref->next())
                    if (Player* member = ref->GetSource())
                        members.push_back(member);

                for (Player* member : members)
                {
                    if (member->InBattleground() || member->IsBeingTeleported())
                    {
                        busy = true;
                        continue;
                    }

                    for (uint32 slot = 0; slot < PLAYER_MAX_BATTLEGROUND_QUEUES; ++slot)
                    {
                        BattlegroundQueueTypeId const queue = member->GetBattlegroundQueueTypeId(slot);
                        if (queue == BATTLEGROUND_QUEUE_NONE)
                            continue;
                        Battleground* bgTemplate = TemplateFor(queue);
                        Demand demand;
                        demand.queue = queue;
                        // Invited, or the real player is still waiting: stay. Otherwise leave the queue.
                        if (member->IsInvitedForBattlegroundQueueType(queue)
                            || (bgTemplate && BracketOf(bgTemplate, member, demand.bracket) && arenas.count(demand)))
                            busy = true;
                        else
                            LeaveQueue(member, queue);
                    }
                }
            }

            if (busy)
            {
                ++itr;
                continue;
            }
            if (group)
                group->Disband();
            itr = arenaGroups.erase(itr);
        }
    }

    bool HasRealPlayer(Battleground const* bg)
    {
        for (auto const& kv : bg->GetPlayers())
            if (IsRealPlayer(ObjectAccessor::FindPlayer(kv.first)))
                return true;
        return false;
    }

    // Invitations, the way out of a finished match, and queues nobody needs any more.
    void UpdateBot(Player* bot, bool randomBot, std::set<Demand> const& battlegrounds, std::set<Demand> const& arenas)
    {
        if (Battleground* bg = bot->GetBattleground())
        {
            // The teleport out of (or into) a battleground has no client to acknowledge it.
            FinishTeleport(bot);
            // Out when the match is over, and out of a battleground the last real
            // player has left: bots alone there would sit frozen until it timed out.
            bool const over = bg->GetStatus() == STATUS_WAIT_LEAVE;
            bool const deserted = !bg->isArena() && bg->GetElapsedTime() > EMPTY_BG_GRACE_MS && !HasRealPlayer(bg);
            if ((over || deserted) && bot->GetMap()->IsBattlegroundOrArena()
                && !bot->IsBeingTeleported())
            {
                bot->LeaveBattleground();
                FinishTeleport(bot);
                if (!over)
                    bot->RemoveAurasDueToSpell(SPELL_DESERTER);
            }
        }
        else if (bot->GetMap()->IsBattlegroundOrArena())
            FinishTeleport(bot);

        for (uint32 slot = 0; slot < PLAYER_MAX_BATTLEGROUND_QUEUES; ++slot)
        {
            BattlegroundQueueTypeId const queue = bot->GetBattlegroundQueueTypeId(slot);
            if (queue == BATTLEGROUND_QUEUE_NONE)
                continue;

            if (bot->IsInvitedForBattlegroundQueueType(queue))
            {
                AcceptInvite(bot, queue);
                return;
            }

            // A bot queued by its group leader stays queued; a fill bot leaves
            // when the real player it queued for is gone.
            if (!randomBot || bot->GetGroup())
                continue;
            Battleground* bgTemplate = TemplateFor(queue);
            Demand demand;
            demand.queue = queue;
            if (!bgTemplate || !BracketOf(bgTemplate, bot, demand.bracket))
                continue;
            std::set<Demand> const& wanted = BattlegroundMgr::BGArenaType(queue) ? arenas : battlegrounds;
            if (!wanted.count(demand))
                LeaveQueue(bot, queue);
        }
    }
}

void BotBattlegrounds::Update(uint32 diff)
{
    updateTimer += diff;
    if (updateTimer < UPDATE_INTERVAL)
        return;
    updateTimer = 0;

    std::vector<uint64> guids;
    sPlayerbotMgr->GetBotGuids(guids);
    if (guids.empty())
        return;

    std::set<Demand> battlegrounds;
    std::set<Demand> arenas;
    CollectDemand(battlegrounds, arenas);
    if (!sPlayerbotMgr->IsJoinBgEnabled())
        battlegrounds.clear();

    for (uint64 guid : guids)
    {
        PlayerbotAI* ai = sPlayerbotMgr->GetBotAI(guid);
        Player* bot = ai ? ai->GetBot() : nullptr;
        if (!bot || !bot->IsInWorld() || ai->IsClientControlled())
            continue;
        UpdateBot(bot, sPlayerbotMgr->IsRandomBot(guid), battlegrounds, arenas);
    }

    for (Demand const& demand : battlegrounds)
        FillBattleground(demand, guids);

    if (sPlayerbotMgr->IsJoinArenaEnabled())
        for (Demand const& demand : arenas)
            FillArena(demand, guids);
    DisbandIdleArenaTeams(arenas);
}
