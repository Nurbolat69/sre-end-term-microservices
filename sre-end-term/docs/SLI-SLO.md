# SLI / SLO Design — Assignment 2

## Service Level Indicators (SLIs)

| SLI | Definition | Prometheus metric |
|-----|------------|-------------------|
| **Availability** | Fraction of time service is scrapeable / healthy | `sre:availability:5m` ← `avg(up)` |
| **Latency** | HTTP request duration p95 | `sre:latency_p95:5m` |
| **Error rate** | Ratio of 5xx to all requests | `sre:error_rate:5m` |
| **Request success rate** | 1 − error rate | `sre:success_rate:5m` |

Recording rules: `monitoring/recording.rules`  
Verify: `.\scripts\verify-slo.ps1`

## Service Level Objectives (SLOs)

| SLO | Target | Alert rule |
|-----|--------|------------|
| Availability | **≥ 99%** | `SLO_AvailabilityBreach` |
| Latency (p95) | **≤ 200 ms** | `SLO_LatencyP95Breach` |
| Error rate | **≤ 1%** | `SLO_ErrorRateBreach` |
| Request success | **≥ 99%** | `SLO_SuccessRateBreach` |

## Error budget

Monthly budget at 99%: **~7.3 hours** downtime.  
Policy: `docs/ERROR_BUDGET.md`

## Per-service targets

| Assignment service | Component | Availability | p95 | Errors |
|--------------------|-----------|--------------|-----|--------|
| Order | orders | 99% | 200ms | 1% |
| Payment | payment | 99.5% | 200ms | 0.5% |
| Product | catalogue | 99% | 150ms | 1% |
| Auth + Profile | user | 99.9% | 200ms | 0.5% |
| Notification | queue-master | 99% | 500ms | 2% |

## Grafana

Dashboard **SRE End Term — SLI Overview** visualizes all four SLIs live.

## Review cadence

1. **Daily:** Grafana SLI dashboard during lab/demo.  
2. **On alert:** Run `docs/incident-response.md`.  
3. **Post-incident:** Update `postmortem.md` and error budget ledger.
