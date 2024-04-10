variable "config" {
  type = object({
    name     = string
    internal = bool
    lb_type = {
      type    = string
      default = "application"
    }
    security_groups = list(string)
    subnets         = list(string)

    target_group = object({
      name   = string
      vpc_id = string
    })
  })
}
