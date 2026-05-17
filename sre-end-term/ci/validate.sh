#!/usr/bin/env bash
# Local validation - mirrors GitHub Actions CI
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "==> Docker Compose"
docker compose -f docker-compose/docker-compose.full.yml config --quiet
docker compose -f docker-compose/docker-compose.full.yml \
  -f docker-compose/docker-compose.ports-default.yml config --quiet

echo "==> Prometheus rules"
docker run --rm -v "$ROOT/monitoring:/etc/prometheus" prom/prometheus:v2.47.0 \
  promtool check rules /etc/prometheus/recording.rules
docker run --rm -v "$ROOT/monitoring:/etc/prometheus" prom/prometheus:v2.47.0 \
  promtool check rules /etc/prometheus/alert.rules

echo "==> Prometheus config (syntax)"
docker run --rm -v "$ROOT/monitoring:/etc/prometheus" prom/prometheus:v2.47.0 \
  promtool check config /etc/prometheus/prometheus.yml

echo "==> Kustomize"
if command -v kustomize >/dev/null 2>&1; then
  kustomize build kubernetes >/dev/null
else
  docker run --rm -v "$ROOT/kubernetes:/k" -v "$ROOT/monitoring:/mon" \
    line/kustomize:v5.3.0 build /k >/dev/null
fi

echo "==> Terraform"
(cd terraform && terraform init -backend=false >/dev/null && terraform validate)

echo "==> All local CI checks passed"
