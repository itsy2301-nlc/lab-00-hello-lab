#!/usr/bin/env bash
# Lab-00 universal preflight. Verifies that the host has the toolchain every
# lab in the ITSY-2301 suite assumes: docker (daemon up), git, python3.
#
# Usage:
#   ./scripts/preflight.sh                       (run the checks directly)
#   source ./scripts/preflight.sh                (define preflight_universal
#                                                 without running it; the
#                                                 caller invokes it themselves)
#
# Exit codes (when run directly):
#   0 — all checks passed
#   1 — at least one check failed
#
# Friendly error messages point at docs/PLATFORM_SETUP.md when a tool is
# missing. The script does NOT check version numbers — existence is enough.

check_cmd() {
    # check_cmd <command> <human-name> <hint>
    local cmd="$1" name="$2" hint="$3"
    if command -v "$cmd" >/dev/null 2>&1; then
        printf "  ✓ %-10s found at %s\n" "$name" "$(command -v "$cmd")"
        return 0
    else
        printf "  ✗ %-10s MISSING — %s\n" "$name" "$hint" >&2
        return 1
    fi
}

preflight_universal() {
    local fail=0
    echo "Preflight: checking universal toolchain"
    check_cmd docker  "docker"  "see docs/PLATFORM_SETUP.md, your platform's Docker step" || fail=1
    check_cmd git     "git"     "see docs/PLATFORM_SETUP.md, your platform's Git step"    || fail=1
    check_cmd python3 "python3" "see docs/PLATFORM_SETUP.md, your platform's Python step" || fail=1
    if (( fail )); then
        echo >&2
        echo "One or more required tools are missing. Open docs/PLATFORM_SETUP.md and complete the steps for your operating system before continuing." >&2
        return 1
    fi
    # Existence is necessary but not sufficient — the daemon also needs to be up.
    if ! docker info >/dev/null 2>&1; then
        printf "  ✗ %-10s daemon NOT RUNNING — start Docker Desktop (Windows/macOS) or run 'sudo systemctl start docker' (Linux)\n" "docker" >&2
        return 1
    fi
    printf "  ✓ %-10s daemon is up\n" "docker"
    return 0
}

# If executed directly (not sourced), run the universal check.
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    preflight_universal
fi
