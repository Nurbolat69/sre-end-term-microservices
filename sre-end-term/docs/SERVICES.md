# Microservices Source Code Map

Sock Shop ships as **pre-built Docker images** (`weaveworksdemos/*`). Upstream source repositories:

| Assignment service | Image | Upstream source |
|------------------|-------|-----------------|
| Authentication + User Profile | `weaveworksdemos/user` | [microservices-demo/user](https://github.com/microservices-demo/user) |
| Product | `weaveworksdemos/catalogue` | [microservices-demo/catalogue](https://github.com/microservices-demo/catalogue) |
| Order | `weaveworksdemos/orders` | [microservices-demo/orders](https://github.com/microservices-demo/orders) |
| Payment | `weaveworksdemos/payment` | [microservices-demo/payment](https://github.com/microservices-demo/payment) |
| Notification | `weaveworksdemos/queue-master` | [microservices-demo/queue-master](https://github.com/microservices-demo/queue-master) |
| Frontend | `weaveworksdemos/front-end` | [microservices-demo/front-end](https://github.com/microservices-demo/front-end) |
| API Gateway | `weaveworksdemos/edge-router` | [microservices-demo/front-end](https://github.com/microservices-demo/front-end) (nginx router) |
| Shipping | `weaveworksdemos/shipping` | [microservices-demo/shipping](https://github.com/microservices-demo/shipping) |
| Carts | `weaveworksdemos/carts` | [microservices-demo/carts](https://github.com/microservices-demo/carts) |

## Monorepo layout (this repository)

```
microservices-demo-master/
├── deploy/          # K8s manifests, compose variants
├── sre-end-term/    # End term SRE deliverables (this project)
├── internal-docs/   # design.md, testing.md
└── healthcheck/     # synthetic monitoring helper
```

## Metrics endpoints

| Service | Path |
|---------|------|
| orders, carts, edge-router | `/metrics` |
| catalogue, payment, user, shipping | `/metrics` or root health |
| queue-master | `/prometheus` |

Configured in `monitoring/prometheus.yml`.
