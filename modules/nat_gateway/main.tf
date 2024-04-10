resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = var.config.subnet_id

  tags = {
    Name = var.config.name
  }
}

resource "aws_eip" "main" {
  tags = {
    Name = "${var.config.name}-elastic_ip"
  }
}

module "nat_gateway_route_table" {
  source = "../route_table"

  vpc_id = var.config.vpc_id
  routes = [{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }]
  tags = {
    Name = "${var.config.name}-route_table"
  }
}
