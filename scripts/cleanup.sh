#!/usr/bin/env bash
# Stop and remove the lab containers and the output directory.
set -euo pipefail
cd "$(dirname "$0")/.."

docker compose down --remove-orphans 2>/dev/null || true
rm -rf output/
echo "Lab cleaned up. Re-run ./scripts/start.sh to restart."
