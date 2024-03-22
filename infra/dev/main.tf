module "networking" {
  source = "../../modules/networking"

  networking = {
    network         = var.networking.network
    security_groups = var.networking.security_groups
  }
}


data "aws_subnet" "private_subnet" {
  id = module.networking.network.subnets.public.id
}


module "pipeline" {
  source = "../../modules/ec2"

  ec2_config = {
    subnet_id     = data.aws_subnet.private_subnet.id
    ami           = var.ec2.ami
    instance_type = var.ec2.instance_type
    name          = var.ec2.name
  }
}

