# Assignment 3 — Monitoring

## Требования PDF

1. Prometheus metrics collection  
2. Grafana dashboards  
3. Alert configuration  

## Реализация

| Компонент | URL / путь |
|-----------|------------|
| Prometheus | http://localhost:9090 |
| Grafana | http://localhost:3000 |
| Alertmanager | http://localhost:9093 |
| Node exporter | :9100 |
| cAdvisor | :8081 (container metrics) |

## Метрики (PDF section 10)

| Метрика | Источник |
|---------|----------|
| CPU | `node_*`, `container_cpu_*` (cAdvisor) |
| Memory | `node_memory_*`, `container_memory_*` |
| Request rate | `sre:request_rate:5m` |
| Error rate | `sre:error_rate:5m` |
| Uptime | `up`, `sre:availability:5m` |

## Dashboards (Grafana → folder SRE)

1. **SRE End Term — SLI Overview** — SLI/SLO панели  
2. **SRE End Term — Capacity & Resources** — CPU/RAM/containers  

Provisioning: `monitoring/grafana/provisioning/`

## Alerts

`monitoring/alert.rules` → Alertmanager `docker-compose/alertmanager.yml`

```powershell
# Проверить правила
curl http://localhost:9090/api/v1/rules
```
