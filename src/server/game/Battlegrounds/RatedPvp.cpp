/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Rated PvP, ported from Legends of Azeroth Pandaria 5.4.8 (GPL v2); see RatedPvp.h.
*/

#include "RatedPvp.h"
#include "Battleground.h"
#include "BattlegroundQueue.h"
#include "DatabaseEnv.h"
#include "Group.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "Opcodes.h"
#include "Player.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#include <algorithm>
#include <cmath>

// ---------------------------------------------------------------- store

void RatedPvpMgr::LoadFromDB()
{
    uint32 oldMSTime = getMSTime();
    uint32 count = 0;

    for (uint8 i = 0; i < PVP_SLOT_MAX; ++i)
        m_store[i].clear();

    uint32 const season = sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID);

    //                                                    0       1       2        3              4                5            6            7             8              9              10                11               12
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_RATED_PVP_INFO);
    stmt->setUInt16(0, uint16(season));
    if (PreparedQueryResult result = CharacterDatabase.Query(stmt))
    {
        do
        {
            Field* fields = result->Fetch();
            uint8 slot = fields[1].GetUInt8();
            if (slot >= PVP_SLOT_MAX)
                continue;

            uint64 guid = MAKE_NEW_GUID(fields[0].GetUInt32(), 0, HIGHGUID_PLAYER);
            std::shared_ptr<RatedPvpInfo>& info = m_store[slot][guid];
            info.reset(new RatedPvpInfo());
            info->Guid = guid;
            info->Slot = slot;
            info->Rank = fields[2].GetUInt32();
            info->Rating = fields[3].GetUInt32();
            info->MatchmakerRating = fields[4].GetUInt32();
            info->WeekBest = fields[5].GetUInt32();
            info->WeekGames = fields[6].GetUInt32();
            info->WeekWins = fields[7].GetUInt32();
            info->SeasonBest = fields[8].GetUInt32();
            info->SeasonGames = fields[9].GetUInt32();
            info->SeasonWins = fields[10].GetUInt32();
            info->LastWeekBest = fields[11].GetUInt32();
            info->WinStreak = fields[12].GetUInt32();
            ++count;
        }
        while (result->NextRow());
    }

    SF_LOG_INFO("server.loading", ">> Loaded %u rated PvP ratings (season %u) in %u ms", count, season, GetMSTimeDiffToNow(oldMSTime));
}

RatedPvpInfo* RatedPvpMgr::GetInfo(RatedPvpSlot slot, uint64 guid) const
{
    if (slot >= PVP_SLOT_MAX)
        return NULL;

    RatedPvpInfoMap::const_iterator itr = m_store[slot].find(guid);
    return itr != m_store[slot].end() ? itr->second.get() : NULL;
}

RatedPvpInfo* RatedPvpMgr::GetOrCreateInfo(RatedPvpSlot slot, uint64 guid)
{
    if (slot >= PVP_SLOT_MAX)
        return NULL;

    if (RatedPvpInfo* info = GetInfo(slot, guid))
        return info;

    std::shared_ptr<RatedPvpInfo>& info = m_store[slot][guid];
    info.reset(new RatedPvpInfo());
    info->Guid = guid;
    info->Slot = slot;
    info->Rating = sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_START_PERSONAL_RATING);
    info->MatchmakerRating = sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_START_MATCHMAKER_RATING);
    info->Rank = uint32(m_store[slot].size());

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_RATED_PVP_INFO);
    stmt->setUInt32(0, GUID_LOPART(guid));
    stmt->setUInt8(1, uint8(slot));
    stmt->setUInt16(2, uint16(sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID)));
    stmt->setUInt16(3, uint16(info->Rating));
    stmt->setUInt16(4, uint16(info->MatchmakerRating));
    CharacterDatabase.Execute(stmt);
    return info.get();
}

