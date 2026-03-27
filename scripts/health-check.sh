#!/usr/bin/env bash
set -euo pipefail

check() {
  local path="$1"
  local label="$2"
  if [[ -e "$path" ]]; then
    echo "[OK] $label -> $path"
  else
    echo "[MISS] $label -> $path"
  fi
}

check "$HOME/.copilot/agents/va-pm.agent.md" "Agent va-pm"
check "$HOME/.copilot/agents/va-architect.agent.md" "Agent va-architect"
check "$HOME/.copilot/copilot-instructions.md" "Global instructions"
check "$HOME/.vscode-server-insiders/data/User/prompts/sdlc-int.prompt.md" "Prompt sdlc-int"
check "$HOME/.vscode-server-insiders/data/User/prompts/sdlc-init.prompt.md" "Prompt sdlc-init"
check "$HOME/.copilot/templates/sdlc-project-template/.vscode/mcp.json" "Project MCP template"
check "$HOME/.copilot/bin/sdlc-template-init" "Bootstrap script"
