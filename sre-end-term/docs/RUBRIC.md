# End Term Rubric Mapping (40 + Team + CI/CD)

Use with **TEAM_REPORT.md** for PDF export.

| Criterion | Points | Evidence in repo | Report section |
|-----------|--------|------------------|----------------|
| Title, abstract, scope | 2 | README, TEAM_REPORT §1 | §1 |
| Team roles & workflow | 4 | `docs/TEAM.md`, CODEOWNERS, PR template | §2 |
| 6+ microservices + gateway | 8 | `docker-compose.full.yml`, SERVICES.md | §3 |
| SLI/SLO design | 4 | `SLI-SLO.md`, `recording.rules` | §4.1-4.2 |
| Monitoring & dashboards | 4 | `monitoring/`, Grafana JSON | §4.3 |
| Terraform IaC | 3 | `terraform/`, CI job | §5.1 |
| Ansible automation | 3 | `ansible/roles/`, CI job | §5.2 |
| Health / restart policies | 2 | compose healthchecks, K8s PDB/HPA | §5.3 |
| Incident simulation | 3 | `simulate-incident.ps1`, runbooks | §6 |
| Postmortem | 2 | `postmortem.md` | §6.3 |
| **CI/CD pipeline** | **8** | `.github/workflows/sre-team-ci-cd.yml` | §7 |
| Capacity planning | 2 | `capacity-planning.md`, load-test | §8 |
| Conclusion & reproducibility | 3 | scripts, SUBMISSION.md | §10 |

**Presentation:** `PRESENTATION.md` (15 slides) — mirrors report for oral defense.

**Submit:** REPORT.pdf + PRESENTATION.pdf only.
