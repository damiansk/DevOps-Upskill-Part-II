module "server_frontend" {
  source = "../../modules/server"

  config = {
    name    = "server-frontend"
    subnets = data.aws_subnets.public.ids # frontend public subnets

    load_balancer = {
      internal        = false
      security_groups = [data.aws_security_group.public-load_balancer.id] # security group for fronted
      vpc_id          = data.aws_vpc.main.id                              # vpc_id
    }

    launch_template = {
      user_data       = filebase64("./templates/frontend.sh") # Mb use template_file?
      public          = true
      security_groups = [data.aws_security_group.public-launch_template.id] # public ec2 security_group
    }
  }
}
