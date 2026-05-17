# End Term — полный чеклист (PDF 100%)

## Assignment 1 — Environment

- [ ] `.\scripts\deploy-compose.ps1` или `deploy-all.ps1`
- [ ] Docker: 6+ microservices + healthchecks + restart policies
- [ ] PostgreSQL `postgres-sre` (порт 5432)
- [ ] Redis + RabbitMQ
- [ ] API Gateway `edge-router` + Frontend `front-end`
- [ ] http://localhost открывается

## Assignment 2 — SLI/SLO

- [ ] `docs/SLI-SLO.md`, `docs/ERROR_BUDGET.md`
- [ ] `monitoring/recording.rules` (4 SLI)
- [ ] `monitoring/alert.rules` (SLO alerts)
- [ ] `.\scripts\verify-slo.ps1` → PASS

## Assignment 3 — Monitoring

- [ ] Prometheus :9090 — targets UP
- [ ] Grafana :3000 — 2 dashboards (SLI + Capacity)
- [ ] Alertmanager :9093
- [ ] CPU, memory, RPS, errors, uptime — на дашбордах
- [ ] cAdvisor :8081 — container metrics

## Midterm

- [ ] `.\scripts\smoke-test-ui.ps1`
- [ ] Ручная проверка: регистрация, корзина, checkout

## Assignment 4 — Incident

- [ ] `.\scripts\demo-incident-full.ps1`
- [ ] `docs/incident-response.md`, `incident-report.md`, `postmortem.md`
- [ ] Скриншоты alerts до/после в `evidence/`

## Assignment 5 — Terraform

- [ ] `terraform/` — local Docker infra
- [ ] `terraform/aws/` — EC2 template + `terraform.tfvars.example`
- [ ] `terraform init && apply` (хотя бы local)

## Assignment 6 — Automation & Capacity

- [ ] `ansible-playbook playbooks/site.yml` (roles)
- [ ] Swarm: `deploy-swarm.ps1`
- [ ] K8s HPA: `kubernetes/01-hpa-orders-payment.yaml`
- [ ] PDB: `kubernetes/03-pdb-orders.yaml`
- [ ] `.\scripts\load-test.ps1` + `docs/capacity-planning.md`

## Multi-orchestration (§6)

- [ ] Compose + Swarm + Kubernetes задокументированы
- [ ] `docs/ORCHESTRATION_COMPARISON.md`

## Deliverables §16

- [ ] Git repository URL в PDF
- [ ] `docs/PROJECT_REPORT.md` → PDF
- [ ] Скриншоты: `docs/SCREENSHOTS_GUIDE.md`
- [ ] Загрузить **только PDF + Git link**

## Быстрые команды

```powershell
.\scripts\deploy-all.ps1
.\scripts\demo-incident-full.ps1
.\scripts\export-evidence.ps1
.\scripts\destroy.ps1
```
