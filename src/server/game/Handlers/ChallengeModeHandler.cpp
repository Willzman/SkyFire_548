/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Challenge mode packets, ported from Legends of Azeroth Pandaria 5.4.8 (GPL v2),
* src/server/game/Handlers/ChallengeModeHandler.cpp: rewards, realm and guild leaders,
* the player's best times and medals, and the reset button.
*/

#include "Group.h"
#include "InstanceSaveMgr.h"
#include "Log.h"
#include "Map.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "SpellInfo.h"
#include "SpellMgr.h"
#include "World.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#include <ctime>

void WorldSession::HandleGetChallengeModeRewards(WorldPacket& /*recvData*/)
{
    SF_LOG_DEBUG("network", "CMSG_GET_CHALLENGE_MODE_REWARDS %s", GetPlayerInfo().c_str());

    ChallengeRewardsMap const& rewards = sObjectMgr->GetChallengeRewards();

    ByteBuffer buffer;
    WorldPacket data(SMSG_CHALLENGE_MODE_REWARDS);
    data.WriteBits(rewards.size(), 21);                     // Rewards count

    for (ChallengeRewardsMap::const_iterator itr = rewards.begin(); itr != rewards.end(); ++itr)
    {
        uint32 const rewardsPerMedal = 4;
        data.WriteBits(rewardsPerMedal, 20);

        for (uint32 i = 0; i < rewardsPerMedal; ++i)
        {
            data.WriteBits(0, 21);                          // item rewards
            data.WriteBits(0, 20);                          // currency rewards
            buffer << uint32(itr->second.MoneyReward[i]);
        }
        buffer << uint32(itr->second.MapId);
    }

    data.WriteBits(0, 20);                                  // Tier rewards count
    data.FlushBits();
    if (!buffer.empty())
        data.append(buffer);

    SendPacket(&data);
}

void WorldSession::HandleChallengeModeRequestLeaders(WorldPacket& recvData)
{
    uint32 mapId = recvData.read<uint32>();
    recvData.read_skip<uint32>(); // Last guild update
    recvData.read_skip<uint32>(); // Last realm update

    SF_LOG_DEBUG("network", "CMSG_CHALLENGE_MODE_REQUEST_LEADERS %s map: %u", GetPlayerInfo().c_str(), mapId);

    RealmCompletedChallenge* groupChallenge = sObjectMgr->GetGroupCompletedChallengeForMap(mapId);
    RealmCompletedChallenge* guildChallenge = _player->GetGuildId() ? sObjectMgr->GetGuildCompletedChallengeForMap(mapId, _player->GetGuildId()) : NULL;
    uint32 const realmId = realmID;

    ByteBuffer realmBuffer, guildBuffer;
    WorldPacket data(SMSG_CHALLENGE_MODE_REQUEST_LEADERS_RESULT);
    data << uint32(time(nullptr));
    data << uint32(time(nullptr));
    data << uint32(mapId);

    uint32 guildLeaders = guildChallenge ? 1 : 0;
    uint32 realmLeaders = groupChallenge ? 1 : 0;

    data.WriteBits(guildLeaders, 19);
    for (uint32 i = 0; i < guildLeaders; ++i)
    {
        data.WriteBits(guildChallenge->MembersCount, 20);
        for (uint32 j = 0; j < guildChallenge->MembersCount && j < 5; ++j)
        {
            ObjectGuid guid = guildChallenge->Members[j].Guid;
            data.WriteBit(guid[5]);
            data.WriteBit(guid[2]);
            data.WriteBit(guid[3]);
            data.WriteBit(guid[0]);
            data.WriteBit(guid[7]);
            data.WriteBit(guid[1]);
            data.WriteBit(guid[4]);
            data.WriteBit(guid[6]);

            guildBuffer.WriteByteSeq(guid[3]);
            guildBuffer << uint32(guildChallenge->Members[j].SpecId);
            guildBuffer << uint32(realmId);
            guildBuffer.WriteByteSeq(guid[1]);
            guildBuffer.WriteByteSeq(guid[5]);
            guildBuffer.WriteByteSeq(guid[0]);
            guildBuffer << uint32(realmId);
            guildBuffer.WriteByteSeq(guid[4]);
            guildBuffer.WriteByteSeq(guid[7]);
            guildBuffer.WriteByteSeq(guid[6]);
            guildBuffer.WriteByteSeq(guid[2]);
        }

        guildBuffer << uint32(guildChallenge->AttemptId);
        guildBuffer << uint32(guildChallenge->MedalEarned);
        guildBuffer << uint32(realmId);
        guildBuffer << uint32(guildChallenge->CompletionTime);
        guildBuffer << uint32(guildChallenge->CompletionDate);
    }

    data.WriteBits(realmLeaders, 19);
    for (uint32 i = 0; i < realmLeaders; ++i)
    {
        data.WriteBits(groupChallenge->MembersCount, 20);
        for (uint32 j = 0; j < groupChallenge->MembersCount && j < 5; ++j)
        {
            ObjectGuid guid = groupChallenge->Members[j].Guid;
            data.WriteBit(guid[5]);
            data.WriteBit(guid[3]);
            data.WriteBit(guid[0]);
            data.WriteBit(guid[1]);
            data.WriteBit(guid[2]);
            data.WriteBit(guid[4]);
            data.WriteBit(guid[6]);
            data.WriteBit(guid[7]);

            realmBuffer.WriteByteSeq(guid[4]);
            realmBuffer.WriteByteSeq(guid[3]);
            realmBuffer.WriteByteSeq(guid[6]);
            realmBuffer.WriteByteSeq(guid[7]);
            realmBuffer.WriteByteSeq(guid[2]);
            realmBuffer.WriteByteSeq(guid[1]);
            realmBuffer << uint32(realmId);
            realmBuffer << uint32(groupChallenge->Members[j].SpecId);
            realmBuffer << uint32(realmId);
            realmBuffer.WriteByteSeq(guid[0]);
            realmBuffer.WriteByteSeq(guid[5]);
        }

        realmBuffer << uint32(groupChallenge->CompletionDate);
        realmBuffer << uint32(realmId);
        realmBuffer << uint32(groupChallenge->AttemptId);
        realmBuffer << uint32(groupChallenge->CompletionTime);
        realmBuffer << uint32(groupChallenge->MedalEarned);
    }

    data.FlushBits();
    if (!realmBuffer.empty())
        data.append(realmBuffer);
    if (!guildBuffer.empty())
        data.append(guildBuffer);

    SendPacket(&data);
}

