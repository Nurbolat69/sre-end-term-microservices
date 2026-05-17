# End Term Project Report

## End-to-End Implementation of Site Reliability Engineering Practices in a Multi-Orchestrated Microservices Infrastructure

**Student:** _[Your Name]_  
**Date:** May 2026  
**Git repository:** _[INSERT YOUR GITHUB/GITLAB URL HERE]_

---

## 1. Title

End-to-End Implementation of Site Reliability Engineering Practices in a Distributed Microservices System Using Docker Swarm, Kubernetes, Terraform, and Ansible.

## 2. Abstract

This project implements Site Reliability Engineering (SRE) principles on the **Sock Shop** microservices demo — a distributed e-commerce application with six or more independent services. The system uses **Docker Compose** and **Docker Swarm** for simple clustering, and **Kubernetes** for advanced orchestration with self-healing and scaling.

**Terraform** provisions reproducible infrastructure (local Docker network and monitoring stack; optional AWS VMs). **Ansible** automates dependency installation, deployment, and monitoring setup. **Prometheus** and **Grafana** provide observability with SLI/SLO-aligned alerts.

A controlled **Order Service** incident (database misconfiguration) demonstrates detection, root cause analysis, recovery, and postmortem. Automation, health checks, and capacity planning strategies improve reliability and scalability.

## 3. Objectives

| # | Objective | Status |
|---|-----------|--------|
| 1 | 6+ microservices architecture | ✅ 8 services (user, catalogue, orders, payment, shipping, carts, queue-master, front-end) |
| 2 | Docker Swarm + Kubernetes | ✅ `docker-swarm/`, `deploy/kubernetes/` |
| 3 | Terraform provisioning | ✅ `sre-end-term/terraform/` |
| 4 | Ansible automation | ✅ `sre-end-term/ansible/` |
| 5 | SLIs and SLOs | ✅ `docs/SLI-SLO.md` |
| 6 | Monitoring & alerting | ✅ Prometheus + Grafana |
| 7 | Incident simulation | ✅ `scripts/simulate-incident.ps1` |
| 8 | Postmortem | ✅ `docs/postmortem.md` |
| 9 | Automation & capacity planning | ✅ `docs/capacity-planning.md` |

## 4. System Overview

### Supporting components (PDF §4)

| Component | Implementation |
|-----------|----------------|
| Frontend (Nginx) | `front-end` |
| PostgreSQL | `postgres-sre` + `postgres-exporter` |
| Redis | `redis` + `redis-exporter` |
| RabbitMQ | `rabbitmq` |
| Monitoring | Prometheus, Grafana, Alertmanager, node-exporter, cAdvisor |

### Microservices mapping

| Assignment name | Implementation |
|-----------------|----------------|
| Authentication | `user` |
| User Profile | `user` + `user-db` |
| Product | `catalogue` + `catalogue-db` |
| Order | `orders` + `orders-db` |
| Payment | `payment` |
| Notification | `queue-master` + `rabbitmq` |

### Supporting components

- **Frontend:** Nginx (`front-end`) + API gateway (`edge-router`)
- **Databases:** MongoDB (orders, carts, user), MySQL (catalogue)
- **Message broker:** RabbitMQ
- **Monitoring:** Prometheus → Grafana

## 5. Assignments integration

| Assignment | Deliverable |
|------------|-------------|
| 1 — Environment | Docker Compose in `sre-end-term/docker-compose/` |
| 2 — SLI/SLO | `docs/SLI-SLO.md` |
| 3 — Monitoring | `monitoring/`, Grafana :3000, Prometheus :9090 |
| Midterm | Functional Sock Shop deployment |
| 4 — Incident | `docs/incident-response.md`, simulation scripts |
| 5 — IaC | `terraform/` (+ optional `terraform/aws/`) |
| 6 — Automation | Ansible playbooks, health checks, capacity doc |

## 6. Multi-orchestration

### Docker Swarm

```bash
docker swarm init
docker stack deploy -c docker-swarm/docker-stack.yml sre-sock-shop
```

Used for: simple clustering, service replication, fast deployment.

### Kubernetes

```bash
kubectl apply -f kubernetes/00-namespace.yaml
kubectl apply -f deploy/kubernetes/manifests/
kubectl apply -f deploy/kubernetes/manifests-monitoring/
```

Used for: declarative deployments, auto-scaling (HPA manifests), self-healing.

### Justification

Dual orchestration demonstrates trade-offs: Swarm for rapid stack deploys; Kubernetes for production-grade scheduling and policy.

## 7. Terraform

Declarative provisioning of Docker network, Prometheus, and Grafana (`terraform/main.tf`). Optional AWS EC2 template in `terraform/aws/` for VM-based labs.

## 8. Ansible

Playbooks install Docker, deploy Compose/Swarm/Kubernetes stacks, and configure monitoring (`ansible/playbooks/site.yml`).

## 9. Architecture diagram

```
User → edge-router → front-end
              ↓
    catalogue | orders | payment | user | shipping | carts
              ↓
         orders-db / catalogue-db / user-db / rabbitmq
              ↓
    Prometheus → Grafana
Terraform → infrastructure
Ansible → configuration & deploy
```

## 10. Monitoring

**Metrics:** CPU, memory (node-exporter), request rate, error rate, uptime (`up`).

**Alerts:** HighErrorRate, HighLatencyP95, ServiceDown, OrderServiceHighErrors.

## 11. Incident simulation

**Scenario:** Order service cannot reach MongoDB (`MONGO_HOST` misconfiguration).  
**Response:** Prometheus alert → log analysis → `recover-incident.ps1` → SLO normalized.  
**Documentation:** `docs/postmortem.md`.

## 12. Automation

- Docker Compose `restart` policies and health checks
- Ansible idempotent deployment
- Swarm `restart_policy` and rolling updates
- Prometheus alert rules

## 13. Capacity planning

Order and Payment services are the primary CPU consumers; **orders-db** is the bottleneck. Strategies: horizontal replicas (Swarm/K8s), vertical JVM limits, Mongo tuning. See `docs/capacity-planning.md`.

## 14. Results

The project demonstrates multi-orchestrated deployment, infrastructure automation, SLO-based monitoring, structured incident handling, and scalable architecture design.

## 15. Conclusion

Integrating Swarm, Kubernetes, Terraform, Ansible, and observability tooling provides a complete SRE lifecycle suitable for teaching reliability engineering in distributed systems.

## 16. Deliverables index

All artifacts live under **`sre-end-term/`** in the Git repository linked above.

| Deliverable | Path |
|-------------|------|
| Source code | Repository root |
| Docker Compose (full stack) | `docker-compose/docker-compose.full.yml` |
| Incident overlay | `docker-compose/docker-compose.incident.yml` |
| Docker Swarm | `docker-swarm/docker-stack.yml` |
| Kubernetes + HPA | `kubernetes/` + `deploy/kubernetes/` |
| Terraform | `terraform/`, `terraform/aws/` |
| Ansible | `ansible/playbooks/` |
| Monitoring + Grafana dashboard | `monitoring/`, `monitoring/grafana/` |
| SLI recording rules | `monitoring/recording.rules` |
| Incident report | `docs/incident-report.md` |
| Postmortem | `docs/postmortem.md` |
| Architecture & checklist | `docs/architecture.md`, `docs/CHECKLIST.md` |
| Automation scripts | `scripts/*.ps1` |

---

**Submission note:** Export this document to PDF and replace the Git URL placeholder before upload.
