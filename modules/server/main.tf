module "load_balancer" {
  source = "../load_balancer"

  config = {
    name            = "${var.config.name}-load_balancer"
    internal        = var.load_balancer.config.internal
    security_groups = var.load_balancer.config.security_groups
    subnets         = var.load_balancer.config.subnets

    target_group = {
      name   = "${var.config.name}-target_group"
      vpc_id = var.load_balancer.config.vpc_id
    }
  }
}

module "launch_template" {
  source = "../launch_template"

  config = {
    name        = "${var.config.name}-launch_template"
    description = "Launch template for ${var.config.name}"

    user_data = var.config.launch_template.user_data

    public          = var.config.launch_template.public
    security_groups = var.config.launch_template.security_groups
  }
}

module "autoscaling_group" {
  source = "../autoscaling_group"

  config = {
    name    = "${var.config.name}-autoscaling_group"
    subnets = var.config.subnets
    launch_template = {
      id      = module.launch_template.id
      version = module.launch_template.version
    }
    lb_target_group_arn = module.load_balancer.lb_target_group_arn
  }
}
