#!/usr/bin/env bash
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
# Runs tools/dev/promote_pending_updates.ps1 with PowerShell against a
# throwaway SQL tree and checks the result, so the promotion workflow is
# verified on the same OS it runs on (Ubuntu). Needs pwsh.

set -euo pipefail

SCRIPT="$(cd "$(dirname "$0")" && pwd)/promote_pending_updates.ps1"
command -v pwsh >/dev/null || { echo "pwsh not found" >&2; exit 1; }

T=$(mktemp -d)
trap 'rm -rf "$T"' EXIT
for d in auth characters world; do mkdir -p "$T/sql/pending_updates/$d" "$T/sql/updates/$d"; done

echo "upstream"  > "$T/sql/updates/world/2026_01_01_world_00.sql"
echo "custom0"   > "$T/sql/updates/world/2026_01_01_world_custom_00.sql"
echo "fix b"     > "$T/sql/pending_updates/world/b_fix.sql"
echo "fix a"     > "$T/sql/pending_updates/world/a_fix.sql"
echo "auth fix"  > "$T/sql/pending_updates/auth/x.sql"

fail() { echo "FAIL: $*" >&2; find "$T/sql" -type f | sort >&2; exit 1; }
expect() { # expect FILE CONTENT
    [[ -f $T/$1 ]] || fail "missing $1"
    [[ $(cat "$T/$1") == "$2" ]] || fail "$1 has '$(cat "$T/$1")', expected '$2'"
}
gone() { [[ ! -e $T/$1 ]] || fail "$1 should have been moved"; }

run() { pwsh -NoProfile -NonInteractive -File "$SCRIPT" -Root "$T" -PromotionDate 2026_01_01 "$@"; }

# Dry run changes nothing.
out=$(run -Suffix custom)
grep -q "DRY-RUN: sql/pending_updates/world/a_fix.sql -> sql/updates/world/2026_01_01_world_custom_01.sql" <<<"$out" \
    || fail "unexpected dry-run output: $out"
expect sql/pending_updates/world/a_fix.sql "fix a"

# Apply with the fork suffix: numbered after existing custom files only,
# in source-name order, upstream file untouched.
run -Suffix custom -Apply >/dev/null
expect sql/updates/world/2026_01_01_world_custom_01.sql "fix a"
expect sql/updates/world/2026_01_01_world_custom_02.sql "fix b"
expect sql/updates/auth/2026_01_01_auth_custom_00.sql "auth fix"
expect sql/updates/world/2026_01_01_world_00.sql "upstream"
gone sql/pending_updates/world/a_fix.sql
gone sql/pending_updates/auth/x.sql

# Without -Suffix the upstream numbering ignores custom files.
echo "plain" > "$T/sql/pending_updates/world/c.sql"
run -Apply >/dev/null
expect sql/updates/world/2026_01_01_world_01.sql "plain"

echo "promote_pending_updates.ps1 OK on $(uname -s)"
