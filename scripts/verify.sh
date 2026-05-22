#!/usr/bin/env bash
# Verify the Hello Lab — confirms that ./scripts/start.sh produced valid identity output.
#
# Usage:
#   ./scripts/verify.sh
#
# Exit codes:
#   0 — all checks passed
#   1 — one or more checks failed
#   2 — environment / invocation error

set -euo pipefail
cd "$(dirname "$0")/.."

REPO_ROOT="$(pwd)"
OUTPUT_DIR="$REPO_ROOT/output"
IDENTITY_FILE="$OUTPUT_DIR/identity.txt"
REPORT="$OUTPUT_DIR/verify-report.json"

mkdir -p "$OUTPUT_DIR"

# Universal preflight: docker/git/python3 must be present. Friendly errors
# point at docs/PLATFORM_SETUP.md. We run preflight here too (not just in
# start.sh) so a student running verify.sh standalone still gets the same
# friendly errors instead of an opaque grep failure.
source ./scripts/preflight.sh
preflight_universal || exit 2

if [[ ! -f "$IDENTITY_FILE" ]]; then
  echo "ERROR: $IDENTITY_FILE not found."
  echo "       Run ./scripts/start.sh first."
  exit 2
fi

pass=0
fail=0
results=()

check() {
  local name="$1" pattern="$2" desc="$3"
  if grep -qE "$pattern" "$IDENTITY_FILE"; then
    echo "  [$name] PASS — $desc"
    results+=("\"$name\":\"pass\"")
    pass=$((pass+1))
  else
    echo "  [$name] FAIL — $desc (pattern: $pattern)"
    results+=("\"$name\":\"fail\"")
    fail=$((fail+1))
  fi
}

check "whoami-output"   "whoami:"        "identity.txt contains the whoami section"
check "hostname-output" "hostname:"      "identity.txt contains the hostname section"
check "uname-output"    "uname -a:"      "identity.txt contains the uname -a section"
check "date-output"     "date:"          "identity.txt contains the date section"
check "iso-timestamp"   "[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z" "identity.txt contains an ISO 8601 timestamp"
check "container-id"    "container id"   "identity.txt contains the container id line"

ts=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
# Strip characters that would break the JSON we emit below. Hostnames almost
# never contain double quotes or backslashes, but macOS computer names can
# (e.g., "Jane's \"MacBook\"") so we belt-and-suspender.
host=$(hostname | tr -d '"\\')
cat > "$REPORT" <<EOF
{
  "lab": "lab-00-hello-lab",
  "host": "$host",
  "timestamp": "$ts",
  "pass": $pass,
  "fail": $fail,
  "results": { $(IFS=,; echo "${results[*]}") }
}
EOF
echo
echo "Report written: $REPORT"
echo "Pass: $pass    Fail: $fail"
[[ "$fail" -eq 0 ]]