void RatedPvpMgr::SaveToDB(RatedPvpInfo const* info)
{
    uint8 i = 0;
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_RATED_PVP_INFO);
    stmt->setUInt32(i++, info->Rank);
    stmt->setUInt16(i++, uint16(info->Rating));
    stmt->setUInt16(i++, uint16(info->MatchmakerRating));
    stmt->setUInt16(i++, uint16(info->WeekBest));
    stmt->setUInt16(i++, uint16(info->WeekGames));
    stmt->setUInt16(i++, uint16(info->WeekWins));
    stmt->setUInt16(i++, uint16(info->SeasonBest));
    stmt->setUInt16(i++, uint16(info->SeasonGames));
    stmt->setUInt16(i++, uint16(info->SeasonWins));
    stmt->setUInt16(i++, uint16(info->LastWeekBest));
    stmt->setUInt32(i++, info->WinStreak);
    stmt->setUInt32(i++, GUID_LOPART(info->Guid));
    stmt->setUInt8(i++, uint8(info->Slot));
    stmt->setUInt16(i++, uint16(sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID)));
    CharacterDatabase.Execute(stmt);
}

void RatedPvpMgr::ResetWeek()
{
    for (uint8 slot = 0; slot < PVP_SLOT_MAX; ++slot)
    {
        for (RatedPvpInfoMap::iterator itr = m_store[slot].begin(); itr != m_store[slot].end(); ++itr)
        {
            itr->second->LastWeekBest = itr->second->WeekBest;
            itr->second->WeekBest = 0;
            itr->second->WeekGames = 0;
            itr->second->WeekWins = 0;
        }
    }

    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_RATED_PVP_INFO_WEEKLY);
    stmt->setUInt16(0, uint16(sWorld->getIntConfig(WorldIntConfigs::CONFIG_ARENA_SEASON_ID)));
    CharacterDatabase.Execute(stmt);
}

// LoA's ranking: rating, then fewer games, win ratio, MMR, season best
static bool IsHigherRank(RatedPvpInfo const* lhs, RatedPvpInfo const* rhs)
{
    if (lhs->Rating != rhs->Rating)
        return lhs->Rating > rhs->Rating;
    if (lhs->SeasonGames != rhs->SeasonGames)
        return lhs->SeasonGames < rhs->SeasonGames;
    if (lhs->SeasonGames && rhs->SeasonGames)
    {
        uint32 l = lhs->SeasonWins * 100 / lhs->SeasonGames;
        uint32 r = rhs->SeasonWins * 100 / rhs->SeasonGames;
        if (l != r)
            return l > r;
    }
    if (lhs->MatchmakerRating != rhs->MatchmakerRating)
        return lhs->MatchmakerRating > rhs->MatchmakerRating;
    if (lhs->SeasonBest != rhs->SeasonBest)
        return lhs->SeasonBest > rhs->SeasonBest;
    return lhs->Guid > rhs->Guid;
}

void RatedPvpMgr::RecalculateRank(RatedPvpSlot slot)
{
    if (slot >= PVP_SLOT_MAX)
        return;

    std::vector<RatedPvpInfo*> sorted;
    sorted.reserve(m_store[slot].size());
    for (RatedPvpInfoMap::const_iterator itr = m_store[slot].begin(); itr != m_store[slot].end(); ++itr)
        sorted.push_back(itr->second.get());

    std::sort(sorted.begin(), sorted.end(), IsHigherRank);

    for (uint32 i = 0; i < sorted.size(); ++i)
    {
        if (sorted[i]->Rank != i + 1)
        {
            sorted[i]->Rank = i + 1;
            SaveToDB(sorted[i]);
        }
    }
}

// ---------------------------------------------------------------- match teams

RatedPvpTeam::RatedPvpTeam(RatedPvpSlot slot, Group* group) : m_slot(slot)
{
    if (!group)
        return;

    for (GroupReference* itr = group->GetFirstMember(); itr != NULL; itr = itr->next())
        if (Player* member = itr->GetSource())
            AddMember(member->GetGUID());

    if (!m_members.empty())
    {
        m_rating /= m_members.size();
        m_matchmakerRating /= m_members.size();
    }
}

