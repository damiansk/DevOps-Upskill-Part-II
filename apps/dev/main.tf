module "server_frontend" {
  source = "../../modules/server"

  config = {
    name    = "server-frontend"
    subnets = data.aws_subnets.public.ids

    load_balancer = {
      internal        = false
      security_groups = [module.public-load_balancer-security_group.id]
      vpc_id          = data.aws_vpc.main.id
    }

    launch_template = {
      user_data = base64encode(templatefile("./templates/public-server.tpl", { private_server_url = "${module.server_backend.load_balancer_dns}" }))
      # user_data       = base64encode(templatefile("./templates/private-server.tpl", { database_url = "${module.database.host}" }))
      public          = true
      security_groups = [module.public-launch_template-security_group.id]
    }
  }

  depends_on = [module.server_backend]
}

module "server_backend" {
  source = "../../modules/server"

  config = {
    name    = "server-backend"
    subnets = data.aws_subnets.private.ids

    load_balancer = {
      internal        = true
      security_groups = [module.private-load_balancer-security_group.id]
      vpc_id          = data.aws_vpc.main.id
    }

    launch_template = {
      user_data       = base64encode(templatefile("./templates/private-server.tpl", { database_url = "${module.database.host}" }))
      public          = false
      security_groups = [module.private-launch_template-security_group.id]
    }
  }

  depends_on = [module.database]
}

module "database" {
  source = "../../modules/database"

  config = {
    name    = "dstolarek-upskill-database"
    vpc_id  = data.aws_vpc.main.id
    subnets = data.aws_subnets.public.ids


    database = {
      identifier = "dstolarek-upskill-rds"
      name       = "tododb"
      user       = "user"
      password   = "zaq12WSX" # Objekt generujący randomowy ciąg znaków - https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password
      # Dodanie do aws resource
    }

    security_groups = [module.private-database-security_group.id]
  }

  depends_on = [module.private-database-security_group]
}

module "private-database-security_group" {
  source = "../../modules/security_group"

  config = {
    vpc_id = data.aws_vpc.main.id
    # TODO: Move to config - variables
    name = "private-database"

    ingress = [{
      description = "MYSQL/Aurora"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
    egress = [{
      description = "MYSQL/Aurora"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }]
  }
}

module "private-load_balancer-security_group" {
  source = "../../modules/security_group"

  config = {
    vpc_id = data.aws_vpc.main.id
    # TODO: Move to config - variables
    name = "private-load_balancer"

    ingress = [{
      description = "all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      # TODO use locals for config
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
  source = "../../modules/security_group"

  config = {
    vpc_id = data.aws_vpc.main.id
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
  source = "../../modules/security_group"

  config = {
    vpc_id = data.aws_vpc.main.id
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
      }, {
      description = "MYSQL/Aurora"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      # cidr_blocks = ["0.0.0.0/0"] TODO
      security_groups = [module.private-database-security_group.id]
      }
    ]
  }
}

module "public-launch_template-security_group" {
  source = "../../modules/security_group"

  config = {
    vpc_id = data.aws_vpc.main.id
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
