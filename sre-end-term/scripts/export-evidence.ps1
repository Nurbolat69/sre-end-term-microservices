# Export text evidence for PDF report (screenshots still manual)
$EvidenceDir = Join-Path (Split-Path -Parent $PSScriptRoot) "evidence"
New-Item -ItemType Directory -Force -Path $EvidenceDir | Out-Null

Write-Host "Exporting evidence to $EvidenceDir ..." -ForegroundColor Cyan

$composeFile = Join-Path (Split-Path -Parent $PSScriptRoot) "docker-compose\docker-compose.full.yml"
Push-Location (Split-Path $composeFile)
docker compose -f (Split-Path -Leaf $composeFile) ps 2>&1 | Set-Content (Join-Path $EvidenceDir "compose-ps.txt")
Pop-Location

@(
    "http://localhost:9090/api/v1/targets",
    "http://localhost:9090/api/v1/rules",
    "http://localhost:9090/api/v1/alerts"
) | ForEach-Object {
    $name = ($_ -split "/")[-1] + ".json"
    try {
        Invoke-RestMethod $_ -TimeoutSec 10 | ConvertTo-Json -Depth 8 |
            Set-Content (Join-Path $EvidenceDir $name)
    } catch {
        "unavailable" | Set-Content (Join-Path $EvidenceDir $name)
    }
}

& "$PSScriptRoot\verify-slo.ps1" | Set-Content (Join-Path $EvidenceDir "slo-verification.txt")

@"
SRE End Term — Evidence Export
Generated: $(Get-Date -Format o)

Manual screenshots still required — see docs/SCREENSHOTS_GUIDE.md

URLs:
  Shop:         http://localhost
  Prometheus:   http://localhost:9090
  Grafana:      http://localhost:3000
  Alertmanager: http://localhost:9093
  cAdvisor:     http://localhost:8081
"@ | Set-Content (Join-Path $EvidenceDir "README.txt")

Write-Host "Done. Open evidence/ and capture Grafana/Prometheus screenshots." -ForegroundColor Green
