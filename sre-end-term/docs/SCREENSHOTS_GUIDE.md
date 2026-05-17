# Screenshot Guide — PDF deliverable #8

Сохраните в папку `evidence/` (создаётся скриптом `export-evidence.ps1`).

| # | Что снять | URL / команда |
|---|-----------|---------------|
| 1 | Главная магазина | http://localhost |
| 2 | Docker containers | `docker compose -f docker-compose/docker-compose.full.yml ps` |
| 3 | Prometheus targets UP | http://localhost:9090/targets |
| 4 | Prometheus rules | http://localhost:9090/rules |
| 5 | Grafana SLI dashboard | http://localhost:3000 → SRE folder |
| 6 | Grafana Capacity dashboard | same |
| 7 | Alerts BEFORE incident | после `simulate-incident.ps1` |
| 8 | Alerts AFTER recovery | после `recover-incident.ps1` |
| 9 | `docker logs orders` (errors) | terminal |
| 10 | Swarm services | `docker stack services sre-sock-shop` |
| 11 | K8s pods (optional) | `kubectl get pods -n sock-shop` |
| 12 | Terraform apply output | `terraform apply` |

```powershell
.\scripts\export-evidence.ps1
```

В PDF вставьте 6–10 лучших скриншотов + Git URL.
