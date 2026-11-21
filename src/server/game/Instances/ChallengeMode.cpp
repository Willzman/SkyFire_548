/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Challenge modes (5.x), ported from Legends of Azeroth Pandaria 5.4.8 (GPL v2),
* src/server/game/Instances/InstanceScript.cpp and the challenge parts of its nine dungeon scripts.
*
* LoA drives a challenge from each dungeon's instance script (LoadScenarioInfo, SendChallengeInfo,
* SetChallengeDoorGuid, UpdateConditionInfo, ScheduleChallenge*). Here the core does it for every
* challenge-difficulty instance of a dungeon listed below, so the dungeon scripts (which in this fork
* come from LoA, upstream SkyFire or both) need no change. The per-dungeon data is LoA's.
*
* A run: the leader clicks the Challenger's Orb (go_challenge_orb), a 5 second countdown starts, the
* start doors open and the timer runs with a gold medal that drops to silver and bronze as the
* MapChallengeMode.db2 times pass. The scenario frame counts the bosses and the elite enemies. The run is
* complete when every listed boss is done and enough enemies are dead: personal bests and medals are
* saved (character_completed_challenges), the realm best and guild best groups too, and the group gets
* the money and valor of its medal (challenge_mode_rewards). A new realm best gives its group the title
* and achievement of the map and takes the title from the previous holders.
*/

#include "InstanceScript.h"
#include "AchievementMgr.h"
#include "DatabaseEnv.h"
#include "DB2Stores.h"
#include "DBCStores.h"
#include "GameObject.h"
#include "Group.h"
#include "Map.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Opcodes.h"
#include "Player.h"
#include "ScenarioMgr.h"
#include "Util.h"
#include "WorldPacket.h"
#include "WorldSession.h"

#include <ctime>
#include <sstream>

enum ChallengeModeMisc
{
    GO_CHALLENGE_DOOR_LINE_2        = 211989,   // Challenge Mode - Start Door (Line 2.0)
    GO_CHALLENGE_DOOR_LINE_3        = 211991,   // Challenge Mode - Start Door (Line 3.0)
    CHALLENGE_START_DELAY           = 5,        // seconds of countdown
    MAX_CHALLENGE_BOSSES            = 5,
    MAX_CHALLENGE_MEMBERS           = 5
};

struct ChallengeDungeonData
{
    uint32 MapId;
    uint32 ScenarioId;                          // the challenge scenario the frame shows
    uint32 EnemiesCriteria;                     // criteria of "N enemies defeated"
    uint32 EnemiesCount;
    uint32 BossCount;
    uint32 Bosses[MAX_CHALLENGE_BOSSES][2];     // boss id (SetBossState) and its criteria
};

// From the LoA instance scripts (SCENARIO_ID, CRITERIA_ENEMIES, ENEMIES_COUNT, scenarioBosses). The boss
// ids are the same in this fork's scripts for all nine dungeons.
static ChallengeDungeonData const ChallengeDungeons[] =
{
    {  959, 46, 19994, 32, 4, { { 0, 19239 }, { 1, 19244 }, { 2, 19240 }, { 3, 20672 } } },               // Shado-Pan Monastery
    {  960, 44, 19591, 45, 4, { { 0, 19231 }, { 1, 19230 }, { 2, 19235 }, { 3, 19234 } } },               // Temple of the Jade Serpent
    {  961, 45, 19615, 25, 3, { { 0, 19236 }, { 1, 19237 }, { 2, 19108 } } },                             // Stormstout Brewery
    {  962, 48, 20017, 25, 4, { { 0, 19245 }, { 1, 19246 }, { 2, 19247 }, { 3, 19248 } } },               // Gate of the Setting Sun
    {  994, 50, 20009, 20, 3, { { 0, 20674 }, { 1, 20887 }, { 2, 19257 } } },                             // Mogu'shan Palace
    { 1001, 52, 20048, 50, 3, { { 0, 19266 }, { 1, 19268 }, { 2, 19269 } } },                             // Scarlet Halls
    { 1004, 53, 20044, 40, 3, { { 0, 19270 }, { 1, 19271 }, { 2, 533 } } },                               // Scarlet Monastery
    { 1007, 51, 20030, 35, 5, { { 0, 19259 }, { 1, 19260 }, { 2, 19261 }, { 3, 19262 }, { 4, 19263 } } }, // Scholomance
    { 1011, 49, 20023, 65, 4, { { 0, 19249 }, { 1, 19250 }, { 2, 19251 }, { 3, 19252 } } },               // Siege of Niuzao Temple
};