void WorldSession::HandleChallengeModeRequestMapStats(WorldPacket& /*recvData*/)
{
    SF_LOG_DEBUG("network", "CMSG_CHALLENGE_MODE_REQUEST_MAP_STATS %s", GetPlayerInfo().c_str());

    CompletedChallengesMap const& challenges = _player->GetCompletedChallenges();

    ByteBuffer buffer;
    WorldPacket data(SMSG_CHALLENGE_MODE_ALL_MAP_STATS);
    data.WriteBits(challenges.size(), 19);                  // Map data count

    for (CompletedChallengesMap::const_iterator itr = challenges.begin(); itr != challenges.end(); ++itr)
    {
        data.WriteBits(0, 23);                              // best specs count
        buffer.AppendPackedTime(itr->second.BestMedalDate);
        buffer << int32(itr->second.BestMedal);
        buffer << int32(itr->first);
        buffer << int32(itr->second.LastTime);
        buffer << int32(itr->second.BestTime);
    }

    data.FlushBits();
    if (!buffer.empty())
        data.append(buffer);

    SendPacket(&data);
}

void WorldSession::SendChallengeModeMapStatsUpdate(uint32 mapId)
{
    CompletedChallenge* challenge = _player->GetCompletedChallenge(mapId);
    if (!challenge)
        return;

    WorldPacket data(SMSG_CHALLENGE_MODE_MAP_STATS_UPDATE);
    data.WriteBits(0, 23);                                  // best specs count
    data.FlushBits();
    data << int32(challenge->LastTime);
    data.AppendPackedTime(challenge->BestMedalDate);
    data << int32(mapId);
    data << int32(challenge->BestTime);
    data << int32(challenge->BestMedal);
    SendPacket(&data);
}

// "Reset Challenge Mode" button: the leader sends everybody in the run back to the entrance, unbound,
// with their long cooldowns reset (LoA: cooldowns of 5 minutes or more that do not reset at midnight).
void WorldSession::HandleResetChallengeMode(WorldPacket& /*recvData*/)
{
    SF_LOG_DEBUG("network", "CMSG_RESET_CHALLENGE_MODE %s", GetPlayerInfo().c_str());

    Group* group = _player->GetGroup();
    if (group && !group->IsLeader(_player->GetGUID()))
        return;

    if (_player->IsInCombat())
        return;

    Map* map = _player->GetMap();
    if (!map->IsChallengeDungeon())
        return;

    uint32 const mapId = map->GetId();
    AreaTriggerStruct const* at = sObjectMgr->GetMapEntranceTrigger(mapId);

    std::list<Player*> players;
    Map::PlayerList const& list = map->GetPlayers();
    for (Map::PlayerList::const_iterator itr = list.begin(); itr != list.end(); ++itr)
        if (Player* player = itr->GetSource())
            players.push_back(player);

    for (std::list<Player*>::const_iterator itr = players.begin(); itr != players.end(); ++itr)
    {
        Player* player = *itr;
        // LoA's CooldownResetPredicate: cooldowns of 5 minutes or more that do not expire at midnight
        std::list<uint32> resetSpells;
        SpellCooldowns const& cooldowns = player->GetSpellCooldownMap();
        for (SpellCooldowns::const_iterator cd = cooldowns.begin(); cd != cooldowns.end(); ++cd)
        {
            SpellInfo const* spellInfo = sSpellMgr->GetSpellInfo(cd->first);
            if (!spellInfo || spellInfo->RecoveryTime < 5 * MINUTE * IN_MILLISECONDS || spellInfo->CategoryRecoveryTime < 5 * MINUTE * IN_MILLISECONDS)
                continue;
            if (spellInfo->CategoryEntry && (spellInfo->CategoryEntry->Flags & SPELL_CATEGORY_FLAG_COOLDOWN_EXPIRES_AT_MIDNIGHT))
                continue;
            resetSpells.push_back(cd->first);
        }
        for (std::list<uint32>::const_iterator spell = resetSpells.begin(); spell != resetSpells.end(); ++spell)
            player->RemoveSpellCooldown(*spell, true);
        player->UnbindInstance(mapId, DIFFICULTY_CHALLENGE, true);
        if (at)
            player->TeleportTo(at->target_mapId, at->target_X, at->target_Y, at->target_Z, at->target_Orientation);
    }

    if (group)
    {
        group->UnbindInstance(mapId, DIFFICULTY_CHALLENGE, true);
        group->SendUpdate();
    }
}