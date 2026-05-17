. "$PSScriptRoot\_lib\SrePorts.ps1"
$compose = Get-SreComposeArgs
Write-Host 'Stopping SRE stack...' -ForegroundColor Yellow
Push-Location $compose.Directory
docker compose @($compose.Args) down -v --remove-orphans
Pop-Location
Write-Host 'Done.' -ForegroundColor Green
