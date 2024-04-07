module "load_balanecr" {
  source = "../../modules/load_balancer"
  lb = {
    name     = "dstolarek-lb"
    internal = false
    sg       = "sg-0b6fcdb09f37eb537"       # From the infra/dev result
    subnets  = ["subnet-0114fcddfcc500f84"] # From the infra/dev result
  }

  tg = {
    name = "dstolarek-tg"
  }

  vpc_id = "vpc-005d50ddb18cefa89"

  lt = {
    name        = "dstolarek-launch-template"
    description = "dstolarek launch template"
    user_data   = "user_data.sh"
    public      = true
    subnet_id   = "subnet-0114fcddfcc500f84" # From the infra/dev result
    sg          = ["sg-0b6fcdb09f37eb537"]   # From the infra/dev result
  }

  asg = {
    name    = "my-asg"
    subnets = ["subnet-0114fcddfcc500f84"] # From the infra/dev result
  }
}
