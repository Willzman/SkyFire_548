# SkyFire_548 — notes for Claude

## Branch workflow

- `Development` — integration branch. **All new work targets `Development`**:
  branch from `Development`, and open pull requests against `Development`.
- `Stable` — tested releases only. Changes reach `Stable` exclusively via a
  pull request from `Development`; never push to `Stable` directly.
- `main` — mirror of upstream SkyFire (see below); do not target it for new work.

## Upstream SkyFire updates

This repo is a fork. `main` mirrors upstream SkyFire and receives no local
work. Bring upstream changes in as `main` -> `Development` (test) -> `Stable`;
never merge `main` straight into `Stable`.

This fork builds and runs on Ubuntu 24.04 only. The Windows build workflow
(`windows.yml`) and Windows build scripts (`SkyFire-Build.ps1`,
`skyfire-build.config.ps1.example`, `skyfire-updater.bat`,
`contrib/update merge.bat`) were removed. If an upstream sync conflicts
because upstream changed one of them, resolve by keeping it deleted.
`tools/dev/*.ps1` stay: CI runs them with PowerShell.

## SQL updates

- Put new SQL in `sql/pending_updates/<auth|characters|world>/`. Make it safe
  to run twice (e.g. `DELETE` before `INSERT`, `IF NOT EXISTS`): development
  realms import pending files, then import them again after promotion
  renames them.
- On push to `Development`, `promote-pending-sql.yml` moves them into
  `sql/updates/<db>/` as `YYYY_MM_DD_<db>_custom_NN.sql`. The `custom` part
  keeps local updates from ever sharing a filename with upstream's
  `YYYY_MM_DD_<db>_NN.sql` files; updates are tracked by filename, so a
  shared name would cause one of them to be skipped silently.
- Never rename a file in `sql/updates/` once it is merged.
- Never name a database in update SQL: no `USE`, no `CREATE DATABASE`, no
  `world.`/`auth.`/`characters.` prefixes. Each realm applies the same files
  to its own databases. Use `DATABASE()` when you need the current one.
- `.github/workflows/sql-names.yml` runs `tools/dev/check_sql_names.py` on
  pushes and pull requests to `Development`/`Stable`. Run it locally with
  `python3 tools/dev/check_sql_names.py --base origin/Development` before
  pushing SQL changes.

## Two realms

Stable and Development run side by side: shared `auth`, separate
`world_stable`/`characters_stable` and `world_dev`/`characters_dev`. Database
and config setup lives in `sql/create/*_realms.sql` and `tools/realms/`; keep
those identical on both branches (no branch-specific values in tracked files).