RatedPvpTeam::RatedPvpTeam(RatedPvpSlot slot, GroupQueueInfo const* ginfo) : m_slot(slot)
{
    if (!ginfo)
        return;

    for (std::map<uint64, PlayerQueueInfo*>::const_iterator itr = ginfo->Players.begin(); itr != ginfo->Players.end(); ++itr)
        AddMember(itr->first);

    // the queue keeps the values the group joined with
    m_rating = ginfo->ArenaTeamRating;
    m_matchmakerRating = ginfo->ArenaMatchmakerRating;
}

void RatedPvpTeam::AddMember(uint64 guid)
{
    if (RatedPvpInfo* info = sRatedPvpMgr->GetOrCreateInfo(m_slot, guid))
    {
        m_rating += info->Rating;
        m_matchmakerRating += info->MatchmakerRating;
        m_members.push_back(info);
    }
}

RatedPvpInfo* RatedPvpTeam::GetMember(uint64 guid) const
{
    for (std::vector<RatedPvpInfo*>::const_iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
        if ((*itr)->Guid == guid)
            return *itr;
    return NULL;
}

uint8 RatedPvpTeam::GetSlotByType(uint32 arenaType)
{
    switch (arenaType)
    {
        case ARENA_TYPE_2v2: return PVP_SLOT_ARENA_2v2;
        case ARENA_TYPE_3v3: return PVP_SLOT_ARENA_3v3;
        case ARENA_TYPE_5v5: return PVP_SLOT_ARENA_5v5;
        case 0:              return PVP_SLOT_RATED_BG;
        default:             return PVP_SLOT_MAX;
    }
}

uint8 RatedPvpTeam::GetTypeBySlot(uint8 slot)
{
    switch (slot)
    {
        case PVP_SLOT_ARENA_2v2: return ARENA_TYPE_2v2;
        case PVP_SLOT_ARENA_3v3: return ARENA_TYPE_3v3;
        case PVP_SLOT_ARENA_5v5: return ARENA_TYPE_5v5;
        default:                 return 0;
    }
}

float RatedPvpTeam::GetChanceAgainst(uint32 ownRating, uint32 opponentRating)
{
    // Elo: chance to beat a team of the given rating
    return 1.0f / (1.0f + std::exp(std::log(10.0f) * (float(opponentRating) - float(ownRating)) / 400.0f));
}

int32 RatedPvpTeam::GetMatchmakerRatingMod(uint32 ownRating, uint32 opponentRating, bool won)
{
    float mod = ((won ? 1.0f : 0.0f) - GetChanceAgainst(ownRating, opponentRating)) * 32.0f;
    return int32(std::ceil(mod));
}

int32 RatedPvpTeam::GetRatingMod(uint32 ownRating, uint32 opponentRating, bool won)
{
    float const chance = GetChanceAgainst(ownRating, opponentRating);
    float const wonMod = won ? 1.0f : 0.0f;
    float mod;

    // faster climbing below 1300 (LoA / TrinityCore)
    if (won && ownRating < 1300)
    {
        if (ownRating < 1000)
            mod = 96.0f * (wonMod - chance);
        else
            mod = (32.0f + (24.0f * (1300.0f - float(ownRating)) / 300.0f)) * (wonMod - chance);
    }
    else
        mod = 32.0f * (wonMod - chance);

    return int32(std::ceil(mod));
}

int32 RatedPvpTeam::WonAgainst(uint32 ownMMRating, uint32 opponentMMRating, int32& ratingChange)
{
    int32 mod = GetMatchmakerRatingMod(ownMMRating, opponentMMRating, true);
    ratingChange = GetRatingMod(m_rating, opponentMMRating, true);
    m_matchmakerRating += mod;
    return mod;
}

int32 RatedPvpTeam::LostAgainst(uint32 ownMMRating, uint32 opponentMMRating, int32& ratingChange)
{
    int32 mod = GetMatchmakerRatingMod(ownMMRating, opponentMMRating, false);
    ratingChange = GetRatingMod(m_rating, opponentMMRating, false);
    m_matchmakerRating = (int32(m_matchmakerRating) + mod < 0) ? 0 : m_matchmakerRating + mod;
    return mod;
}

void RatedPvpTeam::MemberWon(Player* player, uint32 againstMatchmakerRating, int32 matchmakerRatingChange)
{
    RatedPvpInfo* info = player ? GetMember(player->GetGUID()) : NULL;
    if (!info || m_handled.count(info->Guid))
        return;
    m_handled.insert(info->Guid);

    int32 mod = GetRatingMod(info->Rating, againstMatchmakerRating, true);
    if (int32(info->Rating) + mod < 0)
        mod = -int32(info->Rating);

    info->Rating += mod;
    if (m_slot != PVP_SLOT_RATED_BG)
        player->UpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_HIGHEST_PERSONAL_RATING, info->Rating, GetTypeBySlot(info->Slot));

    if (info->Rating > info->SeasonBest)
        info->SeasonBest = info->Rating;
    if (info->Rating > info->WeekBest)
        info->WeekBest = info->Rating;

    info->MatchmakerRating = (int32(info->MatchmakerRating) + matchmakerRatingChange < 0) ? 0 : info->MatchmakerRating + matchmakerRatingChange;
    info->WeekGames += 1;
    info->SeasonGames += 1;
    info->WeekWins += 1;
    info->SeasonWins += 1;
    if (info->WinStreak < 10)
        info->WinStreak += 1;

    m_ratingChanges[info->Guid] = mod;
    RatedPvpMgr::SaveToDB(info);
}

