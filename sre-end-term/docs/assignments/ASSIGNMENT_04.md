# Assignment 4 — Incident Response

## Сценарий PDF

Order Service fails due to **incorrect database configuration**.

## Автоматизированный drill

```powershell
.\scripts\demo-incident-full.ps1
```

Шаги скрипта: health → simulate → capture alerts → recover → verify.

## Ручной режим

```powershell
.\scripts\simulate-incident.ps1   # docker-compose.incident.yml
.\scripts\recover-incident.ps1
```

## Документация

| Документ | Назначение |
|----------|------------|
| `docs/incident-response.md` | Runbook |
| `docs/incident-report.md` | Formal report |
| `docs/postmortem.md` | Blameless postmortem |

## Root cause (ожидаемый)

`MONGO_HOST=orders-db-broken:27017` → Mongo connection failure → HTTP 5xx.

## Доказательства

Скриншоты: Prometheus Alerts, Grafana error panel, `docker logs orders`, UI после recovery.
