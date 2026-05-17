$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\_lib\SrePorts.ps1"
$compose = Get-SreComposeArgs

Write-Host '==> Recovering Order Service...' -ForegroundColor Green
Push-Location $compose.Directory
docker compose @($compose.Args) up -d orders --force-recreate
Pop-Location
Start-Sleep -Seconds 12
Write-Host 'Recovery done. Run .\scripts\verify-health.ps1' -ForegroundColor Green
