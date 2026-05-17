# Ansible — Configuration Management (Assignment 5 & 6)

## Playbooks

| Playbook | Purpose |
|----------|---------|
| `site.yml` | Full local deployment |
| `install-docker.yml` | Docker on Linux Swarm/K8s nodes |
| `deploy-compose.yml` | Docker Compose full stack |
| `deploy-swarm.yml` | Docker Swarm stack |
| `deploy-kubernetes.yml` | kubectl apply manifests |
| `setup-monitoring.yml` | Legacy monitoring-only compose |

## Quick start (Windows / local)

```powershell
# Install Ansible: pip install ansible
cd sre-end-term\ansible
ansible-playbook -i inventory/hosts.yml playbooks/site.yml
```

## Remote nodes (after Terraform AWS)

1. Add IPs to `inventory/hosts.yml` under `swarm_managers` / `k8s_workers`.
2. Run:

```bash
ansible-playbook -i inventory/hosts.yml playbooks/install-docker.yml
ansible-playbook -i inventory/hosts.yml playbooks/deploy-swarm.yml
```

## Variables

Edit `group_vars/all.yml`:

- `compose_dir` — path to docker-compose files
- `deploy_application` / `deploy_monitoring` — toggles in `site.yml`
