# Error Budget Policy (SRE)

## Monthly error budget (99% availability SLO)

| SLO | Allowed unavailability / month |
|-----|--------------------------------|
| 99.0% availability | **7 h 18 min** downtime |
| 99.9% availability | **43 min** |

Formula: `budget = (1 - SLO) × 30 × 24 × 60` minutes.

## Burn rate alerts (conceptual)

| Window | Burn | Action |
|--------|------|--------|
| 5 min critical | Fast burn | Page on-call, freeze deploys |
| 1 h warning | Moderate | Investigate, prepare rollback |
| 6 h | Slow | Ticket, schedule fix |

Implemented via Prometheus `for: 5m` on `SLO_*` alerts in `monitoring/alert.rules`.

## Policy

1. **Budget > 50% remaining** — normal releases allowed.  
2. **Budget 25–50%** — only reliability fixes and small changes.  
3. **Budget < 25%** — freeze features; focus on stability.  
4. **Budget exhausted** — postmortem required before next feature release.

## Tracking

Query in Prometheus:

```promql
avg_over_time(sre:availability:5m[30d])
```

Grafana panel on **SLI Overview** dashboard tracks live availability.

## Incident impact example (Assignment 4)

15 min orders outage on single service ≈ **0.35%** of monthly budget if shop-wide SLO is shared — document in `postmortem.md`.
