$checks = @(
  @{ Path = "$HOME/.copilot/agents/va-pm.agent.md"; Label = "Agent va-pm" },
  @{ Path = "$HOME/.copilot/copilot-instructions.md"; Label = "Global instructions" },
  @{ Path = "$HOME/.vscode-server-insiders/data/User/prompts/sdlc-load.prompt.md"; Label = "Prompt sdlc-load" },
  @{ Path = "$HOME/.copilot/templates/sdlc-project-template/.vscode/mcp.json"; Label = "Project MCP template" },
  @{ Path = "$HOME/.copilot/bin/sdlc-template-init"; Label = "Bootstrap script" }
)

foreach ($check in $checks) {
  if (Test-Path $check.Path) {
    Write-Host "[OK] $($check.Label) -> $($check.Path)"
  } else {
    Write-Host "[MISS] $($check.Label) -> $($check.Path)"
  }
}
