# In-game bug reports: end-to-end test

One run through the whole chain: the add-ons, the world server, the upload
API, the launcher and the GitHub worker. The parts are:

| Part | Where | What it does |
|---|---|---|
| Bug Report add-on | launcher `ClientFiles\Interface\AddOns\BugReport` | minimap button and `/bug`; sends the report (addon prefix `SFBUG`), takes the screenshot, keeps the account's upload token |
| Error Catcher add-on | launcher `ClientFiles\Interface\AddOns\!ErrorCatcher` | keeps distinct Lua errors with stack and count |
| World server | `src/server/game/Handlers/BugReportHandler.cpp` | joins the pieces, adds trusted data, saves `auth.bug_reports`, answers BUG-n, gives out upload tokens, says "fixed" at login |
| Upload API | `tools/feedback/feedback_api.py` | HTTPS, token auth; screenshots matched to reports, crash logs, Lua errors |
| Launcher | launcher `src/MoPLauncher/Feedback` | watches Screenshots while playing; crash logs and Lua errors after |
| GitHub worker | `tools/feedback/feedback_worker.py` | issues, counts instead of duplicates, closed issues mark reports fixed |

Tick each box as it passes. A failure goes back to the PR of the part it's
in, with what happened written under the box.

## 0. Before you start

- [ ] Server on a build with the bug report code; `auth` has `bug_reports`, `account_feedback_token`, `bug_report_attachment`, `feedback_crash`, `feedback_crash_group`, `feedback_lua_error_group`, `feedback_lua_error_account`, `feedback_state` (`mysql auth -e "SHOW TABLES"`).
- [ ] `systemctl is-active skyfire-world-dev skyfire-feedback-api skyfire-feedback-worker` says `active` three times, and `grep dry_run ~/skyfire/feedback/feedback.conf` says `false`.
- [ ] From the PC: `curl.exe -k https://10.147.19.198:8443/v1/ping` answers `{"ok": true, ...}` (`-k` only for this check; the launcher pins the certificate).
- [ ] The launcher (1.8.0 or later) shows **Install add-ons & patches** or **Play**; after installing, the game's AddOns list has **Bug Report** and **Error Catcher**.
- [ ] Settings: **Send my bug reports' screenshots, crash logs and add-on errors to the realm** is ticked.
- [ ] Note the time; it's the start of this test (for the checks below).

## 1. A bug report, from the game to GitHub

- [ ] Log in. The bug button sits on the minimap's edge; its tooltip says "Report a Bug". Drag it somewhere else on the edge; `/reload`: it stays there.
- [ ] Take a quest, target an NPC, click the bug button. The window shows zone, subzone, coordinates, target, class, level, spec and build.
- [ ] Category **Creature / NPC**; description with a newline, `@Willzman`, `#1`, `**bold**`, a link and an accented letter. Submit.
- [ ] The window closes, the screen is captured without it, and chat says "Your report was saved as BUG-n".
- [ ] Server: `mysql auth -e "SELECT id, character_name, category, map_id, zone_id, target_entry, status FROM bug_reports ORDER BY id DESC LIMIT 1"` shows it, with the NPC's entry and status `new`.
- [ ] The launcher's status line says it sent "a bug report screenshot" (within a few seconds, or after the game closes on an account's very first report).
- [ ] About 2 minutes after the report: GitHub has an issue `[BUG-n] Creature / NPC: ...` with labels `player-report` and `creature`. Its table shows character, realm, zone with ids, position, the NPC's name with a Wowhead link, quests with titles, client and server build; the screenshot shows (from `SkyFire_548-bug-screenshots`).
- [ ] In the issue, `@Willzman` didn't mention anyone (no notification), `#1` doesn't link, `**bold**` isn't bold and the link isn't clickable. Your account name appears nowhere.
- [ ] Take a normal screenshot (Print Screen) at least 2 minutes away from any report (closer, it counts as that report's): it is **not** on the server (`ls ~/skyfire/feedback/files/screenshots/*/`) and not in the images repository.

## 2. Limits and refusals

- [ ] A second report within a minute: "wait a minute", no new row.
- [ ] A description of under 10 characters: Submit stays greyed out.
- [ ] `curl.exe -k https://10.147.19.198:8443/v1/reports` (no token): 401.

## 3. Crash logs and Lua errors

Lua errors reach GitHub only from the sources in `lua_error_sources`
(Blizzard's UI and the launcher's add-ons). An error from `/run` counts as
typed code, not an add-on: it is kept on the server (`github_issue = 0`) but
never posted. So `/run` checks the upload; the issue checks need the posting
switched on for a moment.

- [ ] `/run error("e2e test")` twice. Exit the game. Within a few seconds the launcher says it sent "the add-on errors", and `feedback.log` has "Lua errors -> Sent".
- [ ] Server: `mysql auth -e "SELECT id, message, occurrences, github_issue FROM feedback_lua_error_group"` shows `[string "error("e2e test")"]:1: e2e test`, occurrences 2, `github_issue` 0, and GitHub has no issue for it.
- [ ] Play again, `/run error("e2e test")` once more, exit: occurrences 3 (the launcher sends the whole list again; the count isn't added up twice).
- [ ] To see the issue side: set `lua_error_sources = *` in `~/skyfire/feedback/feedback.conf`, `mysql auth -e "UPDATE feedback_lua_error_group SET github_issue = NULL WHERE github_issue = 0"` and `sudo systemctl restart skyfire-feedback-worker`. Within a minute: one `[Lua error]` issue, label `lua-error`, "Times seen" 3, the stack folded away. Another `/run error("e2e test")` and exit: the same issue's count goes to 4, no second issue. Then put `lua_error_sources` back and restart the worker.
- [ ] If the game crashes during testing (or copy an old crash `.txt` into `Errors\` and make it new: `(Get-Item <file>).LastWriteTime = Get-Date`): after exit the launcher says it sent "a crash log". GitHub: one `[Crash]` issue with the error, exception and frames only; no Windows user name, real name, computer name or folder. A second crash of the same kind raises its counts instead of opening an issue.
- [ ] With **Include crash dumps** ticked, the `.dmp` is on the server (`mysql auth -e "SELECT file_name, dump_path FROM feedback_crash"`), never on GitHub.

## 4. Fixed, and the player is told

- [ ] Close the BUG-n issue as **completed**. Within a minute: `status` is `fixed`.
- [ ] Log the reporting character in: chat says "BUG-n, which you reported, has been fixed. Thank you!". Log out and in again: not said again.
- [ ] Another report, closed as **not planned**: status `closed`, nothing said at login. Reopen it: back to `issued`.

## 5. Turned off, and catching up

- [ ] Untick the Settings box, play, send a report, exit: the report and its issue still appear, without a screenshot; nothing is uploaded.
- [ ] Tick it again. Close the launcher, start the game yourself (`Wow-64.exe`), send a report, exit, start the launcher: it sends the screenshot then.
- [ ] Stop the API (`sudo systemctl stop skyfire-feedback-api`), play, send a report, exit: no error shown, nothing sent. Start the API, restart the launcher: the screenshot goes.

## 6. Secrets

- [ ] No GitHub token in the launcher or the add-ons: `Select-String -Path MoPLauncher.exe, Interface\AddOns\BugReport\*.lua -Pattern 'github_pat_|ghp_'` finds nothing.
- [ ] `~/skyfire/feedback/feedback.conf` is mode 600 and not in any git repository.
