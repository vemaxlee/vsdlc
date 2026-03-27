#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="${HOME}/.vsdlc-backups/$(date +%Y%m%d-%H%M%S)"
PROMPTS_DIR="${HOME}/.vscode-server-insiders/data/User/prompts"
AGENTS_DIR="${HOME}/.copilot/agents"
TEMPLATE_DIR="${HOME}/.copilot/templates/sdlc-project-template"
BIN_DIR="${HOME}/.copilot/bin"
ROOT_COPILOT_DIR="${HOME}/.copilot"

mkdir -p "$BACKUP_DIR" "$PROMPTS_DIR" "$AGENTS_DIR" "$TEMPLATE_DIR" "$BIN_DIR" "$ROOT_COPILOT_DIR"
mkdir -p "$BACKUP_DIR/agents" "$BACKUP_DIR/prompts" "$BACKUP_DIR/template"

cp -R "$AGENTS_DIR"/. "$BACKUP_DIR/agents"/ 2>/dev/null || true
cp -R "$PROMPTS_DIR"/. "$BACKUP_DIR/prompts"/ 2>/dev/null || true
cp -R "$TEMPLATE_DIR"/. "$BACKUP_DIR/template"/ 2>/dev/null || true
cp "$ROOT_COPILOT_DIR/copilot-instructions.md" "$BACKUP_DIR/copilot-instructions.md" 2>/dev/null || true
cp "$BIN_DIR/sdlc-template-init" "$BACKUP_DIR/sdlc-template-init" 2>/dev/null || true

cp -R "$ROOT_DIR/assets/agents"/. "$AGENTS_DIR"/
cp -R "$ROOT_DIR/assets/prompts"/. "$PROMPTS_DIR"/
cp -R "$ROOT_DIR/assets/templates/sdlc-project-template"/. "$TEMPLATE_DIR"/
cp "$ROOT_DIR/assets/root/copilot-instructions.md" "$ROOT_COPILOT_DIR/copilot-instructions.md"
cp "$ROOT_DIR/assets/bin/sdlc-template-init" "$BIN_DIR/sdlc-template-init"
chmod +x "$BIN_DIR/sdlc-template-init" "$ROOT_DIR/scripts/health-check.sh" "$ROOT_DIR/scripts/rollback.sh"
find "$TEMPLATE_DIR/.githooks" -type f -exec chmod +x {} \; 2>/dev/null || true

echo "vsdlc installed. Backup: $BACKUP_DIR"
bash "$ROOT_DIR/scripts/health-check.sh"
