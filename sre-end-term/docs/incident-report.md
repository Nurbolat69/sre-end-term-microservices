# Incident Report — Order Service Outage

**Incident ID:** INC-2026-0517-001  
**Date:** 2026-05-17  
**Reporter:** SRE Team  
**Status:** Resolved  

---

## 1. Summary

Order creation failed across the shop due to misconfigured MongoDB hostname on the **Order Service** (`orders`). The issue was introduced during a controlled failure drill and resolved by restoring correct environment configuration.

## 2. Impact

| Area | Detail |
|------|--------|
| **Affected service** | Order Service (`orders`) |
| **User impact** | Cannot complete checkout / place orders |
| **Scope** | Partial outage — catalogue and browse still worked |
| **SLO breach** | Availability & error-rate SLOs for `orders` job |
| **Duration** | ~15 minutes (lab simulation) |

## 3. Detection

- **T+2 min:** Prometheus alert `OrderServiceHighErrors` fired
- **T+3 min:** Grafana error-rate panel spiked on dashboard *SRE End Term — SLI Overview*
- **T+5 min:** Engineer ran `docker logs orders` — Mongo connection errors to `orders-db-broken`

## 4. Timeline

See full timeline in `postmortem.md`.

## 5. Root cause

Invalid environment variable `MONGO_HOST=orders-db-broken:27017` — typo / wrong hostname. The service could not establish a connection pool to MongoDB.

## 6. Resolution

```powershell
cd sre-end-term
.\scripts\recover-incident.ps1
```

Equivalent:

```powershell
docker compose -f docker-compose/docker-compose.full.yml up -d orders --force-recreate
```

## 7. Verification

- [ ] `docker logs orders` — no Mongo connection errors
- [ ] Prometheus `up{job="orders"}` == 1
- [ ] `sre:error_rate:5m` < 0.01
- [ ] Test order via http://localhost

## 8. Follow-up

| Action | Owner | Due |
|--------|-------|-----|
| Postmortem review | SRE | Complete |
| Add env validation to Ansible | DevOps | +1 week |
| CI integration test orders→db | Backend | +2 weeks |

## 9. Evidence (attach to PDF)

- Screenshot: Prometheus Alerts (firing)
- Screenshot: Grafana error rate
- Screenshot: Recovery — alerts resolved
- Screenshot: Successful order in UI
