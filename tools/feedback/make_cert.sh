#!/usr/bin/env bash
#
# This file is part of Project SkyFire https://www.projectskyfire.org.
# See LICENSE.md file for Copyright information
#
# Makes the feedback API's self-signed TLS certificate (10 years, P-256) for
# the server's addresses, and prints the SHA-256 fingerprint the launcher pins.
#
#   tools/feedback/make_cert.sh [folder] [address ...]
#
# Default folder ~/skyfire/feedback/tls; default addresses 10.147.19.198
# (ZeroTier) and 192.168.1.205 (LAN). Keeps an existing certificate: a new one
# means a launcher release with the new fingerprint.

set -euo pipefail

folder="${1:-$HOME/skyfire/feedback/tls}"
shift || true
addresses=("$@")
[ ${#addresses[@]} -gt 0 ] || addresses=(10.147.19.198 192.168.1.205)

mkdir -p "$folder"
chmod 700 "$folder"

if [ -e "$folder/cert.pem" ]; then
    echo "Keeping the existing $folder/cert.pem"
else
    san=""
    for a in "${addresses[@]}"; do
        if [[ "$a" =~ ^[0-9.]+$ ]]; then san+="IP:$a,"; else san+="DNS:$a,"; fi
    done
    openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:prime256v1 -nodes -days 3650 \
        -subj "/CN=SkyFire feedback" -addext "subjectAltName=${san%,}" \
        -keyout "$folder/key.pem" -out "$folder/cert.pem" 2>/dev/null
    chmod 600 "$folder/key.pem"
    echo "Made $folder/cert.pem for ${addresses[*]}"
fi

echo "SHA-256 fingerprint (for the launcher):"
openssl x509 -in "$folder/cert.pem" -noout -fingerprint -sha256 | sed 's/^.*=//; s/://g'
