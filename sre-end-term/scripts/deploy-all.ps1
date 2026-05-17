# Full SRE lab bootstrap — all assignments in one run
param(
    [switch]$SkipPull,
    [switch]$WithTerraform,
    [switch]$WithSwarm,
    [switch]$WithK8s
)
$ErrorActionPreference = "Stop"
$SreRoot = Split-Path -Parent $PSScriptRoot

Write-Host @"

  ╔══════════════════════════════════════╗
  ║   SRE End Term — Full Deployment     ║
  ╚══════════════════════════════════════╝

"@ -ForegroundColor Cyan

if ($WithTerraform) {
    & "$PSScriptRoot\deploy-terraform.ps1"
}

& "$PSScriptRoot\deploy-compose.ps1" @($(if ($SkipPull) { "-SkipPull" }))

Start-Sleep -Seconds 5
& "$PSScriptRoot\verify-health.ps1"
& "$PSScriptRoot\verify-slo.ps1"

if ($WithSwarm) {
    & "$PSScriptRoot\deploy-swarm.ps1"
}

if ($WithK8s) {
    & "$PSScriptRoot\deploy-k8s.ps1"
}

Write-Host ""
Write-Host "Full deployment finished. Next steps:" -ForegroundColor Green
Write-Host "  Demo incident:  .\scripts\demo-incident-full.ps1"
Write-Host "  Load test:      .\scripts\load-test.ps1"
Write-Host "  Evidence:       .\scripts\export-evidence.ps1"
Write-Host "  Checklist:      docs\CHECKLIST.md"
