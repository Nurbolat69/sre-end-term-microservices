# Capacity Planning — Assignment 6

## Methodology

1. Baseline load: `load-test` container or manual browsing via edge-router.
2. Collect metrics: CPU, memory, request rate, latency (Prometheus + node-exporter).
3. Identify top consumers and bottlenecks.
4. Define scaling strategy (horizontal / vertical / DB tuning).

## Findings (Sock Shop demo)

| Component | Observation | Risk |
|-----------|-------------|------|
| **orders** | JVM heap 128–500 Mi; CPU spikes under checkout | High — critical path |
| **payment** | Lower traffic but synchronous in checkout | Medium |
| **orders-db** | Single Mongo replica; disk I/O on writes | **Bottleneck** |
| **catalogue-db** | MySQL; read-heavy, cached catalogue | Low–medium |
| **edge-router** | Front door; scales with replicas | Low |

**Conclusion:** Order and Payment services consume the most application CPU; **orders-db** is the primary data-plane bottleneck under concurrent checkouts.

## Metrics to watch

```promql
# Request rate per service
sum(rate(request_duration_seconds_count[5m])) by (service)

# Memory pressure
(node_memory_MemTotal_bytes - node_memory_MemAvailable_bytes) / node_memory_MemTotal_bytes

# Order latency p95
histogram_quantile(0.95, sum(rate(request_duration_seconds_bucket{job="orders"}[5m])) by (le))
```

## Scaling strategies

### 1. Horizontal scaling (replicas)

| Platform | Mechanism |
|----------|-----------|
| Docker Swarm | `deploy.replicas: 2` in `docker-swarm/docker-stack.yml` |
| Kubernetes | `kubectl scale deployment orders --replicas=3 -n sock-shop` |
| HPA | `deploy/kubernetes/autoscaling/` (CPU-based) |

**When:** CPU > 70% sustained, latency SLO at risk, error rate still within budget.

### 2. Vertical scaling (CPU/RAM)

- Increase `resources.limits` in Kubernetes manifests (`orders-dep.yaml`: 500m → 1000m CPU).
- JVM: `JAVA_OPTS=-Xmx256m` for orders/shipping under load tests.

**When:** Single-replica stateful constraints or license limits on replica count.

### 3. Database optimization

- MongoDB: enable replica set for orders-db (read scaling limited; write still primary-bound).
- Connection pooling tuning in orders service.
- Index review on order documents.

**When:** DB CPU > 80% or write latency dominates p95.

## Load test procedure

```powershell
docker run --rm --network sre-end-term_default weaveworksdemos/load-test:0.1.1 -h edge-router -r 100 -c 4
```

Monitor Grafana for 10 minutes; record peak RPS and p95 latency.

## Capacity targets (next quarter)

| Metric | Current (demo) | Target |
|--------|----------------|--------|
| Peak RPS (orders) | ~50 | 200 |
| p95 latency | ~180 ms | < 200 ms (SLO) |
| Orders replicas | 1 (compose) / 2 (swarm) | 3 (K8s prod) |

## Automation linkage

- Health checks + `restart: unless-stopped` in Compose
- Swarm `restart_policy` and rolling updates
- Prometheus `HighMemoryUsage` alert → scale-out runbook
