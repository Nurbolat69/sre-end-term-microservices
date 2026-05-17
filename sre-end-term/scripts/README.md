# Scripts — 12 automation tools

Run from **`sre-end-term/`** directory.

## Deploy

| Script | Description |
|--------|-------------|
| `deploy-all.ps1` | Everything: compose + health + SLO checks |
| `deploy-compose.ps1` | Full Docker Compose stack |
| `deploy-swarm.ps1` | Docker Swarm `sre-sock-shop` |
| `deploy-k8s.ps1` | Kubernetes manifests + SRE overlay |
| `deploy-terraform.ps1` | `terraform apply` (monitoring infra) |

## Verify

| Script | Description |
|--------|-------------|
| `verify-health.ps1` | HTTP + Prometheus targets |
| `verify-slo.ps1` | SLI/SLO pass/fail vs Prometheus |
| `smoke-test-ui.ps1` | Midterm HTTP smoke tests |

## Incident (Assignment 4)

| Script | Description |
|--------|-------------|
| `demo-incident-full.ps1` | **Full automated drill** + `evidence/` export |
| `simulate-incident.ps1` | Break orders DB config |
| `recover-incident.ps1` | Restore orders |

## Other

| Script | Description |
|--------|-------------|
| `load-test.ps1` | 60s load → watch Grafana Capacity |
| `export-evidence.ps1` | JSON/logs for PDF appendix |
| `destroy.ps1` | `docker compose down -v` |

## Examples

```powershell
.\scripts\deploy-all.ps1
.\scripts\demo-incident-full.ps1
.\scripts\verify-slo.ps1
.\scripts\destroy.ps1
```
