# Submission checklist (Team + CI/CD + End Term)

## Submit ONLY 2 files

- [ ] **REPORT.pdf** from `docs/TEAM_REPORT.md`
- [ ] **PRESENTATION.pdf** from `docs/PRESENTATION.md`

## Before export

- [ ] Team names in `TEAM_REPORT.md` section 2 and `TEAM.md`
- [ ] Screenshot: GitHub Actions **SRE Team CI/CD** green
- [ ] Screenshot: Grafana SLI dashboard
- [ ] Optional: incident alerts before/after

## Technical verification

```powershell
cd sre-end-term
.\scripts\deploy-compose.ps1
.\scripts\verify-health.ps1
.\scripts\verify-slo.ps1
.\scripts\demo-incident-full.ps1
```

```bash
bash ci/validate.sh   # mirrors CI
```

## End Term PDF criteria

- [ ] 6+ microservices + API gateway
- [ ] PostgreSQL + Redis + RabbitMQ
- [ ] Docker Compose + Swarm + Kubernetes
- [ ] Terraform + Ansible
- [ ] SLI/SLO + Prometheus + Grafana + alerts
- [ ] Order incident + postmortem
- [ ] Capacity planning + load test
- [ ] **CI/CD** workflow in `.github/workflows/`

## Rubric

See `docs/RUBRIC.md` (40 points mapping).
