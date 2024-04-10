variable "config" {
  type = object({
    name            = string
    internal        = bool
    lb_type         = optional(string, "application")
    security_groups = list(string)
    subnets         = list(string)

    target_group = object({
      name   = string
      vpc_id = string
    })
  })
}
