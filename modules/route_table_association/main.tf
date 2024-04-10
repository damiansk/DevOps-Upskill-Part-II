resource "aws_route_table_association" "main" {
  for_each = { for index, associate in var.config : index => associate }

  subnet_id      = each.value.subnet_id
  route_table_id = each.value.route_table_id
}
