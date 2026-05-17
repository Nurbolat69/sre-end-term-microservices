# Terraform — Infrastructure Provisioning

## Local mode (default)

Uses the [Docker provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs) to provision:

- Application Docker network
- Prometheus and Grafana containers with persistent volumes
- Monitoring configuration mounted from `../monitoring/`

### Prerequisites

- Docker Desktop (or Docker Engine) running
- Terraform >= 1.3

### Usage

```powershell
terraform init
terraform plan
terraform apply
```

### Benefits (assignment alignment)

| Benefit              | How it is demonstrated                          |
|----------------------|---------------------------------------------------|
| Declarative config   | All resources in `main.tf`                        |
| Version control      | `.tf` files committed to Git                      |
| Reproducibility      | `terraform destroy` / `apply` recreates stack     |

## Cloud mode (optional)

The repository also includes AWS examples under:

- `../../staging/` — Kubernetes cluster on EC2
- `../../install/aws-minimesos/` — legacy AWS install

For the end-term report, document that production would use `aws_instance` resources (see `staging/main.tf`) while local development uses the Docker provider for zero-cost demos.
