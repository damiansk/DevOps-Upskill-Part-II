resource "aws_internet_gateway" "main" {
  vpc_id = var.config.vpc_id

  tags = {
    Name = var.config.name
  }
}

module "internet_gateway_route_table" {
  source = "../route_table"

  vpc_id = var.config.vpc_id
  routes = [{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }]
  tags = {
    Name = "${var.config.name}-route_table"
  }
}
