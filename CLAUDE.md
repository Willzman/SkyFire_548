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
