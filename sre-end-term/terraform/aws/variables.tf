variable "project_name" {
  type    = string
  default = "sre-end-term"
}

variable "aws_region" {
  type    = string
  default = "eu-west-1"
}

variable "ami_id" {
  description = "Ubuntu 22.04 LTS AMI in your region"
  type        = string
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "key_name" {
  description = "Existing EC2 key pair name"
  type        = string
}

variable "admin_cidr" {
  description = "CIDR allowed for SSH (use your IP/32)"
  type        = string
  default     = "0.0.0.0/0"
}

variable "swarm_manager_count" {
  type    = number
  default = 1
}

variable "k8s_worker_count" {
  type    = number
  default = 2
}
