# Kubernetes deployment (Assignment — multi-orchestration)

## Components delivered

| Resource | File | Purpose |
|----------|------|---------|
| Namespace + SLO ConfigMap | `00-namespace.yaml` | Isolation, SLO targets |
| HPA (orders, payment) | `01-hpa-orders-payment.yaml` | Auto-scaling (Assignment 6) |
| Scrape hints | `02-orders-podmonitor.yaml` | Observability metadata |
| SLO alerts ConfigMap | `../monitoring/prometheus-slo-alerts.yaml` | Alert rules |
| Kustomize overlay | `kustomization.yaml` | Bundled SRE resources |

## Deploy

```powershell
# From repository root
kubectl apply -f deploy/kubernetes/manifests/
kubectl apply -k sre-end-term/kubernetes/
kubectl apply -f deploy/kubernetes/manifests-monitoring/
```

Or use the script:

```powershell
.\sre-end-term\scripts\deploy-k8s.ps1
```

## NodePorts (default upstream manifests)

| Service | NodePort |
|---------|----------|
| front-end | 30001 |
| Prometheus | 31090 |
| Grafana | 31300 |

## Verify

```powershell
kubectl get pods -n sock-shop
kubectl get hpa -n sock-shop
kubectl top pods -n sock-shop
```
