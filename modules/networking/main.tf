module "network" {
  source = "../network"

  config = {
    cidr_block = var.networking.network.cidr_block
    name       = var.networking.network.name
    subnets    = var.networking.network.subnets
  }
}

module "igw" {
  source = "../internet_gateway"

  vpc_id = module.network.vpc_id
  igw = {
    tags = {
      Name = var.networking.igw.resource_name
    }
  }
  rt = {
    routes = [{
      cidr_block = "0.0.0.0/0"
      gateway_id = module.igw.igw_id
    }]
    tags = {
      Name = "${var.networking.network.name}-public"
    }
  }

  depends_on = [module.network]
}

module "nat" {
  source = "../nat_gateway"

  vpc_id    = module.network.vpc_id
  subnet_id = module.network.subnets.public-1.id
  tag_name  = "${var.networking.network.name}-nat-eip"

  rt = {
    routes = [{
      cidr_block = "0.0.0.0/0"
      gateway_id = module.nat.nat_gw_id
    }]
    tags = {
      Name = "${var.networking.network.name}-private"
    }
  }

  depends_on = [module.network, module.igw.igw_id]
}

module "associate_rt_subnet" {
  source = "../associate_route-table_subnet"

  associate = [{
    subnet_id      = module.network.subnets.public-1.id
    route_table_id = module.igw.rt_id
    }, {
    subnet_id      = module.network.subnets.public-2.id
    route_table_id = module.igw.rt_id
    },
    {
      subnet_id      = module.network.subnets.private-1.id
      route_table_id = module.nat.rt_id
      }, {
      subnet_id      = module.network.subnets.private-2.id
      route_table_id = module.nat.rt_id
  }]
}

module "public_sg" {
  source = "../security_group"

  name        = var.networking.security_groups.public.resource_name
  description = var.networking.security_groups.public.resource_name
  vpc_id      = module.network.vpc_id

  tags = {
    Name = var.networking.security_groups.public.resource_name
  }
}

module "private_sg" {
  source = "../security_group"

  name        = var.networking.security_groups.private.resource_name
  description = var.networking.security_groups.private.resource_name
  vpc_id      = module.network.vpc_id

  tags = {
    Name = var.networking.security_groups.private.resource_name
  }
}
