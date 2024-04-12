module "load_balancer" {
  source = "../load_balancer"

  config = {
    name            = "${var.config.name}-load-balancer"
    subnets         = var.config.subnets
    internal        = var.config.load_balancer.internal
    security_groups = var.config.load_balancer.security_groups

    target_group = {
      name   = "${var.config.name}-target-group"
      vpc_id = var.config.load_balancer.vpc_id
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
      version = module.launch_template.latest_version
    }
    lb_target_group_arn = module.load_balancer.lb_target_group_arn
  }
}
