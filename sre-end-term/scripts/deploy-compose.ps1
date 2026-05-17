# Deploy full Sock Shop + monitoring stack
param([switch]$SkipPull)
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\_lib\SrePorts.ps1"

$compose = Get-SreComposeArgs
if ($compose.UseAlt) {
    Write-Host '==> Ports busy - using 8888 / 9091 / 3001' -ForegroundColor Yellow
}

Write-Host '==> SRE End Term - deploying full stack...' -ForegroundColor Cyan
Push-Location $compose.Directory

if (-not $SkipPull) {
    Write-Host '==> Pulling images...' -ForegroundColor Cyan
    docker compose @($compose.Args) pull
}

Write-Host '==> Starting services...' -ForegroundColor Cyan
docker compose @($compose.Args) up -d

Save-SrePorts $compose.UseAlt
$ports = Get-SrePorts
Pop-Location

Write-Host '==> Waiting for edge-router...' -ForegroundColor Gray
$ready = $false
for ($i = 0; $i -lt 36; $i++) {
    try {
        $r = Invoke-WebRequest -Uri "http://localhost:$($ports.Shop)/" -UseBasicParsing -TimeoutSec 8
        if ($r.StatusCode -lt 500) { $ready = $true; break }
    } catch { Start-Sleep -Seconds 5 }
}
if (-not $ready) {
    Write-Host 'Warning: shop not ready - check: docker compose ps' -ForegroundColor Yellow
}

Write-Host ''
Write-Host 'Deployment complete:' -ForegroundColor Green
Write-Host "  Shop:         http://localhost:$($ports.Shop)"
Write-Host "  Prometheus:   http://localhost:$($ports.Prom)"
Write-Host "  Grafana:      http://localhost:$($ports.Grafana)  (admin / foobar)"
Write-Host "  Alertmanager: http://localhost:$($ports.Alert)"
