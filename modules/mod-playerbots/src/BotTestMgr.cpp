/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*/

#include "BotTestMgr.h"
#include "BotFindings.h"
#include "Chat.h"
#include "DisableMgr.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectMgr.h"
#include "Player.h"
#include "PlayerbotAI.h"
#include "PlayerbotMgr.h"
#include "QuestDef.h"
#include "SharedDefines.h"
#include "WorldSession.h"

#include <algorithm>
#include <sstream>

namespace
{
    uint32 const DISPATCH_INTERVAL = 2 * IN_MILLISECONDS;
    // With nothing running, a queued quest no bot can take is given up after this.
    uint32 const NO_BOT_TIMEOUT = 60 * IN_MILLISECONDS;
    size_t const MAX_RESULTS = 500;
    size_t const MAX_QUEUE = 2000;

    // Group, dungeon, raid and PvP quests are not something one bot can finish.
    bool IsSoloQuest(Quest const* quest)
    {
        if (quest->GetSuggestedPlayers() > 1)
            return false;
        switch (quest->GetType())
        {
            case QUEST_TYPE_GROUP:
            case QUEST_TYPE_PVP:
            case QUEST_TYPE_RAID:
            case QUEST_TYPE_DUNGEON:
            case QUEST_TYPE_HEROIC:
            case QUEST_TYPE_RAID_10:
            case QUEST_TYPE_RAID_25:
            case QUEST_TYPE_SCENARIO:
                return false;
            default:
                return true;
        }
    }
}

BotTestMgr* BotTestMgr::instance()
{
    static BotTestMgr inst;
    return &inst;
}

char const* BotTestMgr::OutcomeName(BotTestOutcome outcome)
{
    switch (outcome)
    {
        case BotTestOutcome::Pass: return "PASS";
        case BotTestOutcome::Fail: return "FAIL";
        default:                   return "SKIPPED";
    }
}

bool BotTestMgr::QueueQuest(uint32 questId, uint64 requesterGuid, uint64 botGuid)
{
    if (!sObjectMgr->GetQuestTemplate(questId) || _queue.size() >= MAX_QUEUE)
        return false;
    if (DisableMgr::IsDisabledFor(DISABLE_TYPE_QUEST, questId, nullptr))
        return false;
    for (Queued const& job : _queue)
        if (job.questId == questId)
            return false;

    Queued job;
    job.questId = questId;
    job.requester = requesterGuid;
    job.botGuid = botGuid;
    _queue.push_back(job);
    return true;
}

uint32 BotTestMgr::QueueZone(uint32 zoneId, uint64 requesterGuid)
{
    std::vector<Quest const*> quests;
    for (auto const& kv : sObjectMgr->GetQuestTemplates())
    {
        Quest const* quest = kv.second;
        if (!quest || quest->GetZoneOrSort() != int32(zoneId) || !IsSoloQuest(quest))
            continue;
        if (DisableMgr::IsDisabledFor(DISABLE_TYPE_QUEST, quest->GetQuestId(), nullptr))
            continue;
        quests.push_back(quest);
    }

    // Low quests first, so a chain is walked in order.
    std::sort(quests.begin(), quests.end(), [](Quest const* a, Quest const* b)
    {
        if (a->GetMinLevel() != b->GetMinLevel())
            return a->GetMinLevel() < b->GetMinLevel();
        return a->GetQuestId() < b->GetQuestId();
    });

    uint32 queued = 0;
    for (Quest const* quest : quests)
        if (QueueQuest(quest->GetQuestId(), requesterGuid))
            ++queued;
    return queued;
}

uint32 BotTestMgr::CountRunning() const
{
    std::vector<uint64> guids;
    sPlayerbotMgr->GetBotGuids(guids);
    uint32 running = 0;
    for (uint64 guid : guids)
        if (PlayerbotAI* ai = sPlayerbotMgr->GetBotAI(guid))
            if (ai->IsQuestTesting())
                ++running;
    return running;
}

bool BotTestMgr::Dispatch(Queued& job)
{
    if (job.botGuid)
    {
        BotTestResult result;
        result.questId = job.questId;
        result.requester = job.requester;

        PlayerbotAI* ai = sPlayerbotMgr->GetBotAI(job.botGuid);
        if (!ai)
            result.message = "the bot is not online";
        else if (ai->StartQuestTest(job.questId, job.requester, true, &result.message))
            return true;
        else if (ai->GetBot())
            result.bot = ai->GetBot()->GetName();

        Report(result);
        return true;
    }

    std::vector<uint64> guids;
    sPlayerbotMgr->GetBotGuids(guids);

    // First a bot that can take the quest as it is, then one that only needs its level changed.
    for (int pass = 0; pass < 2; ++pass)
    {
        for (uint64 guid : guids)
        {
            if (!sPlayerbotMgr->IsRandomBot(guid))
                continue;
            PlayerbotAI* ai = sPlayerbotMgr->GetBotAI(guid);
            if (!ai || ai->IsQuestTesting())
                continue;

            std::string error;
            if (ai->StartQuestTest(job.questId, job.requester, pass == 1, &error))
                return true;
            // Remember the most telling refusal, not "wrong class" from the last bot tried.
            if (job.lastError.empty() || error.find("earlier quest") != std::string::npos)
                job.lastError = error;
        }
    }
    return false;
}

