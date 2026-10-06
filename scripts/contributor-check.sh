#!/bin/sh
# Generated contributor kit v2 (policy sha256:f41137c32fe0c6fa15d6e317d1e3cc7dfbf6bd3fb5a6e942014534af8473cd28). Refreshed only by governed upgrade commits; do not edit by hand.
# Purpose: Contributor setup and local validation, derived from this product's approved collaboration policy, so a teammate and their AI run exactly the checks the station will hold them to.
# Learning objectives: See why a missing dependency or an unsupported host is reported with its own exit code instead of guessed around, and why a station-only check is printed as not run and never as passed.
# Responsibilities: Judge the host (doctor), run the declared setup commands once in a clean clone (setup), and run every declared local check while listing the station-only ones (check).
# Key concepts: Declared commands run through sh -c exactly as the policy spells them; FOUND, MISSING, HOST, UNSUPPORTED, PASS, FAIL and STATION-ONLY lines; one SUMMARY line per mode.
# Algorithms: version_at_least compares dotted versions field by field with awk; every other step is a sequential pass over the declared requirements, commands and checks.
# Assumptions: A POSIX sh with awk, grep, uname and command -v on PATH; the script is run from anywhere inside the clone and changes to the repository root itself.
# Inputs and outputs: Reads the mode argument (doctor, setup or check), the PATH and the host's uname and memory facts; writes one report line per judgement to standard output and runs only the declared commands.
# Error handling: Every failure is a printed line and a distinct exit code; nothing is retried, assumed or hidden, and a host the script cannot measure is UNSUPPORTED rather than ready.
# Complexity: Linear in the number of declared requirements, setup commands and local checks; each command runs once.
# Usage: sh scripts/contributor-check.sh doctor|setup|check
# Exit codes: 0 ready or passed, 1 a setup step or local check failed, 2 usage, 3 missing dependency, 4 unsupported host.
# Related files: AGENTS.md and CONTRIBUTING.md (the guides that explain these modes), .github/contributor-kit.json and its .LEARNING.md note (the machine-readable policy this script was derived from).
set -u
cd "$(dirname "$0")/.." || exit 2
mode="${1:-check}"
missing=0
unsupported=0
failed=0

# version_at_least FOUND MINIMUM: succeed when the dotted FOUND is at least MINIMUM.
version_at_least() {
  awk -v a="$1" -v b="$2" 'BEGIN { n = split(a, x, "."); m = split(b, y, "."); k = (n > m ? n : m); for (i = 1; i <= k; i++) { p = (i <= n ? x[i] + 0 : 0); q = (i <= m ? y[i] + 0 : 0); if (p > q) exit 0; if (p < q) exit 1 } exit 0 }'
}

# require NAME COMMAND MINIMUM INSTALL [VERSION-ARGS...]: report FOUND or MISSING, never guess.
require() {
  name="$1"; program="$2"; minimum="$3"; install="$4"; shift 4
  if ! command -v "$program" >/dev/null 2>&1; then
    printf 'MISSING %s: %s is not on PATH. %s\n' "$name" "$program" "$install"
    missing=$((missing + 1)); return
  fi
  if [ -z "$minimum" ]; then printf 'FOUND %s\n' "$name"; return; fi
  found=$("$program" "$@" 2>&1 | grep -Eo '[0-9]+(\.[0-9]+)+' | head -n 1)
  if [ -z "$found" ]; then
    printf 'MISSING %s: could not read a version from %s; %s or newer is required. %s\n' "$name" "$program" "$minimum" "$install"
    missing=$((missing + 1)); return
  fi
  if ! version_at_least "$found" "$minimum"; then
    printf 'MISSING %s: found %s, need %s or newer. %s\n' "$name" "$found" "$minimum" "$install"
    missing=$((missing + 1)); return
  fi
  printf 'FOUND %s %s\n' "$name" "$found"
}

# host: judge platform, architecture and memory; a value that cannot be measured is UNSUPPORTED, never assumed.
host() {
  os=$(uname -s 2>/dev/null | tr 'A-Z' 'a-z')
  arch=$(uname -m 2>/dev/null)
  case "$arch" in x86_64|amd64) arch=x64 ;; aarch64|arm64) arch=arm64 ;; esac
  case ' linux darwin ' in *" $os "*) printf 'HOST platform %s\n' "$os" ;; *) printf 'UNSUPPORTED platform %s: supported platforms are %s\n' "${os:-unknown}" 'linux, darwin'; unsupported=$((unsupported + 1)) ;; esac
  case ' x64 arm64 ' in *" $arch "*) printf 'HOST architecture %s\n' "$arch" ;; *) printf 'UNSUPPORTED architecture %s: supported architectures are %s\n' "${arch:-unknown}" 'x64, arm64'; unsupported=$((unsupported + 1)) ;; esac
  need=0
  if [ "$need" -gt 0 ]; then
    memory=''
    if [ -r /proc/meminfo ]; then memory=$(awk '/^MemTotal:/ { print int($2 / 1024) }' /proc/meminfo)
    elif command -v sysctl >/dev/null 2>&1; then bytes=$(sysctl -n hw.memsize 2>/dev/null); [ -n "$bytes" ] && memory=$((bytes / 1048576)); fi
    if [ -z "$memory" ]; then printf 'UNSUPPORTED memory: cannot measure installed memory on this host; %s MiB is required\n' "$need"; unsupported=$((unsupported + 1))
    elif [ "$memory" -lt "$need" ]; then printf 'UNSUPPORTED memory: %s MiB installed, %s MiB required\n' "$memory" "$need"; unsupported=$((unsupported + 1))
    else printf 'HOST memory %s MiB\n' "$memory"; fi
  fi
}

doctor() {
  require 'node' 'node' '22.0' 'Install Node.js 22 or newer from https://nodejs.org' '--version'
  host
  printf 'SUMMARY doctor missing=%s unsupported=%s\n' "$missing" "$unsupported"
  if [ "$missing" -gt 0 ]; then exit 3; fi
  if [ "$unsupported" -gt 0 ]; then exit 4; fi
}

# step KIND COMMAND: run one declared command and report it.
step() {
  sh -c "$2"
  status=$?
  if [ "$status" -eq 0 ]; then printf 'PASS %s: %s\n' "$1" "$2"; return 0; fi
  printf 'FAIL %s: %s (exit %s)\n' "$1" "$2" "$status"
  return 1
}

local_check() {
  step local "$1" || failed=$((failed + 1))
}

case "$mode" in
  doctor)
    doctor
    ;;
  setup)
    doctor
    printf 'SUMMARY setup passed\n'
    ;;
  check)
    doctor
    local_check 'npm test'
    if [ "$failed" -gt 0 ]; then printf 'SUMMARY check local=failed failed=%s station-only=0 not-run\n' "$failed"; exit 1; fi
    printf 'SUMMARY check local=passed station-only=0 not-run\n'
    ;;
  *)
    printf 'usage: sh scripts/contributor-check.sh doctor|setup|check\n' >&2
    exit 2
    ;;
esac
exit 0
