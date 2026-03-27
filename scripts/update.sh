#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cd "$ROOT_DIR"

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  if git remote get-url origin >/dev/null 2>&1; then
    echo "[vsdlc] Fetching latest package..."
    git pull --ff-only origin "$(git rev-parse --abbrev-ref HEAD)"
  else
    echo "[vsdlc] No remote configured, skip git pull"
  fi
else
  echo "[vsdlc] Not a git repository, skip git pull"
fi

echo "[vsdlc] Reinstalling package..."
bash "$ROOT_DIR/install.sh"

echo "[vsdlc] Update complete"
