# Assignment 4 - Order Service DB misconfiguration
$ErrorActionPreference = 'Stop'
. "$PSScriptRoot\_lib\SrePorts.ps1"
$compose = Get-SreComposeArgs

Write-Host '==> Simulating Order Service incident...' -ForegroundColor Yellow
Push-Location $compose.Directory
$allArgs = $compose.Args + @('-f', 'docker-compose.incident.yml', 'up', '-d', 'orders', '--force-recreate')
docker compose @allArgs
Pop-Location

Start-Sleep -Seconds 10
Write-Host 'Incident active. Check Prometheus alerts and: docker logs sre-end-term-orders-1' -ForegroundColor Red
Write-Host 'Recover: .\scripts\recover-incident.ps1' -ForegroundColor Green
