# System Architecture

## High-level diagram

```mermaid
flowchart TB
    User([User / Browser])
    FE[front-end<br/>Nginx UI]
    GW[edge-router<br/>API Gateway]
    User --> FE
    User --> GW

    subgraph Microservices
        AUTH[user<br/>Auth + Profile]
        PROD[catalogue<br/>Product]
        ORD[orders<br/>Order]
        PAY[payment<br/>Payment]
        NOTIF[queue-master<br/>Notification]
        CART[carts]
        SHIP[shipping]
    end

    GW --> AUTH
    GW --> PROD
    GW --> ORD
    GW --> PAY
    GW --> CART
    GW --> SHIP
    ORD --> NOTIF

    subgraph Data
        M1[(orders-db MongoDB)]
        M2[(user-db MongoDB)]
        MY[(catalogue-db MySQL)]
        RMQ[rabbitmq]
    end

    ORD --> M1
    AUTH --> M2
    PROD --> MY
    NOTIF --> RMQ

    subgraph Observability
        PROM[Prometheus]
        GRAF[Grafana]
        AM[Alertmanager]
    end

    ORD -. metrics .-> PROM
    PAY -. metrics .-> PROM
    PROD -. metrics .-> PROM
    AUTH -. metrics .-> PROM
    PROM --> GRAF
    PROM --> AM

    subgraph IaC
        TF[Terraform]
        AN[Ansible]
    end

    TF -->|network + monitoring| PROM
    AN -->|deploy stack| Microservices
```

## Orchestration comparison

| Capability | Docker Compose | Docker Swarm | Kubernetes |
|------------|----------------|--------------|--------------|
| Deploy speed | Fastest | Fast | Moderate |
| Replication | Manual scale | `deploy.replicas` | Deployment + HPA |
| Self-healing | restart policy | restart_policy | Pod reschedule |
| Config | env / compose files | configs (limited) | ConfigMaps / Secrets |
| Use case | Dev / demo | Small clusters | Production |

## Network (Compose)

All services share bridge network `sre-end-term-net` (`docker-compose.full.yml`).

## Request path (checkout)

1. `edge-router` → `carts` (add items)
2. `edge-router` → `orders` (create order) → `orders-db`
3. `edge-router` → `payment` (authorize)
4. `queue-master` + `rabbitmq` (async shipping notification)

## SRE control plane

| Layer | Tool | Path |
|-------|------|------|
| Provision | Terraform | `terraform/` |
| Configure & deploy | Ansible | `ansible/` |
| Observe | Prometheus + Grafana | `monitoring/` |
| Respond | Runbooks + scripts | `docs/`, `scripts/` |
