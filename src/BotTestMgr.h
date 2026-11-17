/*
* This file is part of Project SkyFire https://www.projectskyfire.org.
* See LICENSE.md file for Copyright information
*
* Playerbots module - directed test runs.
*
* A GM queues quests (`.playerbots test quest <id>`, `.playerbots test zone`);
* the manager hands each one to an idle random bot that can take it, the bot
* plays it from starter to turn-in (PlayerbotAI::UpdateQuestTest) and reports
* pass / fail / skipped with the step that failed. Results are kept in memory
* for `.playerbots test status|results`; failures also become findings.
*
* Report() is called from bot AI on map threads; everything else runs on the
* world thread.
*/

#ifndef _SF_BOT_TEST_MGR_H
#define _SF_BOT_TEST_MGR_H

#include "Define.h"
#include <deque>
#include <mutex>
#include <string>
#include <vector>

class Player;

enum class BotTestOutcome : uint8
{
    Pass,
    Fail,
    // The quest could not be exercised: no bot may take it, or an objective needs a human.
    Skipped
};

struct BotTestResult
{
    uint32 questId = 0;
    BotTestOutcome outcome = BotTestOutcome::Skipped;
    std::string bot;
    std::string message;
    uint32 seconds = 0;
    uint64 requester = 0;
};

class BotTestMgr
{
public:
    static BotTestMgr* instance();

    // botGuid 0 = any idle random bot. False when the quest does not exist or is already queued.
    bool QueueQuest(uint32 questId, uint64 requesterGuid, uint64 botGuid = 0);
    // Every quest sorted under the zone. Returns the number queued.
    uint32 QueueZone(uint32 zoneId, uint64 requesterGuid);

    void Update(uint32 diff);
    // Drops the queue and aborts running tests. Returns how many were dropped.
    uint32 StopAll();

    void Report(BotTestResult const& result);

    uint32 GetQueuedCount() const { return uint32(_queue.size()); }
    void GetResults(std::vector<BotTestResult>& out) const;
    void GetCounts(uint32& pass, uint32& fail, uint32& skipped) const;
    // "Bot: quest 123 (step)" for every running test.
    void GetRunning(std::vector<std::string>& out) const;

    static char const* OutcomeName(BotTestOutcome outcome);

private:
    BotTestMgr() = default;

    struct Queued
    {
        uint32 questId = 0;
        uint64 requester = 0;
        uint64 botGuid = 0;
        uint32 waitedMs = 0;
        std::string lastError;
    };

    bool Dispatch(Queued& job);
    void Announce(BotTestResult const& result);
    uint32 CountRunning() const;

    uint32 _timer = 0;
    std::deque<Queued> _queue;

    mutable std::mutex _lock;
    std::vector<BotTestResult> _reported; // from map threads, drained in Update
    std::deque<BotTestResult> _results;
    uint32 _pass = 0;
    uint32 _fail = 0;
    uint32 _skipped = 0;
};

#define sBotTestMgr BotTestMgr::instance()

#endif // _SF_BOT_TEST_MGR_H
