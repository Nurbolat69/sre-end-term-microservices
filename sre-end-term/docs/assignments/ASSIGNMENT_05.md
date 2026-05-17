# Assignment 5 — Infrastructure as Code (Terraform)

## Требования PDF

1. Terraform-based provisioning  
2. Automated VM creation  

## Реализация

| Режим | Путь | Назначение |
|-------|------|------------|
| **Local** | `terraform/` | Docker network, volumes, Prometheus/Grafana (без облака) |
| **AWS** | `terraform/aws/` | EC2 Swarm managers + K8s workers, security groups |

## Local apply

```powershell
cd terraform
terraform init
terraform plan
terraform apply
.\..\scripts\deploy-terraform.ps1
```

## AWS apply (optional)

```bash
cd terraform/aws
cp terraform.tfvars.example terraform.tfvars
# Заполнить: ami_id, key_name, admin_cidr
terraform init && terraform apply
```

Outputs → IPs для `ansible/inventory/hosts.yml`.

## Benefits (PDF §7)

- Declarative `.tf` files in Git  
- `terraform plan` before change  
- Reproducible environments  

## Файлы

- `main.tf`, `variables.tf`, `outputs.tf`  
- `terraform/aws/main.tf` — VMs + user_data (Docker/K8s)  
- `.gitignore` — state не в Git  
