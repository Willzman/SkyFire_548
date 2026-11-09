# SkyFire_548 — notes for Claude

## Branch workflow

- `Development` — integration branch. **All new work targets `Development`**:
  branch from `Development`, and open pull requests against `Development`.
- `Stable` — tested releases only. Changes reach `Stable` exclusively via a
  pull request from `Development`; never push to `Stable` directly.
- `main` — legacy default branch; do not target it for new work unless asked.
