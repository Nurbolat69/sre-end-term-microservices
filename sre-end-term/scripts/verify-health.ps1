# Health smoke checks
$ErrorActionPreference = "Continue"
$SreRoot = Split-Path -Parent $PSScriptRoot
$shopPort = "80"; $promPort = "9090"; $grafPort = "3000"; $amPort = "9093"
$envFile = Join-Path $SreRoot ".deploy-ports.env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^SHOP_PORT=(.+)$') { $shopPort = $matches[1].Trim() }
        if ($_ -match '^PROM_PORT=(.+)$') { $promPort = $matches[1].Trim() }
        if ($_ -match '^GRAFANA_PORT=(.+)$') { $grafPort = $matches[1].Trim() }
        if ($_ -match '^ALERT_PORT=(.+)$') { $amPort = $matches[1].Trim() }
    }
}
$ok = 0; $fail = 0

function Test-Url($label, $url) {
    try {
        $r = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 10
        if ($r.StatusCode -lt 500) {
            Write-Host "[OK]   $label HTTP $($r.StatusCode)" -ForegroundColor Green
            $script:ok++
        } else {
            Write-Host "[FAIL] $label HTTP $($r.StatusCode)" -ForegroundColor Red
            $script:fail++
        }
    } catch {
        Write-Host "[FAIL] $label - $($_.Exception.Message)" -ForegroundColor Red
        $script:fail++
    }
}

Write-Host "=== SRE Health Check ===" -ForegroundColor Cyan
Test-Url "Shop" "http://localhost:$shopPort/"
Test-Url "Prometheus" "http://localhost:$promPort/-/healthy"
Test-Url "Grafana" "http://localhost:$grafPort/api/health"
Test-Url "Alertmanager" "http://localhost:$amPort/-/healthy"

Write-Host ""
Write-Host "Docker (sre-end-term):" -ForegroundColor Cyan
docker ps --filter "name=sre-end-term" --format "table {{.Names}}\t{{.Status}}" 2>$null | Select-Object -First 15

Write-Host ""
Write-Host "Result: $ok ok, $fail failed" -ForegroundColor $(if ($fail -eq 0) { "Green" } else { "Yellow" })
