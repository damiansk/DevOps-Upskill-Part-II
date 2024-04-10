variable "config" {
  type = object({
    name    = string
    subnets = list(string)

    load_balancer = object({
      internal        = bool
      security_groups = list(string)
      vpc_id          = string
    })

    launch_template = object({
      user_data       = string
      public          = bool
      security_groups = list(string)
    })
  })
}
