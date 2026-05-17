# Deploy Sock Shop to Kubernetes + SRE overlays
$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$SreRoot = Split-Path -Parent $PSScriptRoot

Write-Host "==> Kubernetes deployment" -ForegroundColor Cyan

kubectl version --client 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Error "kubectl not found. Install kubectl and configure cluster access."
}

Write-Host "==> Core manifests (sock-shop)..." -ForegroundColor Cyan
kubectl apply -f (Join-Path $RepoRoot "deploy\kubernetes\manifests")

Write-Host "==> SRE overlays (namespace, HPA, SLO config)..." -ForegroundColor Cyan
kubectl apply -k (Join-Path $SreRoot "kubernetes")

Write-Host "==> Monitoring namespace..." -ForegroundColor Cyan
$monDir = Join-Path $RepoRoot "deploy\kubernetes\manifests-monitoring"
if (Test-Path $monDir) {
    Get-ChildItem $monDir -Filter "*.yaml" | ForEach-Object {
        kubectl apply -f $_.FullName 2>$null
    }
}

kubectl apply -f (Join-Path $SreRoot "monitoring\prometheus-slo-alerts.yaml") 2>$null

Write-Host ""
kubectl get pods -n sock-shop
kubectl get hpa -n sock-shop 2>$null
Write-Host ""
Write-Host "Done. Front-end NodePort is typically 30001." -ForegroundColor Green
