# Docker Compose — Assignment 1

| File | Use |
|------|-----|
| `docker-compose.full.yml` | **Primary** — app + monitoring + PostgreSQL + Redis + exporters |
| `docker-compose.yml` | Application only (no monitoring) |
| `docker-compose.incident.yml` | Overlay — breaks `orders` DB config (Assignment 4) |
| `docker-compose.monitoring.yml` | Legacy monitoring-only overlay |

## Deploy

```powershell
docker compose -f docker-compose.full.yml up -d
# or
..\scripts\deploy-compose.ps1
```

## Incident overlay

```powershell
docker compose -f docker-compose.full.yml -f docker-compose.incident.yml up -d orders --force-recreate
```

## Services count

- **6 assignment microservices** (user, catalogue, orders, payment, queue-master, front-end)  
- **+** shipping, carts, edge-router  
- **+** postgres-sre, redis, rabbitmq, MongoDB/MySQL DBs  
- **+** prometheus, grafana, alertmanager, node-exporter, cadvisor, exporters  
