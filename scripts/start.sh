#!/usr/bin/env bash
# Bring up the Hello Lab. Runs the identity commands inside an Alpine container
# and writes the output to output/identity.txt.
set -euo pipefail

cd "$(dirname "$0")/.."

mkdir -p output

# Universal preflight: docker (daemon up), git, python3 must all be present.
# Friendly errors point at docs/PLATFORM_SETUP.md.
source ./scripts/preflight.sh
preflight_universal || exit 1

if ! docker compose version >/dev/null 2>&1; then
  echo "ERROR: 'docker compose' is not available."
  echo "       Install: https://docs.docker.com/compose/install/"
  exit 1
fi

echo ">> Pulling the Alpine 3.23 image (one-time, ~5 MB)..."
docker compose pull --quiet 2>/dev/null || true

echo ">> Running the identity commands..."
# --exit-code-from identity propagates the container's exit status; without it
# `docker compose up` returns 0 even on container failure, masking real errors.
# --no-log-prefix strips the "identity-1  | " prefix from each line so the
# identity.txt we tee matches the clean format documented in INSTRUCTOR.md.
docker compose up --abort-on-container-exit --exit-code-from identity --no-log-prefix 2>&1 | tee output/identity.txt

echo
echo ">> Identity commands complete. Inspect with:"
echo "   cat output/identity.txt"
echo ">> When you're satisfied, run the verifier:"
echo "   ./scripts/verify.sh"
