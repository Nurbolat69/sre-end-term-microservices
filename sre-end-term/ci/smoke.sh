#!/usr/bin/env bash
# CI smoke tests — runs on GitHub Actions
set -euo pipefail

PROM="${PROM_URL:-http://localhost:9090}"

echo "==> Prometheus health"
curl -sf "${PROM}/-/healthy"

echo "==> Prometheus targets API"
curl -sf "${PROM}/api/v1/targets" | grep -q '"status":"success"'

echo "==> Prometheus rules loaded"
curl -sf "${PROM}/api/v1/rules" | grep -q 'sre_sli_recording'

echo "==> CI smoke passed"
