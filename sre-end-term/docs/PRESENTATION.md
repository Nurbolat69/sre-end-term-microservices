# SRE End Term — Team Project Presentation

**Team:** SRE Team Alpha  
**Repository:** https://github.com/Nurbolat69/sre-end-term-microservices  
**Presenter:** Nurbolat69 (Team Lead)

---

## Slide 1 — Title

# Site Reliability Engineering in Microservices

**Team End Term Project with CI/CD**

- Sock Shop — 8+ microservices  
- Docker · Swarm · Kubernetes · Terraform · Ansible  
- Prometheus · Grafana · GitHub Actions  

May 2026

---

## Slide 2 — Team

| Role | Focus |
|------|--------|
| **Team Lead / SRE** | Architecture, CI/CD, report |
| **DevOps** | Terraform, Ansible |
| **Platform** | Compose, Swarm, K8s |
| **Observability** | SLI/SLO, dashboards |
| **Reliability** | Incidents, postmortem |

**Workflow:** feature branch → PR → **CI** → review → merge → **CD**

---

## Slide 3 — Problem & goals

**Problem:** How to run a reliable distributed shop with measurable SLOs and team-safe deployments?

**Goals (End Term + Team):**
1. Deploy 6+ microservices  
2. Multi-orchestration  
3. Monitoring & alerting  
4. Incident response  
5. **Automated CI/CD pipeline**  

---

## Slide 4 — Architecture

```
User → API Gateway (edge-router) → Microservices
              ↓
    MongoDB / MySQL / Redis / RabbitMQ
              ↓
    Prometheus → Grafana → Alerts
              ↓
       GitHub Actions CI/CD
```

**Services:** Auth, Product, Order, Payment, Notification, Profile + Cart/Shipping

---

## Slide 5 — Microservices map

| Assignment | Our service |
|------------|-------------|
| Authentication | `user` |
| Product | `catalogue` |
| Order | `orders` |
| Payment | `payment` |
| Notification | `queue-master` |
| Profile | `user-db` |

**Stack:** `docker-compose.full.yml` — one-command deploy

---

## Slide 6 — SLI / SLO

| SLI | SLO |
|-----|-----|
| Availability | ≥ **99%** |
| Latency p95 | ≤ **200 ms** |
| Error rate | ≤ **1%** |
| Success rate | ≥ **99%** |

**Tooling:** Prometheus recording rules + Grafana **SLI Overview** dashboard

---

## Slide 7 — Monitoring & alerts

- **Prometheus** — metrics, rules, targets  
- **Grafana** — SLI + Capacity dashboards  
- **Alertmanager** — SLO breach routing  

**CI enforces:** `promtool check rules` on every PR

**Demo URL (lab):** `:9090` Prometheus, `:3000` Grafana

---

## Slide 8 — Infrastructure as Code

| Tool | Purpose |
|------|---------|
| **Terraform** | Networks, monitoring infra, AWS VMs (optional) |
| **Ansible** | Roles: docker, sock_shop — automated deploy |

**CI:** `terraform validate` + Ansible syntax check

---

## Slide 9 — Multi-orchestration

| | Compose | Swarm | Kubernetes |
|---|---------|-------|------------|
| Speed | Fast | Medium | Rich |
| Scale | Manual | Replicas | HPA |
| Best for | Dev/CI | Small cluster | Production |

**K8s extras:** HPA orders/payment, PDB, ConfigMaps

---

## Slide 10 — CI/CD pipeline (team highlight)

**File:** `.github/workflows/sre-team-ci-cd.yml`

### CI (every PR)
- Docker Compose validate  
- promtool rules/config  
- Terraform + Ansible  
- Integration smoke (Prometheus live)  

### CD (`main` only)
- Bundle `sre-end-term-bundle.tar.gz`  
- SHA256 checksum artifact  

---

## Slide 11 — CI/CD flow diagram

```
Developer → PR → GitHub Actions
                    |
         +----------+----------+
         |  CI jobs (parallel)  |
         +----------+----------+
                    |
              [All green?]
                    |
              Merge main
                    |
              CD artifact
```

**Benefit:** No broken configs reach production branch

---

## Slide 12 — Incident demo

**Scenario:** Order service — wrong `MONGO_HOST`

1. `simulate-incident.ps1`  
2. Alert fires in Prometheus  
3. Logs + Grafana error spike  
4. `recover-incident.ps1`  
5. Postmortem documented  

**SRE practice:** detect → respond → learn

---

## Slide 13 — Capacity planning

- Load test: `load-test.ps1`  
- **Hot services:** orders, payment  
- **Bottleneck:** orders-db (MongoDB)  
- **Actions:** HPA, Swarm replicas, JVM tuning  

---

## Slide 14 — Results

| Area | Status |
|------|--------|
| 6+ services deployed | Done |
| SLI/SLO + dashboards | Done |
| Terraform + Ansible | Done |
| Incident + postmortem | Done |
| **Team CI/CD** | Done |
| GitHub green pipeline | Done |

---

## Slide 15 — Conclusion & Q&A

- Built a **complete SRE lifecycle** as a team  
- **CI/CD** ensures every merge is validated  
- Repository: **github.com/Nurbolat69/sre-end-term-microservices**  

### Thank you — Questions?

**Contact:** Nurbolat69 @ GitHub

---

## Speaker notes (not for slides)

- Demo live: GitHub Actions tab + Grafana SLI dashboard  
- Mention alternate ports 8888/9091 if port conflict on laptop  
- Total presentation time: ~12–15 minutes  
