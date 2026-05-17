# TEAM REPORT — SRE End Term Project (40 Points)

**Course:** Site Reliability Engineering — End Term  
**Project type:** Team project with CI/CD  
**Team:** SRE Team Alpha (see Section 2)  
**Git repository:** https://github.com/Nurbolat69/sre-end-term-microservices  
**Date:** May 2026  

---

## Executive summary

Our team designed, implemented, and automated a **production-style SRE platform** around the Sock Shop microservices demo. The system satisfies all End Term requirements: six or more services, Docker Compose and Swarm, Kubernetes, Terraform, Ansible, SLI/SLO monitoring, incident response, capacity planning, and a **GitHub Actions CI/CD pipeline** for continuous integration and delivery.

**Key result:** Every pull request is validated automatically; merges to `main` produce a versioned deployment bundle for reproducible releases.

---

## 1. Title & scope (2 points)

**Title:** End-to-End SRE Practices in a Multi-Orchestrated Microservices Platform with Team CI/CD

**Scope:** Design, deploy, observe, automate, and continuously validate a distributed e-commerce microservices system using industry-standard SRE tooling.

---

## 2. Team organization (4 points)

### 2.1 Members and roles

| # | GitHub / Name | Role | Contribution |
|---|---------------|------|--------------|
| 1 | Nurbolat69 | Team Lead, CI/CD, Report | Pipeline, Git, architecture, integration |
| 2 | _[Name]_ | DevOps Engineer | Terraform, Ansible |
| 3 | _[Name]_ | Platform Engineer | Compose, Swarm, Kubernetes |
| 4 | _[Name]_ | Observability Engineer | Prometheus, Grafana, SLI/SLO |
| 5 | _[Name]_ | Reliability Engineer | Incident simulation, postmortem |

Full RACI and workflow: `docs/TEAM.md`.

### 2.2 Collaboration model

- **Git flow:** `feature/*` → Pull Request → CI must pass → peer review → `main`
- **Ownership:** CODEOWNERS on `sre-end-term/` and `.github/workflows/`
- **Artifacts:** Shared runbooks, dashboards, and automation scripts in monorepo

---

## 3. System architecture (8 points)

### 3.1 Microservices (≥ 6)

| Business capability | Service | Technology |
|-------------------|---------|------------|
| Authentication | `user` | Go |
| User profile | `user` + `user-db` | MongoDB |
| Product catalog | `catalogue` + `catalogue-db` | MySQL |
| Orders | `orders` + `orders-db` | Java / MongoDB |
| Payment | `payment` | Go |
| Notifications | `queue-master` + `rabbitmq` | Java / AMQP |
| Frontend + API gateway | `front-end`, `edge-router` | Node / Traefik |

Additional: `carts`, `shipping`.

### 3.2 Supporting infrastructure

- **PostgreSQL** (`postgres-sre`) — assignment reference database  
- **Redis** — cache / optional broker  
- **Monitoring:** Prometheus, Grafana, Alertmanager, exporters, cAdvisor  

### 3.3 Architecture diagram

```
                    [ Users ]
                        |
                 edge-router (API GW)
                        |
    +---------+---------+---------+---------+
    |         |         |         |         |
 catalogue  orders   payment    user    queue-master
    |         |                   |         |
  MySQL     MongoDB              MongoDB   RabbitMQ
                        |
              Prometheus -> Grafana
                        |
         GitHub Actions (CI/CD)
```

Detailed diagram: `docs/architecture.md`.

### 3.4 Multi-orchestration

| Platform | Use case | Config path |
|----------|----------|-------------|
| Docker Compose | Dev, demos, CI smoke | `docker-compose/docker-compose.full.yml` |
| Docker Swarm | Replication, rolling updates | `docker-swarm/docker-stack.yml` |
| Kubernetes | HPA, PDB, production patterns | `kubernetes/`, `deploy/kubernetes/` |

Comparison: `docs/ORCHESTRATION_COMPARISON.md`.

---

## 4. SLI, SLO, and monitoring (8 points)

### 4.1 Service Level Indicators

| SLI | Prometheus expression |
|-----|---------------------|
| Availability | `sre:availability:5m` |
| Latency (p95) | `sre:latency_p95:5m` |
| Error rate | `sre:error_rate:5m` |
| Success rate | `sre:success_rate:5m` |

### 4.2 Service Level Objectives

| SLO | Target |
|-----|--------|
| Availability | ≥ 99% |
| Latency p95 | ≤ 200 ms |
| Error rate | ≤ 1% |
| Success rate | ≥ 99% |

Documentation: `docs/SLI-SLO.md`, `docs/ERROR_BUDGET.md`.  
Recording rules: `monitoring/recording.rules`. Alerts: `monitoring/alert.rules`.

### 4.3 Dashboards

- **SRE End Term — SLI Overview**  
- **SRE End Term — Capacity & Resources**  

Grafana auto-provisioned from `monitoring/grafana/`.

### 4.4 CI validation of observability

Pipeline runs `promtool check rules` and `promtool check config` on every PR — observability config cannot merge if broken.

---

## 5. Infrastructure as Code & automation (6 points)

### 5.1 Terraform

- **Local:** Docker network, Prometheus, Grafana (`terraform/`)  
- **Cloud (optional):** AWS EC2 for Swarm/K8s nodes (`terraform/aws/`)  

Benefits: declarative, versioned, reproducible (`terraform plan` / `apply`).

### 5.2 Ansible

