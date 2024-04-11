module "network" {
  source = "../network"

  config = var.networking.network
}

module "internet_gateway" {
  source = "../internet_gateway"

  config = {
    vpc_id = module.network.vpc_id
    name   = "${var.networking.network.name}-internet_gateway"
  }
  # depends_on = [module.network]
}

module "nat_gateway" {
  source = "../nat_gateway"

  config = {
    name      = "${var.networking.network.name}-nat_gateway"
    vpc_id    = module.network.vpc_id
    subnet_id = module.network.subnets.public-1.id
  }
  # depends_on = [module.network]
}

module "route_table_association" {
  source = "../route_table_association"

  config = [{
    subnet_id      = module.network.subnets.public-1.id
    route_table_id = module.internet_gateway.route_table_id
    }, {
    subnet_id      = module.network.subnets.public-2.id
    route_table_id = module.internet_gateway.route_table_id
    }, {
    subnet_id      = module.network.subnets.private-1.id
    route_table_id = module.nat_gateway.route_table_id
    }, {
    subnet_id      = module.network.subnets.private-2.id
    route_table_id = module.nat_gateway.route_table_id
  }]
}

module "security_groups" {
  source = "../security_group"

  config = {
    vpc_id = module.network.vpc_id
    name   = "${var.networking.network.name}-security_group"

    security_groups = var.networking.security_groups
  }
}