static MapChallengeModeEntry const* GetMapChallengeModeEntry(uint32 mapId)
{
    for (uint32 i = 0; i < sMapChallengeModeStore.GetNumRows(); ++i)
        if (MapChallengeModeEntry const* entry = sMapChallengeModeStore.LookupEntry(i))
            if (entry->MapID == mapId)
                return entry;
    return NULL;
}

ChallengeDungeonData const* InstanceScript::GetChallengeData() const
{
    if (!instance->IsChallengeDungeon())
        return NULL;

    for (uint32 i = 0; i < sizeof(ChallengeDungeons) / sizeof(ChallengeDungeons[0]); ++i)
        if (ChallengeDungeons[i].MapId == instance->GetId())
            return &ChallengeDungeons[i];
    return NULL;
}

void InstanceScript::SetChallengeModeStarted()
{
    if (challengeStarted || challengeCompleted || !GetChallengeData())
        return;

    challengeStarted = true;
    challengeStartDelay = CHALLENGE_START_DELAY * IN_MILLISECONDS;
    SendChallengeStartTimer(CHALLENGE_START_DELAY);
}

void InstanceScript::UpdateChallengeMode(uint32 diff)
{
    if (!challengeStarted || challengeCompleted)
        return;

    ChallengeDungeonData const* data = GetChallengeData();
    if (!data)
        return;

    // countdown, then the doors open and the clock starts
    if (challengeStartDelay)
    {
        if (challengeStartDelay > diff)
        {
            challengeStartDelay -= diff;
            return;
        }

        challengeStartDelay = 0;
        for (std::vector<uint64>::const_iterator itr = challengeDoorGuids.begin(); itr != challengeDoorGuids.end(); ++itr)
            if (GameObject* door = instance->GetGameObject(*itr))
                door->SetGoState(GOState::GO_STATE_ACTIVE);

        SendChallengeStartElapsedTimer(TIMER_CHALLENGE, 0);
        challengeMedal = MedalTypeGold;
        return;
    }

    challengeTime += diff;

    // drop the medal once its time has passed
    if (MapChallengeModeEntry const* entry = GetMapChallengeModeEntry(instance->GetId()))
    {
        uint32 const times[MedalTypeGold] = { entry->BronzeTime * IN_MILLISECONDS, entry->SilverTime * IN_MILLISECONDS, entry->GoldTime * IN_MILLISECONDS };
        while (challengeMedal > MedalTypeNone && challengeTime > times[challengeMedal - 1])
            --challengeMedal;
    }
}

void InstanceScript::OnChallengePlayerEnter(Player* player)
{
    ChallengeDungeonData const* data = GetChallengeData();
    if (!data || !player)
        return;

    if (!challengeCompleted)
    {
        sScenarioMgr->SendScenarioState(player, instance->GetId(), 0, 0, 0, data->ScenarioId);

        if (challengeStarted)
        {
            for (uint32 i = 0; i < data->BossCount; ++i)
                if (challengeBossesDone & (1 << i))
                    SendScenarioProgressUpdate(CriteriaProgressData(data->Bosses[i][1], 1, GetScenarioGUID(), time(NULL), challengeTime / IN_MILLISECONDS, 0), player);
            SendScenarioProgressUpdate(CriteriaProgressData(data->EnemiesCriteria, challengeEnemies, GetScenarioGUID(), time(NULL), challengeTime / IN_MILLISECONDS, 0), player);
        }
    }

    if (challengeStarted && !challengeCompleted && !challengeStartDelay)
    {
        WorldPacket packet(SMSG_START_ELAPSED_TIMER, 8);
        packet << uint32(challengeTime / IN_MILLISECONDS);
        packet << uint32(TIMER_CHALLENGE);
        player->SendDirectMessage(&packet);
    }
}

