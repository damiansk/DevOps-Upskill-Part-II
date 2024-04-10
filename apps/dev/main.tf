module "server_frontend" {
  source = "../../modules/server"

  config = {
    name    = "dstolarek-server-frontend"
    subnets = [""] # frontend public subnets

    load_balancer = {
      internal        = false
      security_groups = [""] # security group for fronted
      vpc_id          = ""   # vpc_id
    }

    launch_template = {
      user_data       = filebase64("./templates/frontend.sh") # Mb use template_file?
      public          = true
      security_groups = [""] # public ec2 security_group
    }
  }
}
