variable "config" {
  type = object({
    name = string

    desired_capacity = {
      type    = number
      default = 2
    }
    max_size = {
      type    = number
      default = 2
    }
    min_size = {
      type    = number
      default = 2
    }

    subnets = list(string)

    launch_template = object({
      id      = string
      version = string
    })

    lb_target_group_arn = string
  })
}
