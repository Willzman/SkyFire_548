/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Rated PvP (5.x personal ratings), ported from Legends of Azeroth Pandaria 5.4.8 (GPL v2),
* src/server/game/Battlegrounds/RatedPvp.* and ArenaTeam.*.
*
* MoP has no arena teams: every player has a rating and a matchmaker rating per bracket (2v2, 3v3,
* 5v5, rated battleground), stored in characters.rated_pvp_info per season. A match builds a
* RatedPvpTeam from the players of each side (average rating and MMR) and applies LoA's Elo changes
* to every member. RatedPvpTeam has the method names SkyFire's old ArenaTeam had in
* Battleground::EndBattleground, so that code keeps its shape.
*/

#ifndef SKYFIRE_RATED_PVP_H
#define SKYFIRE_RATED_PVP_H

#include "Common.h"

#include <memory>
#include <unordered_map>
#include <vector>

class Group;
class Player;
struct GroupQueueInfo;

struct RatedPvpInfo
{
    uint64 Guid = 0;
    uint32 Slot = 0;
    uint32 Rank = 0;
    uint32 Rating = 0;
    uint32 MatchmakerRating = 0;
    uint32 WeekBest = 0;
    uint32 WeekGames = 0;
    uint32 WeekWins = 0;
    uint32 SeasonBest = 0;
    uint32 SeasonGames = 0;
    uint32 SeasonWins = 0;
    uint32 LastWeekBest = 0;
    uint32 WinStreak = 0;
};

enum RatedPvpSlot
{
    PVP_SLOT_ARENA_2v2,
    PVP_SLOT_ARENA_3v3,
    PVP_SLOT_ARENA_5v5,
    PVP_SLOT_RATED_BG,
    PVP_SLOT_MAX,
};

class RatedPvpMgr
{
    RatedPvpMgr() { }
    ~RatedPvpMgr() { }

    typedef std::unordered_map<uint64, std::shared_ptr<RatedPvpInfo> > RatedPvpInfoMap;

public:
    static RatedPvpMgr* Instance()
    {
        static RatedPvpMgr instance;
        return &instance;
    }

    void LoadFromDB();

    RatedPvpInfo* GetOrCreateInfo(RatedPvpSlot slot, uint64 guid);
    RatedPvpInfo* GetInfo(RatedPvpSlot slot, uint64 guid) const;

    // weekly reset (with the currency week cap): last week's best is kept, the week's games are cleared
    void ResetWeek();
    void RecalculateRank(RatedPvpSlot slot);

    static void SaveToDB(RatedPvpInfo const* info);

    // season end (LoA RatedPvpMgr::CheckSeasonEnd / RewardSeason): called once at startup after the world states load.
    // When Arena.ArenaSeason.ID has moved past the season stored in world state WS_ARENA_SEASON_ID, the old season's
    // arena ranks get the titles / achievements / items set in Arena.SeasonReward.*, the seasonal titles are cleaned up
    // and the season's honor / conquest totals are reset.
    void CheckSeasonEnd();

private:
    void RewardSeason(uint32 oldSeason, uint32 newSeason);
private:
    RatedPvpInfoMap m_store[PVP_SLOT_MAX];
};

#define sRatedPvpMgr RatedPvpMgr::Instance()

// The players of one side of a rated match (LoA's ArenaTeam).
class RatedPvpTeam
{
public:
    RatedPvpTeam(RatedPvpSlot slot, Group* group);          // a group joining the queue
    RatedPvpTeam(RatedPvpSlot slot, GroupQueueInfo const* ginfo); // a queued group invited to a match

    uint32 GetRating() const { return m_rating; }
    uint32 GetMatchmakerRating() const { return m_matchmakerRating; }
    uint8 GetSlot() const { return uint8(m_slot); }
    RatedPvpInfo* GetMember(uint64 guid) const;

    static uint8 GetSlotByType(uint32 arenaType);           // 2/3/5 -> slot, 0 -> rated battleground
    static uint8 GetTypeBySlot(uint8 slot);

    static float GetChanceAgainst(uint32 ownRating, uint32 opponentRating);
    static int32 GetMatchmakerRatingMod(uint32 ownRating, uint32 opponentRating, bool won);
    static int32 GetRatingMod(uint32 ownRating, uint32 opponentRating, bool won);

    int32 WonAgainst(uint32 ownMMRating, uint32 opponentMMRating, int32& ratingChange);
    int32 LostAgainst(uint32 ownMMRating, uint32 opponentMMRating, int32& ratingChange);

    void MemberWon(Player* player, uint32 againstMatchmakerRating, int32 matchmakerRatingChange = 16);
    void MemberLost(Player* player, uint32 againstMatchmakerRating, int32 matchmakerRatingChange = -16);
    void OfflineMemberLost(uint64 guid, uint32 againstMatchmakerRating, int32 matchmakerRatingChange = -16);
    void FinishGame(int32 mod);                             // both sides lose (time limit)
    void NotifyStatsChanged();                              // sends the members their rated stats

    int32 GetRatingChange(uint64 guid) const
    {
        std::map<uint64, int32>::const_iterator itr = m_ratingChanges.find(guid);
        return itr != m_ratingChanges.end() ? itr->second : 0;
    }

private:
    void AddMember(uint64 guid);

    std::vector<RatedPvpInfo*> m_members;
    std::set<uint64> m_handled;                             // a member counts once (leaving and the end)
    std::map<uint64, int32> m_ratingChanges;
    uint32 m_rating = 0;
    uint32 m_matchmakerRating = 0;
    RatedPvpSlot m_slot = PVP_SLOT_MAX;
};

#endif
