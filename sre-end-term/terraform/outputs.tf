output "docker_network_name" {
  description = "Application overlay network created by Terraform"
  value       = docker_network.sre_app.name
}

output "prometheus_url" {
  description = "Prometheus metrics UI"
  value       = "http://localhost:${var.prometheus_port}"
}

output "grafana_url" {
  description = "Grafana dashboards UI"
  value       = "http://localhost:${var.grafana_port}"
}

output "next_steps" {
  description = "Commands to deploy the full application stack"
  value       = <<-EOT
    1. Deploy microservices:  cd sre-end-term && .\scripts\deploy-compose.ps1
    2. Or use Ansible:        cd sre-end-term/ansible && ansible-playbook -i inventory/hosts.yml playbooks/site.yml
    3. Attach monitoring network to compose stack if needed (see README).
  EOT
}
