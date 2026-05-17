# Recover Order Service — remove incident overlay
$ErrorActionPreference = "Stop"
$ComposeDir = Join-Path (Split-Path -Parent $PSScriptRoot) "docker-compose"

Write-Host "==> Recovering Order Service (correct DB config)..." -ForegroundColor Green
Push-Location $ComposeDir

# Recreate orders WITHOUT incident overlay
docker compose -f docker-compose.full.yml up -d orders --force-recreate

Pop-Location

Start-Sleep -Seconds 12
Write-Host ""
docker ps --filter "name=orders" --format "table {{.Names}}\t{{.Status}}"
Write-Host ""
Write-Host "Recovery done. Wait 2-5 min for Prometheus alerts to clear." -ForegroundColor Green
Write-Host "Run: .\scripts\verify-health.ps1" -ForegroundColor Cyan
