. "$PSScriptRoot\_lib\SrePorts.ps1"
$Network = 'sre-end-term-net'
Write-Host 'Load test 60s -> edge-router (watch Grafana Capacity dashboard)' -ForegroundColor Cyan
docker run --rm --network $Network weaveworksdemos/load-test:0.1.1 `
  -h edge-router -d 60 -r 100 -c 4
