# Assignment 4 — simulate Order Service failure (wrong DB hostname)
$ErrorActionPreference = "Stop"
$ComposeDir = Join-Path (Split-Path -Parent $PSScriptRoot) "docker-compose"

Write-Host "==> Simulating Order Service incident..." -ForegroundColor Yellow
Push-Location $ComposeDir

docker compose -f docker-compose.full.yml -f docker-compose.incident.yml up -d orders --force-recreate

Pop-Location

Start-Sleep -Seconds 8
Write-Host ""
Write-Host "Incident ACTIVE — orders cannot reach MongoDB." -ForegroundColor Red
Write-Host ""
Write-Host "Verify:" -ForegroundColor Cyan
Write-Host "  docker logs sre-end-term-orders-1 --tail 40"
Write-Host "  http://localhost:9090/alerts"
Write-Host "  http://localhost:3000  (dashboard: error rate spike)"
Write-Host ""
Write-Host "Recover: .\scripts\recover-incident.ps1" -ForegroundColor Green
