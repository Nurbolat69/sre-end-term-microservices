# Capacity planning load test (Assignment 6)
$ErrorActionPreference = "Stop"
$SreRoot = Split-Path -Parent $PSScriptRoot
$Network = "sre-end-term-net"

Write-Host "==> Load test against edge-router (60s, 100 RPS)..." -ForegroundColor Cyan
Write-Host "    Watch Grafana dashboard during test." -ForegroundColor Gray

docker run --rm --network $Network weaveworksdemos/load-test:0.1.1 `
    -h edge-router -d 60 -r 100 -c 4

Write-Host ""
Write-Host "Load test finished. Check:" -ForegroundColor Green
Write-Host "  http://localhost:3000  — request rate, latency p95, error rate"
Write-Host "  http://localhost:9090  — sre:latency_p95:5m, sre:error_rate:5m"
Write-Host "See docs/capacity-planning.md for analysis template." -ForegroundColor Cyan
