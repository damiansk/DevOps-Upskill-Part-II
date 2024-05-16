module "networking" {
  source = "../../modules/networking"

  networking = {
    network = var.networking.network
    igw     = var.networking.igw
    nat     = var.networking.nat
  }
}

module "pipeline" {
  source = "../../modules/ec2"

  ec2_config = {
    subnet_id       = module.networking.network.subnets.public-1.id
    ami             = var.ec2_pipeline.ami
    instance_type   = var.ec2_pipeline.instance_type
    name            = var.ec2_pipeline.name
    security_groups = [module.public-pipeline-security_group.id]
    public          = true
    # user_data       = base64encode(templatefile("./templates/pipeline.tpl", { runner_token = "${var.ec2_pipeline.runner_token}" }))
  }

  depends_on = [module.public-pipeline-security_group]
}

module "public-pipeline-security_group" {
  source = "../../modules/security_group"

  config = {
    vpc_id = module.networking.network.vpc_id
    name   = "public-pipeline"

    ingress = [{
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
