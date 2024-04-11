output "private-load_balancer-id" {
  value = module.private-load_balancer-security_group.id
}

output "public-load_balancer-id" {
  value = module.public-load_balancer-security_group.id
}

output "private-launch_template-id" {
  value = module.private-launch_template-security_group.id
}

output "public-launch_template-id" {
  value = module.public-launch_template-security_group.id
}
