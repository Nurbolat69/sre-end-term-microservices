# Deploy full Sock Shop + monitoring stack (recommended)
param([switch]$SkipPull)
$ErrorActionPreference = "Stop"
$SreRoot = Split-Path -Parent $PSScriptRoot
$ComposeDir = Join-Path $SreRoot "docker-compose"
$ComposeFile = "docker-compose.full.yml"
$PortsFile = "docker-compose.ports-local.yml"
$ComposeArgs = @("-f", $ComposeFile)

$busyPorts = @(80, 3000, 9090, 5432, 6379)
$useAltPorts = $false
foreach ($p in $busyPorts) {
    $c = Get-NetTCPConnection -LocalPort $p -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($c) { $useAltPorts = $true; break }
}
if ($useAltPorts) {
    $ComposeArgs += @("-f", $PortsFile)
    Write-Host "==> Default ports busy - using alternate ports 8888, 3001, 9091" -ForegroundColor Yellow
} else {
    $ComposeArgs += @("-f", "docker-compose.ports-default.yml")
}

Write-Host "==> SRE End Term - deploying full stack..." -ForegroundColor Cyan
Push-Location $ComposeDir

if (-not $SkipPull) {
    Write-Host "==> Pulling images..." -ForegroundColor Cyan
    docker compose @ComposeArgs pull
}

Write-Host "==> Starting services..." -ForegroundColor Cyan
docker compose @ComposeArgs up -d

$shopPort = if ($useAltPorts) { "8888" } else { "80" }
$promPort = if ($useAltPorts) { "9091" } else { "9090" }
$grafPort = if ($useAltPorts) { "3001" } else { "3000" }
$amPort = if ($useAltPorts) { "9094" } else { "9093" }
$cadvPort = if ($useAltPorts) { "8082" } else { "8081" }

Write-Host "==> Waiting for edge-router..." -ForegroundColor Gray
$ready = $false
for ($i = 0; $i -lt 30; $i++) {
    try {
        $r = Invoke-WebRequest -Uri "http://localhost:$shopPort/" -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop
        if ($r.StatusCode -in 200, 301, 302) { $ready = $true; break }
    } catch { Start-Sleep -Seconds 3 }
}
if (-not $ready) {
    Write-Host "Warning: edge-router not ready yet. Check: docker compose ps" -ForegroundColor Yellow
}

Pop-Location

$portsFile = Join-Path $SreRoot ".deploy-ports.env"
@"
SHOP_PORT=$shopPort
PROM_PORT=$promPort
GRAFANA_PORT=$grafPort
ALERT_PORT=$amPort
CADVISOR_PORT=$cadvPort
"@ | Set-Content $portsFile -Encoding ASCII

Write-Host ""
Write-Host "Deployment complete:" -ForegroundColor Green
Write-Host "  Shop:         http://localhost:$shopPort"
Write-Host "  Prometheus:   http://localhost:$promPort"
Write-Host "  Grafana:      http://localhost:$grafPort  (admin foobar)"
Write-Host "  Alertmanager: http://localhost:$amPort"
Write-Host "  cAdvisor:     http://localhost:$cadvPort"
