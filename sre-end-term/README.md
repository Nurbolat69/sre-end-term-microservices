# SRE End Term Project — Full Implementation

**End-to-End Site Reliability Engineering** on Weaveworks Sock Shop: multi-orchestration, IaC, observability, incident management, capacity planning.

> Полный чеклист сдачи: [`docs/CHECKLIST.md`](docs/CHECKLIST.md)  
> Отчёт для PDF: [`docs/PROJECT_REPORT.md`](docs/PROJECT_REPORT.md)

---

## One-command demo

```powershell
cd sre-end-term
.\scripts\deploy-all.ps1
.\scripts\demo-incident-full.ps1    # Assignment 4 drill + evidence/
.\scripts\export-evidence.ps1       # JSON/logs for report
```

| Service | URL |
|---------|-----|
| Shop + API Gateway | http://localhost |
| Prometheus | http://localhost:9090 |
| Grafana (`admin`/`foobar`) | http://localhost:3000 |
| Alertmanager | http://localhost:9093 |
| cAdvisor | http://localhost:8081 |
| PostgreSQL (assignment) | `localhost:5432` — user `sre` / pass `sre` |
| Redis | `localhost:6379` |

**Grafana dashboards (folder SRE):** SLI Overview · Capacity & Resources

---

## PDF requirements — 100% coverage

| PDF section | Deliverable | Location |
|-------------|-------------|----------|
| §3 Objectives 1–9 | All objectives | This repo |
| Assignment 1 | Docker + Compose | `docker-compose/docker-compose.full.yml` |
| Assignment 2 | SLI/SLO | `docs/SLI-SLO.md`, `monitoring/recording.rules` |
| Assignment 3 | Prometheus + Grafana + Alerts | `monitoring/`, Grafana provisioning |
| Midterm | Working shop | `scripts/smoke-test-ui.ps1` |
| Assignment 4 | Order incident | `docker-compose.incident.yml`, `scripts/demo-incident-full.ps1` |
| Assignment 5 | Terraform VMs + local | `terraform/`, `terraform/aws/` |
| Assignment 6 | Ansible + HPA + capacity | `ansible/`, `kubernetes/01-hpa-*.yaml` |
| §6 Swarm + K8s | Multi-orchestration | `docker-swarm/`, `kubernetes/`, comparison doc |
| §9 Architecture | Diagram | `docs/architecture.md` |
| §16 Deliverables | All 9 items | See checklist |

Per-assignment guides: [`docs/assignments/`](docs/assignments/)

---

## Microservices (≥ 6)

| Assignment | Service | Image |
|------------|---------|-------|
| Authentication | `user` | weaveworksdemos/user |
| User Profile | `user` + `user-db` | MongoDB |
| Product | `catalogue` + `catalogue-db` | MySQL |
| Order | `orders` + `orders-db` | MongoDB |
| Payment | `payment` | — |
| Notification | `queue-master` + `rabbitmq` | — |
| Frontend + Gateway | `front-end` + `edge-router` | Nginx |

Plus: `carts`, `shipping`. Source map: [`docs/SERVICES.md`](docs/SERVICES.md)

---

## Project structure

```
sre-end-term/
├── docker-compose/     # full stack + incident overlay
├── docker-swarm/       # stack deploy
├── kubernetes/         # HPA, PDB, ConfigMaps, kustomize
├── terraform/          # Docker (local) + aws/ (EC2)
├── ansible/            # roles: common, docker, sock_shop
├── monitoring/         # Prometheus rules + Grafana
├── docs/               # SLI, runbooks, assignments 1-6, report
├── scripts/            # 12 automation scripts
├── evidence/           # drill output for PDF
└── Makefile            # shortcuts (WSL/Git Bash)
```

---

## Scripts

| Script | Purpose |
|--------|---------|
| `deploy-all.ps1` | Full bootstrap |
| `deploy-compose.ps1` | Compose full stack |
| `deploy-swarm.ps1` | Swarm stack |
| `deploy-k8s.ps1` | Kubernetes |
| `deploy-terraform.ps1` | Terraform apply |
| `demo-incident-full.ps1` | **Full incident drill** |
| `simulate-incident.ps1` / `recover-incident.ps1` | Manual incident |
| `verify-health.ps1` / `verify-slo.ps1` | Validation |
| `load-test.ps1` | Capacity test |
| `smoke-test-ui.ps1` | Midterm checks |
| `export-evidence.ps1` | Report artifacts |
| `destroy.ps1` | Teardown |

---

## SLI / SLO

| SLI | SLO |
|-----|-----|
| Availability | ≥ 99% |
| Latency p95 | ≤ 200 ms |
| Error rate | ≤ 1% |
| Success rate | ≥ 99% |

---

## Submission (PDF + Git only)

1. `git push` → GitHub/GitLab  
2. Insert URL in `docs/PROJECT_REPORT.md`  
3. Run `demo-incident-full.ps1` + screenshots → [`docs/SCREENSHOTS_GUIDE.md`](docs/SCREENSHOTS_GUIDE.md)  
4. Export PDF → upload  

---

## Teardown

```powershell
.\scripts\destroy.ps1
```
