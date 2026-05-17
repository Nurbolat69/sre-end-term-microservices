# SLO check via Prometheus
$ErrorActionPreference = "Continue"
$SreRoot = Split-Path -Parent $PSScriptRoot
$promPort = "9090"
$envFile = Join-Path $SreRoot ".deploy-ports.env"
if (Test-Path $envFile) {
    $line = Get-Content $envFile | Where-Object { $_ -match '^PROM_PORT=' } | Select-Object -First 1
    if ($line -match '=(.+)$') { $promPort = $matches[1].Trim() }
}
$base = "http://localhost:$promPort/api/v1/query"

function Q($expr) {
    try {
        $u = "$base" + "?query=" + [uri]::EscapeDataString($expr)
        $r = Invoke-RestMethod $u -TimeoutSec 8
        if ($r.data.result.Count -gt 0) { return [double]$r.data.result[0].value[1] }
    } catch { }
    return $null
}

Write-Host "=== SLO Verification ===" -ForegroundColor Cyan
$pass = 0; $fail = 0; $na = 0

$v = Q "avg(up)"
if ($null -eq $v) { Write-Host "[N/A] availability - no data" -ForegroundColor Yellow; $na++ }
elseif ($v -ge 0.99) { Write-Host "[PASS] availability = $([math]::Round($v*100,2))%" -ForegroundColor Green; $pass++ }
else { Write-Host "[FAIL] availability = $([math]::Round($v*100,2))%" -ForegroundColor Red; $fail++ }

$v = Q "max(sre:error_rate:5m)"
if ($null -eq $v) { Write-Host "[N/A] error rate - no data yet" -ForegroundColor Yellow; $na++ }
elseif ($v -le 0.01) { Write-Host "[PASS] error rate max = $([math]::Round($v*100,3))%" -ForegroundColor Green; $pass++ }
else { Write-Host "[FAIL] error rate max = $([math]::Round($v*100,3))%" -ForegroundColor Red; $fail++ }

Write-Host ""
Write-Host "Summary: $pass pass, $fail fail, $na no data" -ForegroundColor Cyan
