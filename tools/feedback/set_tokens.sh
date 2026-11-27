#!/usr/bin/env bash
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
# Puts the feedback worker's two GitHub tokens into its config file. You paste
# them here yourself (nothing is shown or logged), so they only ever exist on
# GitHub and in that file. Run it on the server, in a terminal:
#
#   ssh -t william@<server> ~/skyfire/src-dev/tools/feedback/set_tokens.sh [config]
#
# Each token is checked with GitHub (one read-only request) before it's saved;
# when one is already saved, Enter keeps it (to replace just the other).
# Then it offers to turn the worker on. See README.md, "GitHub setup".

set -euo pipefail

config="${1:-$HOME/skyfire/feedback/feedback.conf}"
here="$(cd "$(dirname "$0")" && pwd)"

[ -t 0 ] || { echo "Run this in a terminal (ssh -t ...): it asks for the tokens." >&2; exit 1; }
[ -f "$config" ] || { echo "No $config yet: copy $here/feedback.conf.dist there first (README.md)." >&2; exit 1; }

value() { sed -n "s/^$1[[:space:]]*=[[:space:]]*//p" "$config" | head -1; }
issues_repo="$(value repo)"
images_repo="$(value images_repo)"
[ -n "$issues_repo" ] && [ -n "$images_repo" ] || { echo "Set repo and images_repo in $config first." >&2; exit 1; }

# Asks for one token and checks it can read the repository. Prints it on stdout.
ask() {
    local what="$1" repo="$2" saved="$3" token status
    while true; do
        if [ -n "$saved" ]; then
            read -rsp "Paste the new $what token (for $repo), or just Enter to keep the saved one: " token </dev/tty
        else
            read -rsp "Paste the $what token (for $repo), then Enter: " token </dev/tty
        fi
        echo >&2
        if [ -z "$token" ] && [ -n "$saved" ]; then
            echo "  Keeping the saved one." >&2
            printf '%s' "$saved"
            return
        fi
        if [[ "$token" == ghp_* || "$token" == gho_* ]]; then
            echo "That's a classic token, which can reach every repository you can. Make a fine-grained one (github_pat_...)." >&2
            continue
        fi
        if [[ ! "$token" =~ ^github_pat_[A-Za-z0-9_]{20,}$ ]]; then
            echo "That doesn't look like a fine-grained token (github_pat_...). Try again, or Ctrl+C to stop." >&2
            continue
        fi
        status="$(curl -s -o /dev/null -w '%{http_code}' -K - <<<"header = \"Authorization: Bearer $token\"
header = \"Accept: application/vnd.github+json\"
header = \"User-Agent: skyfire-feedback-setup\"
url = \"https://api.github.com/repos/$repo\"")"
        if [ "$status" = 200 ]; then
            echo "  OK: GitHub accepts it." >&2
            printf '%s' "$token"
            return
        fi
        echo "  GitHub answered $status (401: wrong or expired token; 404: the token can't see $repo). Try again." >&2
    done
}

issues_token="$(ask "Issues" "$issues_repo" "$(value issues_token)")"
images_token="$(ask "Images" "$images_repo" "$(value images_token)")"

# Written by Python from stdin, so the tokens never appear in a command line.
printf '%s\n%s\n' "$issues_token" "$images_token" | python3 -c '
import os, re, sys
path = sys.argv[1]
issues, images = sys.stdin.read().split("\n")[:2]
text = open(path, encoding="utf-8").read()
for key, val in (("issues_token", issues), ("images_token", images), ("dry_run", "false")):
    text, n = re.subn(r"(?m)^" + key + r"[ \t]*=.*$", key + " = " + val, text, count=1)
    if n != 1:
        sys.exit(f"{key} not found in {path}")
fd = os.open(path + ".new", os.O_WRONLY | os.O_CREAT | os.O_TRUNC, 0o600)
with os.fdopen(fd, "w", encoding="utf-8") as f:
    f.write(text)
os.replace(path + ".new", path)
' "$config"
chmod 600 "$config"
unset issues_token images_token
echo "Saved both tokens in $config (dry_run = false)."

unit=/etc/systemd/system/skyfire-feedback-worker.service
read -rp "Turn the GitHub worker on now? [y/N] " answer </dev/tty
if [[ "$answer" =~ ^[Yy] ]]; then
    [ -f "$unit" ] || sudo cp "$here/systemd/skyfire-feedback-worker.service" "$unit"
    sudo systemctl daemon-reload
    sudo systemctl enable --now skyfire-feedback-worker
    sleep 5
    systemctl --no-pager --lines=5 status skyfire-feedback-worker || true
else
    echo "Later: sudo systemctl enable --now skyfire-feedback-worker"
fi
