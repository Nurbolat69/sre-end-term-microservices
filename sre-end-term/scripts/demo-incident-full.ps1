# Assignment 4 — automated incident drill with console evidence
$ErrorActionPreference = "Stop"
$EvidenceDir = Join-Path (Split-Path -Parent $PSScriptRoot) "evidence"
New-Item -ItemType Directory -Force -Path $EvidenceDir | Out-Null

function Log($msg, $color = "Cyan") { Write-Host "[$(Get-Date -Format HH:mm:ss)] $msg" -ForegroundColor $color }

Log "Step 1/6 — Baseline health"
& "$PSScriptRoot\verify-health.ps1" | Tee-Object -FilePath (Join-Path $EvidenceDir "01-baseline-health.txt")

Log "Step 2/6 — Baseline Prometheus alerts"
try {
    $alerts = Invoke-RestMethod "http://localhost:9090/api/v1/alerts" -TimeoutSec 10
    $alerts.data.alerts | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $EvidenceDir "02-baseline-alerts.json")
    Log "Firing alerts: $(@($alerts.data.alerts | Where-Object { $_.state -eq 'firing' }).Count)"
} catch { Log "Prometheus not reachable" "Yellow" }

Log "Step 3/6 — SIMULATE incident (orders DB misconfiguration)" "Yellow"
& "$PSScriptRoot\simulate-incident.ps1"
Start-Sleep -Seconds 20

Log "Step 4/6 — Capture incident logs"
docker logs $(docker ps -q --filter "name=orders" | Select-Object -First 1) --tail 60 2>&1 |
    Set-Content (Join-Path $EvidenceDir "04-orders-incident-logs.txt")

try {
    $alerts = Invoke-RestMethod "http://localhost:9090/api/v1/alerts" -TimeoutSec 10
    $alerts.data.alerts | ConvertTo-Json -Depth 5 | Set-Content (Join-Path $EvidenceDir "04-incident-alerts.json")
    $firing = @($alerts.data.alerts | Where-Object { $_.state -eq 'firing' })
    Log "Firing alerts during incident: $($firing.Count)" "Red"
    $firing | ForEach-Object { Log "  - $($_.labels.alertname)" "Red" }
} catch { }

Log "Step 5/6 — RECOVER"
& "$PSScriptRoot\recover-incident.ps1"
Start-Sleep -Seconds 25

Log "Step 6/6 — Post-recovery verification"
& "$PSScriptRoot\verify-health.ps1" | Tee-Object -FilePath (Join-Path $EvidenceDir "06-recovery-health.txt")
& "$PSScriptRoot\verify-slo.ps1" | Tee-Object -FilePath (Join-Path $EvidenceDir "06-recovery-slo.txt")

Log "Drill complete. Evidence saved to: $EvidenceDir" "Green"
Log "Take screenshots for PDF per docs/SCREENSHOTS_GUIDE.md" "Green"
