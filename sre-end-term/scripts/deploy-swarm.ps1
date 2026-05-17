# Deploy Docker Swarm stack
$ErrorActionPreference = "Stop"
$StackDir = Join-Path (Split-Path -Parent $PSScriptRoot) "docker-swarm"
$StackName = "sre-sock-shop"

if (-not (docker info --format '{{.Swarm.LocalNodeState}}' 2>$null) -eq 'active') {
    Write-Host "Initializing Docker Swarm..." -ForegroundColor Cyan
    docker swarm init 2>$null
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Swarm may already be initialized (continuing)." -ForegroundColor Yellow
    }
}

Write-Host "Deploying stack $StackName ..." -ForegroundColor Cyan
docker stack deploy -c (Join-Path $StackDir "docker-stack.yml") $StackName

Start-Sleep -Seconds 5
docker stack services $StackName

Write-Host ""
Write-Host "Swarm stack deployed. Access via published port 80 on any node." -ForegroundColor Green