void InstanceScript::OnChallengeGameObjectCreate(GameObject* go)
{
    if (!go || (go->GetEntry() != GO_CHALLENGE_DOOR_LINE_2 && go->GetEntry() != GO_CHALLENGE_DOOR_LINE_3))
        return;

    if (!GetChallengeData())
        return;

    challengeDoorGuids.push_back(go->GetGUID());
    if (challengeStarted && !challengeStartDelay)
        go->SetGoState(GOState::GO_STATE_ACTIVE);
}

void InstanceScript::OnChallengeCreatureDeath(Creature* creature)
{
    if (!creature || !challengeStarted || challengeStartDelay || challengeCompleted)
        return;

    ChallengeDungeonData const* data = GetChallengeData();
    if (!data || challengeEnemies >= data->EnemiesCount)
        return;

    // LoA: elite, not a boss
    if (!creature->isElite() || creature->IsDungeonBoss() || creature->IsSummon() || creature->IsPet())
        return;

    ++challengeEnemies;
    SendScenarioProgressUpdate(CriteriaProgressData(data->EnemiesCriteria, challengeEnemies, GetScenarioGUID(), time(NULL), challengeTime / IN_MILLISECONDS, 0));
    TryCompleteChallenge();
}

void InstanceScript::OnChallengeBossDone(uint32 bossId)
{
    ChallengeDungeonData const* data = GetChallengeData();
    if (!data || challengeCompleted)
        return;

    for (uint32 i = 0; i < data->BossCount; ++i)
    {
        if (data->Bosses[i][0] != bossId || (challengeBossesDone & (1 << i)))
            continue;

        challengeBossesDone |= 1 << i;
        SendScenarioProgressUpdate(CriteriaProgressData(data->Bosses[i][1], 1, GetScenarioGUID(), time(NULL), challengeTime / IN_MILLISECONDS, 0));
    }

    TryCompleteChallenge();
}

void InstanceScript::TryCompleteChallenge()
{
    ChallengeDungeonData const* data = GetChallengeData();
    if (!data || !challengeStarted || challengeStartDelay || challengeCompleted)
        return;

    if (challengeBossesDone != (1u << data->BossCount) - 1 || challengeEnemies < data->EnemiesCount)
        return;

    challengeCompleted = true;
    SendChallengeStopElapsedTimer(TIMER_CHALLENGE);

    SendChallengeNewPlayerRecord();

    uint32 money = 0, valor = 0;
    RewardChallengers(money, valor);
    SendChallengeModeComplete(money, valor);

    SaveChallengeDatasIfNeeded();

    DoUpdateAchievementCriteria(ACHIEVEMENT_CRITERIA_TYPE_WIN_CHALLENGE_DUNGEON, instance->GetId(), challengeMedal);
}

void InstanceScript::SendChallengeNewPlayerRecord()
{
    uint32 const mapId = instance->GetId();
    uint32 const now = uint32(time(NULL));

    Map::PlayerList const& players = instance->GetPlayers();
    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
    {
        Player* player = itr->GetSource();
        if (!player)
            continue;

        if (CompletedChallenge* challenge = player->GetCompletedChallenge(mapId))
        {
            bool const newBestTime = challengeTime < challenge->BestTime;
            bool const newBestMedal = challengeMedal > challenge->BestMedal;

            if (newBestMedal)
            {
                challenge->BestMedal = challengeMedal;
                challenge->BestMedalDate = now;
            }
            if (newBestTime)
                challenge->BestTime = challengeTime;
            challenge->LastTime = challengeTime;

            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_COMPLETED_CHALLENGE);
            stmt->setUInt32(0, challenge->BestTime);
            stmt->setUInt32(1, challenge->LastTime);
            stmt->setUInt8(2, challenge->BestMedal);
            stmt->setUInt32(3, challenge->BestMedalDate);
            stmt->setUInt32(4, player->GetGUIDLow());
            stmt->setUInt32(5, mapId);
            CharacterDatabase.Execute(stmt);

            player->GetSession()->SendChallengeModeMapStatsUpdate(mapId);

            // the "new record" banner only for a better time
            if (!newBestTime)
                continue;
        }
        else
        {
            CompletedChallenge newChallenge;
            newChallenge.BestMedal = challengeMedal;
            newChallenge.BestMedalDate = now;
            newChallenge.BestTime = challengeTime;
            newChallenge.LastTime = challengeTime;
            player->AddCompletedChallenge(mapId, newChallenge);

            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_INS_COMPLETED_CHALLENGE);
            stmt->setUInt32(0, player->GetGUIDLow());
            stmt->setUInt32(1, mapId);
            stmt->setUInt32(2, challengeTime);
            stmt->setUInt32(3, challengeTime);
            stmt->setUInt8(4, challengeMedal);
            stmt->setUInt32(5, now);
            CharacterDatabase.Execute(stmt);

            player->GetSession()->SendChallengeModeMapStatsUpdate(mapId);
        }

        WorldPacket data(SMSG_CHALLENGE_MODE_NEW_PLAYER_RECORD, 12);
        data << uint32(mapId);
        data << uint32(challengeMedal);
        data << uint32(challengeTime);
        player->SendDirectMessage(&data);
    }
}

