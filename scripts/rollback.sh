#!/usr/bin/env bash
set -euo pipefail

BACKUP_ROOT="${HOME}/.vsdlc-backups"
BACKUP_DIR="${1:-$(ls -1dt "$BACKUP_ROOT"/* 2>/dev/null | head -n 1)}"

if [[ -z "${BACKUP_DIR:-}" || ! -d "$BACKUP_DIR" ]]; then
  echo "No backup directory found." >&2
  exit 1
fi

restore_dir() {
  local src="$1"
  local dest="$2"
  if [[ -d "$src" ]]; then
    mkdir -p "$dest"
    cp -R "$src"/. "$dest"/
  fi
}

restore_file() {
  local src="$1"
  local dest="$2"
  if [[ -f "$src" ]]; then
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
  fi
}

restore_dir "$BACKUP_DIR/agents" "$HOME/.copilot/agents"
restore_dir "$BACKUP_DIR/prompts" "$HOME/.vscode-server-insiders/data/User/prompts"
restore_dir "$BACKUP_DIR/template" "$HOME/.copilot/templates/sdlc-project-template"
restore_file "$BACKUP_DIR/copilot-instructions.md" "$HOME/.copilot/copilot-instructions.md"
restore_file "$BACKUP_DIR/sdlc-template-init" "$HOME/.copilot/bin/sdlc-template-init"

echo "Restored from backup: $BACKUP_DIR"
