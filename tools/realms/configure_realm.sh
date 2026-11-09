#!/usr/bin/env bash
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
# Configure an installed server as the Stable or Development realm so both can
# run side by side on one machine against one MySQL server.
#
#   Realm         RealmID  Port  World DB       Characters DB      Pending SQL
#   stable        1        8085  world_stable   characters_stable  off
#   dev           2        8086  world_dev      characters_dev     on
#
# Both realms share the `auth` database. Only the Stable install's authserver
# should run; this script configures authserver.conf for stable only.
#
# Creates <prefix>/etc/*.conf from *.conf.dist when missing, then sets only the
# keys below, so it is safe to re-run after every install. Other settings you
# changed by hand are kept.
#
# See tools/realms/README.md for the full setup.

set -euo pipefail

usage() {
    cat <<'USAGE'
Usage: configure_realm.sh <stable|dev> --prefix DIR --sql DIR [options]

Required:
  --prefix DIR     Install prefix of this realm (contains bin/ and etc/)
  --sql DIR        This realm's source sql/ directory (for startup SQL updates)

Options:
  --data DIR       Client data directory (dbc, maps, vmaps, mmaps)
  --db-host HOST   MySQL host      (default 127.0.0.1)
  --db-port PORT   MySQL port      (default 3306)
  --db-user USER   MySQL user      (default skyfire)
  --db-pass PASS   MySQL password  (default skyfire)
  -h, --help       Show this help
USAGE
}

die() { echo "configure_realm: $*" >&2; exit 1; }

[[ $# -ge 1 ]] || { usage >&2; exit 1; }
case "$1" in
    -h|--help) usage; exit 0 ;;
    stable|dev) REALM=$1; shift ;;
    *) die "first argument must be 'stable' or 'dev', got '$1'" ;;
esac

PREFIX="" SQL_DIR="" DATA_DIR=""
DB_HOST=127.0.0.1 DB_PORT=3306 DB_USER=skyfire DB_PASS=skyfire

while [[ $# -gt 0 ]]; do
    [[ $1 == -h || $1 == --help ]] && { usage; exit 0; }
    [[ $# -ge 2 ]] || die "missing value for $1"
    case "$1" in
        --prefix)  PREFIX=$2 ;;
        --sql)     SQL_DIR=$2 ;;
        --data)    DATA_DIR=$2 ;;
        --db-host) DB_HOST=$2 ;;
        --db-port) DB_PORT=$2 ;;
        --db-user) DB_USER=$2 ;;
        --db-pass) DB_PASS=$2 ;;
        *) die "unknown option '$1'" ;;
    esac
    shift 2
done

[[ -n $PREFIX ]] || die "--prefix is required"
[[ -n $SQL_DIR ]] || die "--sql is required"
ETC="$PREFIX/etc"
[[ -d $ETC ]] || die "'$ETC' not found; install the server first (cmake --install)"
[[ -d $SQL_DIR/updates ]] || die "'$SQL_DIR' has no updates/ folder; pass the source tree's sql/ directory"
SQL_DIR=$(cd "$SQL_DIR" && pwd)
if [[ -n $DATA_DIR ]]; then
    [[ -d $DATA_DIR ]] || die "data directory '$DATA_DIR' not found"
    DATA_DIR=$(cd "$DATA_DIR" && pwd)
fi

if [[ $REALM == stable ]]; then
    REALM_ID=1 WORLD_PORT=8085 RA_PORT=3443 SOAP_PORT=7878 PENDING=0
    WORLD_DB=world_stable CHAR_DB=characters_stable
else
    REALM_ID=2 WORLD_PORT=8086 RA_PORT=3444 SOAP_PORT=7879 PENDING=1
    WORLD_DB=world_dev CHAR_DB=characters_dev
fi
DB_PREFIX="$DB_HOST;$DB_PORT;$DB_USER;$DB_PASS"

# Copy <name>.conf.dist to <name>.conf if the .conf does not exist yet.
ensure_conf() {
    local conf="$ETC/$1.conf" dist="$ETC/$1.conf.dist"
    if [[ ! -f $conf ]]; then
        [[ -f $dist ]] || die "neither $conf nor $dist exists"
        cp "$dist" "$conf"
        echo "Created $conf"
    fi
}

# set_key FILE KEY VALUE: replace the active "KEY = ..." line. Values are
# written verbatim, so quote strings yourself. Fails if the key is missing.
set_key() {
    local file=$1 key=$2 value=$3 tmp
    tmp=$(mktemp)
    if ! KEY=$key VALUE=$value awk '
        BEGIN { key = ENVIRON["KEY"]; value = ENVIRON["VALUE"]; found = 0 }
        {
            line = $0
            sub(/^[ \t]+/, "", line)
            if (index(line, key) == 1) {
                rest = substr(line, length(key) + 1)
                if (rest ~ /^[ \t]*=/) { print key " = " value; found = 1; next }
            }
            print
        }
        END { exit found ? 0 : 1 }' "$file" > "$tmp"; then
        rm -f "$tmp"
        die "key '$key' not found in $file"
    fi
    cat "$tmp" > "$file"
    rm -f "$tmp"
}

ensure_conf worldserver
W="$ETC/worldserver.conf"
set_key "$W" RealmID "$REALM_ID"
set_key "$W" WorldServerPort "$WORLD_PORT"
set_key "$W" Ra.Port "$RA_PORT"
set_key "$W" SOAP.Port "$SOAP_PORT"
set_key "$W" LoginDatabaseInfo "\"$DB_PREFIX;auth\""
set_key "$W" WorldDatabaseInfo "\"$DB_PREFIX;$WORLD_DB\""
set_key "$W" CharacterDatabaseInfo "\"$DB_PREFIX;$CHAR_DB\""
set_key "$W" WorldDatabase.SqlPath "\"$SQL_DIR\""
set_key "$W" CharacterDatabase.SqlPath "\"$SQL_DIR\""
set_key "$W" WorldDatabase.ImportPendingUpdates "$PENDING"
set_key "$W" CharacterDatabase.ImportPendingUpdates "$PENDING"
if [[ -n $DATA_DIR ]]; then set_key "$W" DataDir "\"$DATA_DIR\""; fi
mkdir -p "$PREFIX/logs"
set_key "$W" LogsDir "\"$PREFIX/logs\""
echo "Configured $W as the $REALM realm (RealmID $REALM_ID, port $WORLD_PORT, $WORLD_DB / $CHAR_DB)"

if [[ $REALM == stable ]]; then
    ensure_conf authserver
    A="$ETC/authserver.conf"
    set_key "$A" LoginDatabaseInfo "\"$DB_PREFIX;auth\""
    set_key "$A" LoginDatabase.SqlPath "\"$SQL_DIR\""
    set_key "$A" LoginDatabase.ImportPendingUpdates 0
    set_key "$A" LogsDir "\"$PREFIX/logs\""
    echo "Configured $A (shared auth database)"
fi

# Module configs are read from etc/ next to worldserver.conf.
for dist in "$ETC"/*.conf.dist; do
    name=$(basename "$dist" .conf.dist)
    case "$name" in worldserver|authserver) continue ;; esac
    ensure_conf "$name"
done
