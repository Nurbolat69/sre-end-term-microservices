. "$PSScriptRoot\_lib\SrePorts.ps1"
$ports = Get-SrePorts
$base = "http://localhost:$($ports.Prom)/api/v1/query"

function Q($expr) {
    try {
        $u = "$base" + '?query=' + [uri]::EscapeDataString($expr)
        $r = Invoke-RestMethod $u -TimeoutSec 10
        if ($r.data.result.Count -gt 0) { return [double]$r.data.result[0].value[1] }
    } catch { }
    return $null
}

Write-Host '=== SLO Verification ===' -ForegroundColor Cyan
$pass = 0; $fail = 0; $na = 0

$v = Q 'avg(up)'
if ($null -eq $v) { Write-Host '[N/A] availability' -ForegroundColor Yellow; $na++ }
elseif ($v -ge 0.99) { Write-Host "[PASS] availability $([math]::Round($v*100,2))%" -ForegroundColor Green; $pass++ }
else { Write-Host "[FAIL] availability $([math]::Round($v*100,2))%" -ForegroundColor Red; $fail++ }

$v = Q 'max(sre:error_rate:5m)'
if ($null -eq $v) { Write-Host '[N/A] error rate (wait for traffic)' -ForegroundColor Yellow; $na++ }
elseif ($v -le 0.01) { Write-Host "[PASS] error rate $([math]::Round($v*100,3))%" -ForegroundColor Green; $pass++ }
else { Write-Host "[FAIL] error rate $([math]::Round($v*100,3))%" -ForegroundColor Red; $fail++ }

Write-Host "Summary: $pass pass, $fail fail, $na n/a" -ForegroundColor Cyan
