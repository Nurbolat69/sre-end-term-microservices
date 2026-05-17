. "$PSScriptRoot\_lib\SrePorts.ps1"
$ports = Get-SrePorts
$ok = 0; $fail = 0

function Test-Url($label, $url) {
    try {
        $r = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 12
        if ($r.StatusCode -lt 500) {
            Write-Host "[OK]   $label ($($r.StatusCode))" -ForegroundColor Green
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

Write-Host '=== SRE Health Check ===' -ForegroundColor Cyan
Test-Url 'Shop' "http://localhost:$($ports.Shop)/"
Test-Url 'Prometheus' "http://localhost:$($ports.Prom)/-/healthy"
Test-Url 'Grafana' "http://localhost:$($ports.Grafana)/api/health"
Test-Url 'Alertmanager' "http://localhost:$($ports.Alert)/-/ready"

Write-Host ''
docker ps --filter 'name=sre-end-term' --format 'table {{.Names}}\t{{.Status}}' 2>$null | Select-Object -First 18
Write-Host ''
Write-Host "Result: $ok ok, $fail failed" -ForegroundColor $(if ($fail -eq 0) { 'Green' } else { 'Yellow' })
