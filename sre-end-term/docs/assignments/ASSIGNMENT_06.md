# Assignment 6 — Automation & Capacity Planning

## Требования PDF

1. Automated deployment  
2. Health checks and restart policies  
3. Load analysis and scaling strategies  

## Automation

| Tool | Что автоматизирует |
|------|-------------------|
| **Ansible** | `ansible/playbooks/site.yml` — полный deploy |
| **PowerShell** | `scripts/deploy-all.ps1` |
| **Docker Compose** | healthcheck + `unless-stopped` |
| **Swarm** | `restart_policy`, `update_config`, replicas |
| **Kubernetes** | HPA, PDB, Deployment controllers |

## Health checks

- Compose: каждый critical service → `/health`  
- K8s: liveness/readiness в upstream manifests  
- `scripts/verify-health.ps1`  

## Capacity planning

| Стратегия | Где |
|-----------|-----|
| Horizontal | Swarm replicas, K8s HPA `kubernetes/01-hpa-*.yaml` |
| Vertical | JVM `JAVA_OPTS`, K8s `resources.limits` |
| DB tuning | `docs/capacity-planning.md`, `docs/DATABASES.md` |

## Load test

```powershell
.\scripts\load-test.ps1
# Смотреть Grafana → Capacity dashboard
```

## Ansible one-liner

```powershell
cd ansible
ansible-playbook -i inventory/hosts.yml playbooks/site.yml
```
