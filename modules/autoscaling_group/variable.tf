variable "config" {
  type = object({
    name = string

    desired_capacity = optional(number, 2)
    max_size         = optional(number, 2)
    min_size         = optional(number, 2)

    subnets = list(string)

    launch_template = object({
      id      = string
      version = string
    })

    lb_target_group_arn = string
  })
}
