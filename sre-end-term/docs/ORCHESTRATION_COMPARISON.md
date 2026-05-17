# Multi-Orchestration Comparison (PDF §6.3)

## Summary table

| Criterion | Docker Compose | Docker Swarm | Kubernetes |
|-----------|----------------|--------------|------------|
| **Learning curve** | Low | Medium | High |
| **Deploy command** | `compose up` | `stack deploy` | `kubectl apply` |
| **Replication** | Manual `--scale` | Built-in replicas | Deployment + HPA |
| **Self-healing** | Container restart | Task reschedule | Pod reschedule |
| **Load balancing** | DNS round-robin | Routing mesh / VIP | Service ClusterIP |
| **Config management** | env / files | configs (limited) | ConfigMap / Secret |
| **Auto-scaling** | No | Limited | HPA / VPA |
| **Best for** | Dev, demos, CI | Small prod clusters | Production at scale |

## When we use each (this project)

| Platform | Path | Role in project |
|----------|------|-----------------|
| Compose | `docker-compose/docker-compose.full.yml` | Primary demo + monitoring + incident drill |
| Swarm | `docker-swarm/docker-stack.yml` | Show replication & rolling updates |
| Kubernetes | `deploy/kubernetes/` + `kubernetes/` | HPA, PDB, production patterns |

## Justification (PDF)

1. **Comparative analysis** — same Sock Shop images, three orchestrators.  
2. **Deployment flexibility** — Ansible can target any layer.  
3. **SRE infrastructure design** — observability and IaC consistent across platforms.

## Example commands

```bash
# Compose
docker compose -f docker-compose.full.yml up -d

# Swarm
docker swarm init
docker stack deploy -c docker-swarm/docker-stack.yml sre-sock-shop

# Kubernetes
kubectl apply -f deploy/kubernetes/manifests/
kubectl apply -k sre-end-term/kubernetes/
```

## Observability parity

Prometheus scrape targets remain service hostnames (`orders`, `payment`, …). Network DNS differs per platform but metric names are identical — dashboards portable.
