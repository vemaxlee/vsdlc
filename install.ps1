$RootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$BackupDir = Join-Path $HOME (".vsdlc-backups/" + (Get-Date -Format 'yyyyMMdd-HHmmss'))
$PromptsDir = Join-Path $HOME '.vscode-server-insiders/data/User/prompts'
$AgentsDir = Join-Path $HOME '.copilot/agents'
$TemplateDir = Join-Path $HOME '.copilot/templates/sdlc-project-template'
$BinDir = Join-Path $HOME '.copilot/bin'
$RootCopilotDir = Join-Path $HOME '.copilot'

New-Item -ItemType Directory -Force -Path $BackupDir,$PromptsDir,$AgentsDir,$TemplateDir,$BinDir,$RootCopilotDir | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $BackupDir 'agents'),(Join-Path $BackupDir 'prompts'),(Join-Path $BackupDir 'template') | Out-Null

if (Test-Path $AgentsDir) { Copy-Item (Join-Path $AgentsDir '*') (Join-Path $BackupDir 'agents') -Recurse -Force -ErrorAction SilentlyContinue }
if (Test-Path $PromptsDir) { Copy-Item (Join-Path $PromptsDir '*') (Join-Path $BackupDir 'prompts') -Recurse -Force -ErrorAction SilentlyContinue }
if (Test-Path $TemplateDir) { Copy-Item (Join-Path $TemplateDir '*') (Join-Path $BackupDir 'template') -Recurse -Force -ErrorAction SilentlyContinue }
if (Test-Path (Join-Path $RootCopilotDir 'copilot-instructions.md')) { Copy-Item (Join-Path $RootCopilotDir 'copilot-instructions.md') (Join-Path $BackupDir 'copilot-instructions.md') -Force }
if (Test-Path (Join-Path $BinDir 'sdlc-template-init')) { Copy-Item (Join-Path $BinDir 'sdlc-template-init') (Join-Path $BackupDir 'sdlc-template-init') -Force }

Copy-Item (Join-Path $RootDir 'assets/agents/*') $AgentsDir -Force
Copy-Item (Join-Path $RootDir 'assets/prompts/*') $PromptsDir -Force
Copy-Item (Join-Path $RootDir 'assets/templates/sdlc-project-template/*') $TemplateDir -Recurse -Force
Copy-Item (Join-Path $RootDir 'assets/root/copilot-instructions.md') (Join-Path $RootCopilotDir 'copilot-instructions.md') -Force
Copy-Item (Join-Path $RootDir 'assets/bin/sdlc-template-init') (Join-Path $BinDir 'sdlc-template-init') -Force

Write-Host "vsdlc installed. Backup: $BackupDir"
powershell -ExecutionPolicy Bypass -File (Join-Path $RootDir 'scripts/health-check.ps1')
