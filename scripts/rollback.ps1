param(
  [string]$BackupDir
)

$backupRoot = Join-Path $HOME ".vsdlc-backups"
if (-not $BackupDir) {
  $latest = Get-ChildItem $backupRoot -Directory -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if (-not $latest) { throw "No backup directory found." }
  $BackupDir = $latest.FullName
}

function Restore-Dir($src, $dest) {
  if (Test-Path $src) {
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item (Join-Path $src '*') $dest -Recurse -Force
  }
}

function Restore-File($src, $dest) {
  if (Test-Path $src) {
    New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null
    Copy-Item $src $dest -Force
  }
}

Restore-Dir (Join-Path $BackupDir 'agents') (Join-Path $HOME '.copilot/agents')
Restore-Dir (Join-Path $BackupDir 'prompts') (Join-Path $HOME '.vscode-server-insiders/data/User/prompts')
Restore-Dir (Join-Path $BackupDir 'template') (Join-Path $HOME '.copilot/templates/sdlc-project-template')
Restore-File (Join-Path $BackupDir 'copilot-instructions.md') (Join-Path $HOME '.copilot/copilot-instructions.md')
Restore-File (Join-Path $BackupDir 'sdlc-template-init') (Join-Path $HOME '.copilot/bin/sdlc-template-init')

Write-Host "Restored from backup: $BackupDir"