void InstanceScript::SendChallengeModeComplete(uint32 money, uint32 valor)
{
    uint32 const currencyRewards = valor ? 1 : 0;

    WorldPacket data(SMSG_CHALLENGE_MODE_COMPLETE, 4 * 4 + 8 + currencyRewards * 8);
    data << uint32(money);
    data << uint32(instance->GetId());
    data << uint32(challengeMedal);
    data << uint32(challengeTime);
    data.WriteBits(currencyRewards, 21);
    data.WriteBits(0, 20);                                  // item rewards
    data.FlushBits();
    if (currencyRewards)
    {
        data << uint32(CURRENCY_TYPE_VALOR_POINTS);
        data << uint32(valor);
    }
    instance->SendToPlayers(&data);
}

void InstanceScript::RewardChallengers(uint32& money, uint32& valor)
{
    ChallengeReward const* reward = sObjectMgr->GetChallengeRewardsForMap(instance->GetId());
    if (!reward || challengeMedal >= MaxMedalType)
        return;

    money = reward->MoneyReward[challengeMedal];
    valor = reward->ValorReward[challengeMedal];

    Map::PlayerList const& players = instance->GetPlayers();
    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
    {
        if (Player* player = itr->GetSource())
        {
            if (money)
                player->ModifyMoney(int64(money));
            if (valor)
                player->ModifyCurrency(CURRENCY_TYPE_VALOR_POINTS, int32(valor), true);
        }
    }
}

void InstanceScript::SaveChallengeDatasIfNeeded()
{
    uint32 const mapId = instance->GetId();

    // the realm's best group: only a faster run replaces it (copy the old one: saving replaces it)
    RealmCompletedChallenge const* stored = sObjectMgr->GetGroupCompletedChallengeForMap(mapId);
    bool const hadGroupRecord = stored != NULL;
    RealmCompletedChallenge oldGroup;
    if (stored)
        oldGroup = *stored;

    if (!hadGroupRecord || oldGroup.CompletionTime > challengeTime)
    {
        PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_DEL_GROUP_CHALLENGE);
        stmt->setUInt32(0, mapId);
        CharacterDatabase.Execute(stmt);

        SaveNewGroupChallenge();
        RewardNewRealmRecord(hadGroupRecord ? &oldGroup : NULL);
    }

    // a guild group (Group::IsGuildGroup): the guild's best run of this map
    uint32 guildId = 0;
    Map::PlayerList const& players = instance->GetPlayers();
    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end() && !guildId; ++itr)
        if (Player* player = itr->GetSource())
            if (Group* group = player->GetGroup())
                if (player->GetGuildId() && group->IsGuildGroup(player->GetGuildId(), player))
                    guildId = player->GetGuildId();

    if (!guildId)
        return;

    RealmCompletedChallenge const* guildBest = sObjectMgr->GetGuildCompletedChallengeForMap(mapId, guildId);
    if (!guildBest || guildBest->CompletionTime > challengeTime)
        SaveNewGroupChallenge(guildId);
}

