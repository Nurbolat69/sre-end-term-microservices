# Postmortem — Order Service Database Misconfiguration

**Date:** 2026-05-17  
**Authors:** SRE End Term Project Team  
**Status:** Resolved  
**Severity:** SEV-2 (partial outage — orders only)

---

## Summary

The Order Service became unavailable after a misconfigured MongoDB hostname prevented `orders` from connecting to `orders-db`. Order creation failed with HTTP 5xx responses until the environment variable was corrected and the service restarted.

## Impact

- **Duration:** ~15 minutes (simulated lab incident)
- **Users affected:** 100% of checkout attempts requiring order persistence
- **SLO impact:** Availability dropped to ~94% for the `orders` job (below 99% SLO)
- **Revenue:** N/A (demo environment)

## Timeline (UTC)

| Time | Event |
|------|-------|
| T+0 | `simulate-incident.ps1` applied bad `MONGO_HOST=orders-db-broken` |
| T+2m | Prometheus `OrderServiceHighErrors` alert fired |
| T+5m | On-call acknowledged; checked `docker logs orders` |
| T+8m | Root cause identified: invalid DB hostname |
| T+10m | `recover-incident.ps1` restored correct config |
| T+12m | Health checks green; error rate < 1% |
| T+15m | Incident closed |

## Root cause

The `orders` service reads MongoDB host from environment configuration. A typo (`orders-db-broken` instead of `orders-db`) caused connection pool failures. No circuit breaker masked the failure at the edge router.

**Five whys:**

1. Orders failed → Mongo connection refused  
2. Connection refused → wrong hostname in env  
3. Wrong hostname → manual change during incident drill  
4. Drill change not reverted → runbook step skipped  
5. No config validation in CI → gap in deployment checks  

## What went well

- Prometheus alerts detected the issue within 2 minutes
- Docker health checks marked service unhealthy
- Recovery script restored service in one command

## What went wrong

- No pre-deploy validation of `MONGO_HOST`
- Staging did not mirror production service discovery names

## Action items

| Action | Owner | Priority | Due |
|--------|-------|----------|-----|
| Add Ansible template check for required env vars | DevOps | P1 | +1 week |
| Add integration test: orders → orders-db ping | Backend | P1 | +2 weeks |
| Dashboard panel: Mongo connection errors | SRE | P2 | +2 weeks |
| Document rollback in incident runbook | SRE | P2 | Done |

## Lessons learned

Infrastructure-as-code and configuration management (Ansible) must be the **only** path for production config changes. Ad-hoc `docker update` is acceptable for drills but must always be followed by automated recovery verification.
