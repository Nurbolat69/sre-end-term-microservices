# Incident Response — Assignment 4

## Scenario

**Order Service fails** due to incorrect database configuration (`orders` cannot reach `orders-db`).

## Impact

| Symptom | User impact |
|---------|-------------|
| HTTP 5xx on `/orders` | Cannot place orders |
| Checkout flow broken | Partial degradation of shop |
| `OrderServiceHighErrors` alert fires | On-call notified |

## Detection

1. **Prometheus** — alert `OrderServiceHighErrors` or `HighErrorRate` for job `orders`.
2. **Grafana** — spike in error rate panel, drop in success rate.
3. **Logs** — `docker logs orders` shows Mongo connection errors.

## Response runbook

### 1. Acknowledge

```powershell
# Check alert in Prometheus
Start-Process "http://localhost:9090/alerts"
```

### 2. Simulate incident (lab/demo)

```powershell
cd sre-end-term
.\scripts\simulate-incident.ps1
```

This sets invalid `MONGO_HOST` on the `orders` container (wrong hostname).

### 3. Root cause analysis

```powershell
docker logs orders --tail 50
docker inspect orders --format '{{json .Config.Env}}'
```

**Expected root cause:** `MONGO_HOST` or network alias points to non-existent host; MongoDB unreachable.

### 4. Mitigation

```powershell
.\scripts\recover-incident.ps1
```

Or manually:

```powershell
docker compose -f docker-compose/docker-compose.yml up -d orders --force-recreate
```

### 5. Verify recovery

```powershell
curl http://localhost/orders
# Prometheus: error rate back below 1%
```

### 6. Close incident

- Confirm alerts cleared in Prometheus (5–10 min).
- Document timeline in `docs/postmortem.md`.

## Escalation

| Severity | Condition | Action |
|----------|-----------|--------|
| SEV-2 | Order path down < 30 min | Team lead |
| SEV-1 | Full shop down | Page all engineers |

## Evidence for report

Capture screenshots of:

1. Grafana error-rate spike
2. Prometheus firing alerts
3. Failed order in UI
4. Restored metrics after fix