void RatedPvpTeam::MemberLost(Player* player, uint32 againstMatchmakerRating, int32 matchmakerRatingChange)
{
    if (player)
        OfflineMemberLost(player->GetGUID(), againstMatchmakerRating, matchmakerRatingChange);
}

void RatedPvpTeam::OfflineMemberLost(uint64 guid, uint32 againstMatchmakerRating, int32 matchmakerRatingChange)
{
    RatedPvpInfo* info = GetMember(guid);
    if (!info || m_handled.count(guid))
        return;
    m_handled.insert(guid);

    int32 mod = GetRatingMod(info->Rating, againstMatchmakerRating, false);
    if (int32(info->Rating) + mod < 0)
        mod = -int32(info->Rating);

    info->Rating += mod;
    info->MatchmakerRating = (int32(info->MatchmakerRating) + matchmakerRatingChange < 0) ? 0 : info->MatchmakerRating + matchmakerRatingChange;
    info->WeekGames += 1;
    info->SeasonGames += 1;
    info->WinStreak = 0;

    m_ratingChanges[guid] = mod;
    RatedPvpMgr::SaveToDB(info);
}

void RatedPvpTeam::FinishGame(int32 mod)
{
    for (std::vector<RatedPvpInfo*>::const_iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
    {
        RatedPvpInfo* info = *itr;
        if (m_handled.count(info->Guid))
            continue;
        m_handled.insert(info->Guid);

        int32 change = (int32(info->Rating) + mod < 0) ? -int32(info->Rating) : mod;
        info->Rating += change;
        info->WeekGames += 1;
        info->SeasonGames += 1;
        info->WinStreak = 0;
        m_ratingChanges[info->Guid] = change;
        RatedPvpMgr::SaveToDB(info);
    }
}

void RatedPvpTeam::NotifyStatsChanged()
{
    for (std::vector<RatedPvpInfo*>::const_iterator itr = m_members.begin(); itr != m_members.end(); ++itr)
        if (Player* player = ObjectAccessor::FindPlayer((*itr)->Guid))
            player->GetSession()->SendRatedPvpInfo();
}
