module "private-load_balancer-security_group" {
  source = "./security_group"

  config = {
    vpc_id = var.config.vpc_id
    name   = "private-load_balancer"

    ingress = [{
      description     = "all"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = [module.public-launch_template-security_group.id]
    }]
    egress = [{
      description     = "all"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = [module.public-load_balancer-security_group.id]
    }]
  }
}

module "public-load_balancer-security_group" {
  source = "./security_group"

  config = {
    vpc_id = var.config.vpc_id
    name   = "public-load_balancer"

    ingress = [{
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}

module "private-launch_template-security_group" {
  source = "./security_group"

  config = {
    vpc_id = var.config.vpc_id
    name   = "private-launch_template"

    ingress = [{
      description     = "HTTP"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = [module.public-launch_template-security_group.id]
      }, {
      description     = "HTTP"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      security_groups = [module.private-load_balancer-security_group.id]
    }]
    egress = [{
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      }
      # TODO: ,{
      #   description              = "MYSQL/Aurora"
      #   from_port                = 3306
      #   to_port                  = 3306
      #   protocol                 = "tcp"
      #   security_groups = [module.rds_security_group.id]
      # }
    ]
  }
}

module "public-launch_template-security_group" {
  source = "./security_group"

  config = {
    vpc_id = var.config.vpc_id
    name   = "public-launch_template"

    ingress = [{
      description = "HTTP"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      }, {
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}
