resource "aws_vpc" "main" {
  cidr_block = var.config.cidr_block

  tags = {
    Name : var.config.name
  }
}

module "subnet" {
  source   = "../subnet"
  for_each = { for subnet in var.config.subnets : subnet.name => subnet }

  config = {
    vpc_id            = aws_vpc.main.id
    cidr_block        = each.value.cidr_block
    availability_zone = each.value.availability_zone
    tags              = each.value.tags
  }
}
