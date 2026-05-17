# Repository Structure (SRE End Term)

```
sre-end-term/
├── ci/                      # CI scripts (smoke.sh, validate.sh)
├── docker-compose/          # Assignment 1 - Compose + ports overlays
│   ├── docker-compose.full.yml      # PRIMARY stack
│   ├── docker-compose.incident.yml  # Assignment 4 overlay
│   ├── docker-compose.ports-*.yml
│   └── alertmanager.yml
├── docker-swarm/            # Swarm stack (Assignment 6)
├── kubernetes/              # K8s overlays: HPA, PDB, SLO ConfigMap
├── terraform/               # Assignment 5 (local + aws/)
├── ansible/                 # Assignment 6 roles & playbooks
│   ├── roles/common|docker|sock_shop
│   └── playbooks/
├── monitoring/              # Assignment 2-3 Prometheus + Grafana
│   ├── prometheus.yml
│   ├── recording.rules
│   ├── alert.rules
│   └── grafana/
├── scripts/                 # Automation
│   ├── _lib/SrePorts.ps1    # Shared port/compose helpers
│   ├── deploy-compose.ps1
│   ├── deploy-all.ps1
│   ├── demo-incident-full.ps1
│   └── verify-*.ps1
├── docs/                    # Reports & assignments
│   ├── TEAM_REPORT.md       # -> REPORT.pdf (40 pts)
│   ├── PRESENTATION.md      # -> PRESENTATION.pdf
│   ├── TEAM.md
│   ├── RUBRIC.md
│   └── assignments/         # ASSIGNMENT_01 .. 06
└── evidence/                # Drill exports (gitignored)

.github/workflows/
└── sre-team-ci-cd.yml       # Team CI/CD

deploy/kubernetes/           # Upstream Sock Shop K8s manifests
```

## Entry points

| Goal | Command |
|------|---------|
| Deploy everything | `.\scripts\deploy-all.ps1` |
| CI locally | `bash ci/validate.sh` |
| Incident drill | `.\scripts\demo-incident-full.ps1` |
| PDF report | Export `docs/TEAM_REPORT.md` |
