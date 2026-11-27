# Player feedback: upload API and GitHub worker

Bug reports come from the launcher's **Bug Report** add-on: the world server
saves them in `auth.bug_reports` (`src/server/game/Handlers/BugReportHandler.cpp`).
The launcher then uploads what the game left on the player's PC: the bug
report's screenshot, crash logs from `Errors\` and the **Error Catcher**
add-on's Lua errors. This folder holds the two services for that:

- `feedback_api.py`: the HTTPS upload API the launcher talks to. Every upload
  carries the account's upload token (the world server gives it to the add-on,
  the launcher reads it from the add-on's SavedVariables), so nothing is open.
- `feedback_worker.py`: posts to GitHub. One issue per bug report (labels
  `player-report` and its category) with a context table and the screenshots;
  one issue per crash signature (`crash`) and per Lua error (`lua-error`),
  whose counts it then keeps up to date instead of opening duplicates. When a
  `player-report` issue is closed as completed, the report becomes `fixed` and
  the player is told at their next login.

Both are plain Python 3 with `python3-pymysql` (and `python3-pil` to turn TGA
screenshots into PNG). Tables: `sql/pending_updates/auth/bug_reports.sql` and
`feedback_uploads.sql`.

## What goes public

The issues repository is public, so the worker posts only:

- the player's text, with every markdown character escaped, HTML, links,
  `@mentions` and `#123` references broken (`feedback_common.markdown_text`);
- character name, level, race, class, spec, where they were, target, quests,
  client and server builds (never the account);
- screenshots, which the player took by sending the report;
- for crashes, a short summary: error, exception, top frames as module+offset,
  build and session times. The full logs name the PC's user, the person's
  real name, the computer and folders, and the `.dmp` holds memory: they stay
  on the server, in `[api] storage`.

## GitHub setup

Two fine-grained personal access tokens, so neither can do more than its job
(GitHub gives a token the same permissions on every repository it covers):

1. **Issues token**: repository access *Only select repositories* →
   `Willzman/SkyFire_548`; permissions *Issues: Read and write* (GitHub adds
   *Metadata: Read*). Nothing else.
2. **Images repository**: a new public repository (for example
   `Willzman/SkyFire_548-bug-screenshots`) with one first commit on `main`
   (tick "Add a README"). GitHub's API can't attach images to issues, and
   GitHub can't load images from a ZeroTier-only server, so the worker commits
   each screenshot there and links its raw URL.
3. **Images token**: only that images repository; *Contents: Read and write*.

Put both in the config file below. They never go in the launcher, the
add-ons or this repository.

## Server setup (mopserverpc)

```bash
sudo apt-get install -y python3-pymysql python3-pil
mysql auth < ~/skyfire/src-dev/sql/pending_updates/auth/bug_reports.sql
mysql auth < ~/skyfire/src-dev/sql/pending_updates/auth/feedback_uploads.sql

mkdir -p ~/skyfire/feedback/app
install -m 644 ~/skyfire/src-dev/tools/feedback/*.py ~/skyfire/feedback/app/
cp ~/skyfire/src-dev/tools/feedback/feedback.conf.dist ~/skyfire/feedback/feedback.conf
chmod 600 ~/skyfire/feedback/feedback.conf       # then fill in [github]
bash ~/skyfire/src-dev/tools/feedback/make_cert.sh  # prints the fingerprint for the launcher

sudo ufw allow from 10.147.19.0/24 to any port 8443 proto tcp comment 'feedback api'
sudo ufw allow from 192.168.1.0/24 to any port 8443 proto tcp comment 'feedback api'

sudo cp ~/skyfire/src-dev/tools/feedback/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now skyfire-feedback-api skyfire-feedback-worker
```

The services run the copy in `~/skyfire/feedback/app`, so switching
`src-dev` to another branch doesn't touch them; re-run the `install` line
after an update. Logs: `journalctl -u skyfire-feedback-api` / `-worker`.

`dry_run = true` (the default) makes the worker write what it would post to
`dryrun_dir` and change nothing; `python3 feedback_worker.py --dry-run` does
one such pass by hand. Set `dry_run = false` once the tokens are in.

## API

All but `/v1/ping` need `Authorization: Bearer <upload token>`. Uploads send
the file as the body with `X-File-Name`, `X-File-Time` (the file's time on the
PC) and `X-Client-Time` (the PC's clock now), so the server can move PC times
onto its own clock.

| Request | Does |
|---|---|
| `GET /v1/ping` | `{"ok": true, "server_time": ...}` |
| `GET /v1/reports?since=<unix>` | the account's reports of the last 7 days (id, `created_at`) and the screenshot time window, so the launcher only sends matching screenshots |
| `POST /v1/screenshot` | JPEG, PNG or TGA. Kept only if one of the account's reports was saved between `screenshot_window_after` s before and `screenshot_window_before` s after it was taken; otherwise 404 and nothing is stored |
| `POST /v1/crash` | an `Errors\*.txt` crash log; grouped by signature |
| `POST /v1/crash-dump` | its `.dmp` (same name), after the `.txt` |
| `POST /v1/lua-errors` | `SavedVariables\!ErrorCatcher.lua`; each account's count per error is kept, so sending the whole file again doesn't add up twice |

Limits (sizes, a daily quota per account, requests per minute, free disk) are
in `[api]`. Lua errors are posted only from the sources in
`lua_error_sources` (Blizzard's UI and the launcher's add-ons by default); the
others are kept with `github_issue = 0`.

## Tests

```bash
cd tools/feedback && python3 -m unittest test_feedback
```
