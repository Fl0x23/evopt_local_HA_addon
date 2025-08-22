#!/usr/bin/env bash
set -euo pipefail

# Optionen aus /data/options.json lesen (vom Supervisor bereitgestellt)
OPTS_FILE="/data/options.json"
PORT=$(sed -n 's/.*"listen_port":[[:space:]]*\([0-9]\+\).*/\1/p' "$OPTS_FILE")
if [ -z "${PORT:-}" ]; then PORT=7050; fi

echo "[INFO] Starte EVopt auf Port ${PORT}"
# Die App ist ein Python-Service (siehe Repo-Struktur) und lauscht via --port
# Wir binden an 0.0.0.0, damit der HA-Host-Port durchgereicht wird.
exec python /app/app.py --host 0.0.0.0 --port "${PORT}"
