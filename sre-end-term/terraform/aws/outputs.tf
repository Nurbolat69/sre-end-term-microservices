output "swarm_manager_public_ips" {
  value = aws_instance.swarm_manager[*].public_ip
}

output "k8s_worker_public_ips" {
  value = aws_instance.k8s_worker[*].public_ip
}

output "ansible_inventory_hint" {
  value = "Add these IPs to ansible/inventory/hosts.yml under [swarm_managers] and [k8s_workers]"
}
