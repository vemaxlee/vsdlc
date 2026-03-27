$RootDir = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $RootDir

$insideRepo = $false
try {
  git rev-parse --is-inside-work-tree *> $null
  if ($LASTEXITCODE -eq 0) { $insideRepo = $true }
} catch { $insideRepo = $false }

if ($insideRepo) {
  git remote get-url origin *> $null
  if ($LASTEXITCODE -eq 0) {
    $branch = (git rev-parse --abbrev-ref HEAD).Trim()
    Write-Host "[vsdlc] Fetching latest package..."
    git pull --ff-only origin $branch
  } else {
    Write-Host "[vsdlc] No remote configured, skip git pull"
  }
} else {
  Write-Host "[vsdlc] Not a git repository, skip git pull"
}

Write-Host "[vsdlc] Reinstalling package..."
powershell -ExecutionPolicy Bypass -File "$RootDir/install.ps1"

Write-Host "[vsdlc] Update complete"
