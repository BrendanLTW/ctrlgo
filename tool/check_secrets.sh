#!/usr/bin/env bash
# Fails if a Google API key (they all start "AIza") is in any file git tracks.
# Run locally and in CI. Keys belong in the git-ignored env.json.
set -euo pipefail
cd "$(dirname "$0")/.."

if git grep -nIE 'AIza[0-9A-Za-z_-]{35}' -- . ':!tool/check_secrets.sh'; then
  echo "Google API key found in a tracked file. Move it to env.json (README › Setup)." >&2
  exit 1
fi
echo "No API keys in tracked files."
