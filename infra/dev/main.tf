module "networking" {
  source = "../../modules/networking"

  networking = {
    network         = var.networking.network
    security_groups = var.networking.security_groups
  }
}

# data "aws_subnet" "public_subnet" {
#   id = module.networking.network.subnets.public-1.id
# }

module "pipeline" {
  source = "../../modules/ec2"

  ec2_config = {
    subnet_id     = module.networking.network.subnets.public-1.id
    ami           = var.ec2.ami
    instance_type = var.ec2.instance_type
    name          = var.ec2.name
  }
}

