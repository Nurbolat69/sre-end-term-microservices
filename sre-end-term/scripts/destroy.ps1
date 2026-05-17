# Tear down SRE lab stack
$ErrorActionPreference = "Continue"
$SreRoot = Split-Path -Parent $PSScriptRoot
$ComposeDir = Join-Path $SreRoot "docker-compose"

Write-Host "Stopping Compose full stack..." -ForegroundColor Yellow
Push-Location $ComposeDir
docker compose -f docker-compose.full.yml down -v --remove-orphans 2>$null
docker compose -f docker-compose.incident.yml down 2>$null
Remove-Item -Force "docker-compose.monitoring.runtime.yml" -ErrorAction SilentlyContinue
Pop-Location

docker stack rm sre-sock-shop 2>$null

Write-Host "Done. Volumes removed (postgres-sre-data included)." -ForegroundColor Green
