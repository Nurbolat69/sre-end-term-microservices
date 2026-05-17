# Assignment 2 — SLI/SLO Design

## SLIs (PDF)

| SLI | Recording rule | Alert |
|-----|----------------|-------|
| Availability | `sre:availability:5m` | `SLO_AvailabilityBreach` |
| Latency | `sre:latency_p95:5m` | `SLO_LatencyP95Breach` |
| Error rate | `sre:error_rate:5m` | `SLO_ErrorRateBreach` |
| Request success rate | `sre:success_rate:5m` | `SLO_SuccessRateBreach` |

## SLOs (PDF)

| SLO | Target |
|-----|--------|
| Availability | ≥ 99% |
| Latency (p95) | ≤ 200 ms |
| Error rate | ≤ 1% |

## Файлы

- `docs/SLI-SLO.md` — полное описание  
- `docs/ERROR_BUDGET.md` — error budget  
- `monitoring/recording.rules` — Prometheus recording  
- `monitoring/alert.rules` — alerting  
- `scripts/verify-slo.ps1` — автоматическая проверка  

## Проверка

```powershell
.\scripts\verify-slo.ps1
# Prometheus → Status → Rules → sre_sli_recording
```
