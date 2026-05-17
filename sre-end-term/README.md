# SRE End Term — Team Project + CI/CD

[![SRE Team CI/CD](https://github.com/Nurbolat69/sre-end-term-microservices/actions/workflows/sre-team-ci-cd.yml/badge.svg)](https://github.com/Nurbolat69/sre-end-term-microservices/actions/workflows/sre-team-ci-cd.yml)

**Sock Shop** with full End Term criteria: 6+ services, Compose/Swarm/K8s, Terraform, Ansible, SLI/SLO, incidents, **GitHub Actions CI/CD**.

| Submit | File |
|--------|------|
| **REPORT (40 pts)** | [`docs/TEAM_REPORT.md`](docs/TEAM_REPORT.md) -> PDF |
| **Presentation** | [`docs/PRESENTATION.md`](docs/PRESENTATION.md) -> PDF |

- Structure: [`STRUCTURE.md`](STRUCTURE.md)  
- Rubric: [`docs/RUBRIC.md`](docs/RUBRIC.md)  
- Team: [`docs/TEAM.md`](docs/TEAM.md)  
- Checklist: [`docs/CHECKLIST.md`](docs/CHECKLIST.md)  

## Quick start

```powershell
cd sre-end-term
.\scripts\deploy-all.ps1
.\scripts\verify-health.ps1
```

| Service | Default URL | Alt ports (if busy) |
|---------|-------------|---------------------|
| Shop | http://localhost | http://localhost:8888 |
| Prometheus | :9090 | :9091 |
| Grafana | :3000 (admin/foobar) | :3001 |

## End Term coverage

| PDF requirement | Location |
|-----------------|----------|
| Assignment 1 Compose | `docker-compose/docker-compose.full.yml` |
| Assignment 2 SLI/SLO | `monitoring/recording.rules`, `docs/SLI-SLO.md` |
| Assignment 3 Monitoring | Grafana + Prometheus |
| Assignment 4 Incident | `docker-compose.incident.yml`, `scripts/demo-incident-full.ps1` |
| Assignment 5 Terraform | `terraform/` |
| Assignment 6 Ansible + scale | `ansible/`, Swarm, K8s HPA |
| Team CI/CD | `.github/workflows/sre-team-ci-cd.yml` |

## CI locally

```bash
cd sre-end-term && bash ci/validate.sh
```

## Repo

https://github.com/Nurbolat69/sre-end-term-microservices
