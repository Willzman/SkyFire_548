#!/usr/bin/env bash
# Install apt packages on a GitHub Actions Ubuntu runner, falling back to other Ubuntu mirrors when the
# runner's default one (azure.archive.ubuntu.com) can't be reached. Used by ubuntu.yml and ubuntu-pch.yml.
#
# Usage: bash tools/dev/ci_apt_install.sh pkg1 pkg2 ...
#
# On 2026-11-11 every build failed for hours in "Install Ubuntu dependencies" with
# "Temporary failure resolving 'azure.archive.ubuntu.com'" (security.ubuntu.com failed too), while
# GitHub reported no incident. apt-get update only warns when indexes can't be fetched; the failure
# shows up in apt-get install, so that is what gets retried.
set -uo pipefail

if [ "$#" -eq 0 ]; then
    echo "usage: $0 package..." >&2
    exit 2
fi

APT_OPTS=(-o Acquire::Retries=3 -o Acquire::http::Timeout=30 -o Acquire::https::Timeout=30 -o DPkg::Lock::Timeout=120)

# apt can also hang with no error at all: on 2026-11-19 a pch-smoke run sat in apt-get update for 3 hours
# (after fetching every InRelease) until the job limit cancelled it. The Acquire timeouts above did not
# catch it, so each call also gets a hard limit; a call that runs out counts as failed and the next
# mirror is tried.
UPDATE_LIMIT=300    # seconds; a normal apt-get update takes under 30
INSTALL_LIMIT=900   # seconds; a normal install of the build packages takes 1-2 minutes

# Usage: run_limited <seconds> <command...>
run_limited() {
    local limit="$1"; shift
    sudo timeout --kill-after=30 "${limit}" "$@"
    local rc=$?
    if [ "${rc}" -eq 124 ] || [ "${rc}" -eq 137 ]; then
        echo "::warning::timed out after ${limit}s: $*"
    fi
    return "${rc}"
}

# The runner's own mirror first, then the main archive, then mirrors outside ubuntu.com
# (in case it is name resolution for *.ubuntu.com that is failing).
FALLBACK_MIRRORS=(
    "http://archive.ubuntu.com/ubuntu/"
    "http://mirrors.edge.kernel.org/ubuntu/"
    "http://mirrors.mit.edu/ubuntu/"
)

try_install() {
    run_limited "${UPDATE_LIMIT}" apt-get update "${APT_OPTS[@]}" || return 1
    run_limited "${INSTALL_LIMIT}" env DEBIAN_FRONTEND=noninteractive apt-get install -y "${APT_OPTS[@]}" "$@"
}

use_mirror() {
    local mirror="$1"
    echo "::warning::apt install failed; switching Ubuntu mirror to ${mirror}"
    # Runner images point their sources at a mirror list file; replace its contents
    if [ -f /etc/apt/apt-mirrors.txt ]; then
        echo "${mirror}" | sudo tee /etc/apt/apt-mirrors.txt > /dev/null
    fi
    # ...and rewrite any direct archive/security URIs in the sources files too
    local files=()
    [ -f /etc/apt/sources.list ] && files+=(/etc/apt/sources.list)
    for f in /etc/apt/sources.list.d/*.list /etc/apt/sources.list.d/*.sources; do
        [ -f "$f" ] && files+=("$f")
    done
    if [ "${#files[@]}" -gt 0 ]; then
        local exprs=(
            -e "s#https?://([a-z0-9-]+\.)?archive\.ubuntu\.com/ubuntu/?#${mirror}#g"
            -e "s#https?://security\.ubuntu\.com/ubuntu/?#${mirror}#g"
        )
        # a mirror set by an earlier fallback round
        local previous
        for previous in "${FALLBACK_MIRRORS[@]}"; do
            [ "${previous}" != "${mirror}" ] && exprs+=(-e "s#${previous}#${mirror}#g")
        done
        sudo sed -i -E "${exprs[@]}" "${files[@]}"
    fi
}

if try_install "$@"; then
    exit 0
fi

for mirror in "${FALLBACK_MIRRORS[@]}"; do
    use_mirror "${mirror}"
    if try_install "$@"; then
        exit 0
    fi
done

echo "::error::apt install failed on every mirror: $*" >&2
exit 1