- Roles: `common`, `docker`, `sock_shop`  
- Master playbook: `ansible/playbooks/site.yml`  
- Automates full Compose deployment on lab hosts  

### 5.3 Health checks & restart policies

All critical Compose services use `restart: unless-stopped` and HTTP health checks. Kubernetes uses HPA and PDB for `orders`.

---

## 6. Incident management (5 points)

### 6.1 Scenario

Order Service failure due to **incorrect MongoDB hostname** (`MONGO_HOST=orders-db-broken`).

### 6.2 Response

1. Detection — Prometheus alert `OrderServiceHighErrors`  
2. Triage — `docker logs orders`  
3. Mitigation — `scripts/recover-incident.ps1`  
4. Verification — SLO scripts, Grafana normalization  

### 6.3 Documentation

- Runbook: `docs/incident-response.md`  
- Formal report: `docs/incident-report.md`  
- Postmortem: `docs/postmortem.md`  
- Automated drill: `scripts/demo-incident-full.ps1`  

---

## 7. CI/CD pipeline — team delivery (8 points)

### 7.1 Objectives

| Objective | Implementation |
|-----------|----------------|
| Fast feedback on PRs | Parallel CI jobs |
| Prevent broken configs | Compose + promtool + Terraform + Ansible checks |
| Safe delivery to main | CD only after CI gate on `main` |
| Auditable releases | Artifact bundle per commit |

### 7.2 Pipeline architecture

```
  [git push / PR]
        |
        v
 +------+------+------+------+
 | validate | TF | Ansible |
 +------+------+------+------+
        |
        v
  [integration smoke]
        |
        v
   [CI gate PASS]
        |
   (main only)
        v
  [CD: bundle artifact]
```

**Workflow file:** `.github/workflows/sre-team-ci-cd.yml`

### 7.3 CI stages (Continuous Integration)

| Job | Validates |
|-----|-----------|
| `validate-config` | Docker Compose, promtool rules/config, Kustomize |
| `terraform-validate` | `terraform fmt` + `validate` |
| `ansible-validate` | Playbook syntax |
| `integration-smoke` | Live Prometheus + Alertmanager + `ci/smoke.sh` |
| `sre-gate` | All jobs green |

### 7.4 CD stages (Continuous Delivery)

| Job | Action |
|-----|--------|
| `cd-package` | Creates `sre-end-term-bundle.tar.gz` + SHA256 |
| `cd-summary` | GitHub Actions summary for operators |

CD runs **only** on push to `main` after CI success.

### 7.5 Team benefits

- **No manual “works on my machine”** — CI is the single source of truth  
- **Review discipline** — PRs show green checks before merge  
- **Release traceability** — artifact tied to `github.sha`  

### 7.6 Evidence

- GitHub → Actions tab → workflow **SRE Team CI/CD**  
- Screenshot: green pipeline on `main` (attach to presentation)  

---

## 8. Capacity planning (3 points)

Load testing: `scripts/load-test.ps1`.  
Findings: Order/Payment CPU-heavy; `orders-db` bottleneck.  
Strategies: HPA, Swarm replicas, JVM tuning — `docs/capacity-planning.md`.

---

## 9. Assignments mapping (End Term PDF)

| Assignment | Team deliverable | CI/CD link |
|------------|------------------|------------|
| 1 Environment | `docker-compose.full.yml` | Compose validated in CI |
| 2 SLI/SLO | recording + alert rules | promtool in CI |
| 3 Monitoring | Grafana + Prometheus | Smoke test in CI |
| 4 Incident | scripts + postmortem | N/A |
| 5 Terraform | `terraform/` | `terraform validate` job |
| 6 Automation | Ansible + HPA | Ansible syntax job |
| **Team CI/CD** | `.github/workflows/sre-team-ci-cd.yml` | Full pipeline |

---

## 10. Results & conclusion (4 points)

### 10.1 Results

- Functional multi-service shop with observability stack  
- Documented SLI/SLO with automated alerts  
- IaC and configuration management in place  
- Incident lifecycle demonstrated with evidence  
- **CI/CD enforces quality on every change**  

### 10.2 Conclusion

The project demonstrates that SRE practices scale to **team workflows** when automation (CI/CD) is embedded from day one. Combining multi-orchestration, monitoring, IaC, and GitHub Actions creates a credible mini-production environment suitable for academic and portfolio demonstration.

### 10.3 Future work

- Deploy CD bundle to cloud VM via Ansible  
- Add canary analysis and SLO-based deployment gates  
- Integrate OpenTelemetry tracing  

---

## 11. References & repository index

| Resource | URL / path |
|----------|------------|
| **Git repository** | https://github.com/Nurbolat69/sre-end-term-microservices |
| CI/CD workflow | `.github/workflows/sre-team-ci-cd.yml` |
| Team docs | `sre-end-term/docs/TEAM.md` |
| Sock Shop upstream | https://github.com/microservices-demo/microservices-demo |

---

## Appendix A — How to reproduce

```powershell
git clone https://github.com/Nurbolat69/sre-end-term-microservices.git
cd sre-end-term-microservices/sre-end-term
.\scripts\deploy-compose.ps1
.\scripts\verify-health.ps1
```

## Appendix B — Submission

**Submit ONLY:**
1. **REPORT PDF** — export this file (`TEAM_REPORT.md`)  
2. **PRESENTATION PDF** — export `PRESENTATION.md`  

Do **not** submit repository link unless instructor requests separately (link is inside REPORT).

---

*End of Team Report*
