variable "project_name" {
  description = "Prefix for Terraform-managed Docker resources"
  type        = string
  default     = "sre-end-term"
}

variable "prometheus_port" {
  description = "Host port for Prometheus UI"
  type        = number
  default     = 9090
}

variable "grafana_port" {
  description = "Host port for Grafana UI"
  type        = number
  default     = 3000
}

variable "grafana_admin_password" {
  description = "Grafana admin password"
  type        = string
  default     = "foobar"
  sensitive   = true
}
