# Cross-platform shortcuts (use Git Bash / WSL / make on Windows)
.PHONY: up down health slo incident recover evidence all validate ci

validate ci:
	bash ci/validate.sh

up:
	cd docker-compose && docker compose -f docker-compose.full.yml -f docker-compose.ports-default.yml up -d

down:
	cd docker-compose && docker compose -f docker-compose.full.yml -f docker-compose.ports-default.yml down -v

health:
	powershell -File scripts/verify-health.ps1

slo:
	powershell -File scripts/verify-slo.ps1

incident:
	powershell -File scripts/demo-incident-full.ps1

recover:
	powershell -File scripts/recover-incident.ps1

evidence:
	powershell -File scripts/export-evidence.ps1

all:
	powershell -File scripts/deploy-all.ps1

terraform:
	cd terraform && terraform init && terraform apply

ansible:
	cd ansible && ansible-playbook -i inventory/hosts.yml playbooks/site.yml

k8s:
	powershell -File scripts/deploy-k8s.ps1

swarm:
	powershell -File scripts/deploy-swarm.ps1