void BotTestMgr::Update(uint32 diff)
{
    std::vector<BotTestResult> reported;
    {
        std::lock_guard<std::mutex> guard(_lock);
        reported.swap(_reported);
    }
    for (BotTestResult const& result : reported)
        Announce(result);

    if (_queue.empty())
        return;

    _timer += diff;
    if (_timer < DISPATCH_INTERVAL)
        return;
    uint32 const elapsed = _timer;
    _timer = 0;

    uint32 running = CountRunning();
    uint32 const limit = sPlayerbotMgr->GetTestMaxConcurrent();

    for (auto itr = _queue.begin(); itr != _queue.end() && running < limit;)
    {
        if (Dispatch(*itr))
        {
            itr = _queue.erase(itr);
            ++running;
            continue;
        }

        // While other tests run, a chain quest may just be waiting for its predecessor.
        if (running)
            itr->waitedMs = 0;
        else
            itr->waitedMs += elapsed;

        if (itr->waitedMs >= NO_BOT_TIMEOUT)
        {
            BotTestResult result;
            result.questId = itr->questId;
            result.requester = itr->requester;
            result.message = "no idle random bot can take it";
            if (!itr->lastError.empty())
                result.message += ": " + itr->lastError;
            Announce(result);
            itr = _queue.erase(itr);
            continue;
        }
        ++itr;
    }
}

uint32 BotTestMgr::StopAll()
{
    uint32 dropped = uint32(_queue.size());
    _queue.clear();

    std::vector<uint64> guids;
    sPlayerbotMgr->GetBotGuids(guids);
    for (uint64 guid : guids)
    {
        PlayerbotAI* ai = sPlayerbotMgr->GetBotAI(guid);
        if (ai && ai->IsQuestTesting())
        {
            ai->CancelQuestTest();
            ++dropped;
        }
    }
    return dropped;
}

void BotTestMgr::Report(BotTestResult const& result)
{
    std::lock_guard<std::mutex> guard(_lock);
    _reported.push_back(result);
}

void BotTestMgr::Announce(BotTestResult const& result)
{
    {
        std::lock_guard<std::mutex> guard(_lock);
        _results.push_back(result);
        if (_results.size() > MAX_RESULTS)
            _results.pop_front();
        switch (result.outcome)
        {
            case BotTestOutcome::Pass: ++_pass; break;
            case BotTestOutcome::Fail: ++_fail; break;
            default:                   ++_skipped; break;
        }
    }

    Quest const* quest = sObjectMgr->GetQuestTemplate(result.questId);
    std::ostringstream line;
    line << "[bot test] quest " << result.questId;
    if (quest)
        line << " '" << quest->GetTitle() << '\'';
    line << ": " << OutcomeName(result.outcome);
    if (!result.message.empty())
        line << " - " << result.message;
    if (!result.bot.empty())
        line << " (" << result.bot << ", " << result.seconds << "s)";

    SF_LOG_INFO("modules", "[mod-playerbots] %s", line.str().c_str());

    if (Player* requester = ObjectAccessor::FindPlayer(result.requester))
        if (WorldSession* session = requester->GetSession())
            ChatHandler(session).SendSysMessage(line.str().c_str());
}

void BotTestMgr::GetResults(std::vector<BotTestResult>& out) const
{
    std::lock_guard<std::mutex> guard(_lock);
    out.assign(_results.begin(), _results.end());
}

void BotTestMgr::GetCounts(uint32& pass, uint32& fail, uint32& skipped) const
{
    std::lock_guard<std::mutex> guard(_lock);
    pass = _pass;
    fail = _fail;
    skipped = _skipped;
}

void BotTestMgr::GetRunning(std::vector<std::string>& out) const
{
    std::vector<uint64> guids;
    sPlayerbotMgr->GetBotGuids(guids);
    for (uint64 guid : guids)
    {
        PlayerbotAI* ai = sPlayerbotMgr->GetBotAI(guid);
        if (!ai || !ai->IsQuestTesting() || !ai->GetBot())
            continue;
        std::ostringstream line;
        line << ai->GetBot()->GetName() << ": quest " << ai->GetTestQuestId() << " (" << ai->GetTestStepName() << ')';
        out.push_back(line.str());
    }
}
