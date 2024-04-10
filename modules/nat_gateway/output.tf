output "nat_gw" {
  value = aws_nat_gateway.main
}

output "nat_gw_id" {
  value = aws_nat_gateway.main.id
}

output "rt_id" {
  value = module.route_table_private.rt_id
}