void InstanceScript::SaveNewGroupChallenge(uint32 guildId /*= 0*/)
{
    uint32 const mapId = instance->GetId();

    RealmCompletedChallenge record;
    record.GuildId = guildId;
    record.AttemptId = 0;
    record.CompletionTime = challengeTime;
    record.CompletionDate = uint32(time(NULL));
    record.MedalEarned = challengeMedal;

    std::vector<Player*> members;
    Map::PlayerList const& players = instance->GetPlayers();
    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end() && members.size() < MAX_CHALLENGE_MEMBERS; ++itr)
        if (Player* player = itr->GetSource())
            members.push_back(player);
    record.MembersCount = uint8(members.size());

    // guild rows: one per guild and map (REPLACE), group row: one per map (deleted first by the caller)
    PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(guildId ? CHAR_INS_GUILD_CHALLENGE : CHAR_INS_GROUP_CHALLENGE);
    uint8 index = 0;
    stmt->setUInt32(index++, mapId);
    if (guildId)
        stmt->setUInt32(index++, guildId);
    stmt->setUInt32(index++, record.AttemptId);
    stmt->setUInt32(index++, record.CompletionTime);
    stmt->setUInt32(index++, record.CompletionDate);
    stmt->setUInt8(index++, record.MedalEarned);
    stmt->setUInt8(index++, record.MembersCount);
    for (uint8 i = 0; i < MAX_CHALLENGE_MEMBERS; ++i)
    {
        if (i < members.size())
        {
            record.Members[i].Guid = members[i]->GetGUID();
            record.Members[i].SpecId = members[i]->GetTalentSpecialization();
        }
        stmt->setUInt32(index++, GUID_LOPART(record.Members[i].Guid));
        stmt->setUInt32(index++, record.Members[i].SpecId);
    }
    CharacterDatabase.Execute(stmt);

    if (guildId)
        sObjectMgr->AddGuildCompletedChallenge(mapId, record);
    else
        sObjectMgr->AddGroupCompletedChallenge(mapId, record);
}
void InstanceScript::RewardNewRealmRecord(RealmCompletedChallenge const* oldChallenge)
{
    ChallengeReward const* reward = sObjectMgr->GetChallengeRewardsForMap(instance->GetId());
    if (!reward)
        return;

    CharTitlesEntry const* title = sCharTitlesStore.LookupEntry(reward->TitleID);
    AchievementEntry const* achievement = sAchievementMgr->GetAchievement(reward->AchievementID);
    if (!title || !achievement)
        return;

    // The previous record holders lose the title (they keep the achievement).
    if (oldChallenge)
    {
        SQLTransaction trans = CharacterDatabase.BeginTransaction();
        bool changed = false;

        for (uint8 i = 0; i < MAX_CHALLENGE_MEMBERS; ++i)
        {
            uint64 guid = oldChallenge->Members[i].Guid;
            if (!guid)
                continue;

            if (Player* player = ObjectAccessor::FindPlayer(guid))
            {
                player->SetTitle(title, true);
                continue;
            }

            uint32 const lowGuid = GUID_LOPART(guid);
            PreparedStatement* stmt = CharacterDatabase.GetPreparedStatement(CHAR_SEL_CHAR_AT_LOGIN_TITLES);
            stmt->setUInt32(0, lowGuid);
            PreparedQueryResult result = CharacterDatabase.Query(stmt);
            if (!result)
                continue;

            char const* knownTitlesStr = result->Fetch()[1].GetCString();
            if (!knownTitlesStr)
                continue;

            uint32 const titleSize = KNOWN_TITLES_SIZE * 2;
            uint32 knownTitles[titleSize];
            Tokenizer tokens(knownTitlesStr, ' ', titleSize);
            for (uint32 j = 0; j < titleSize; ++j)
                knownTitles[j] = j < tokens.size() ? uint32(atol(tokens[j])) : 0;

            knownTitles[title->bit_index / 32] &= ~(1 << (title->bit_index % 32));

            std::ostringstream stream;
            for (uint32 j = 0; j < titleSize; ++j)
                stream << knownTitles[j] << ' ';

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_UPD_CHAR_TITLES_FACTION_CHANGE);
            stmt->setString(0, stream.str());
            stmt->setUInt32(1, lowGuid);
            trans->Append(stmt);

            stmt = CharacterDatabase.GetPreparedStatement(CHAR_RES_CHAR_TITLES_FACTION_CHANGE);
            stmt->setUInt32(0, lowGuid);
            trans->Append(stmt);
            changed = true;
        }

        if (changed)
            CharacterDatabase.CommitTransaction(trans);
    }

    Map::PlayerList const& players = instance->GetPlayers();
    for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
    {
        if (Player* player = itr->GetSource())
        {
            player->SetTitle(title);
            player->CompletedAchievement(achievement);
        }
    }
}
