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
    arn     = string

    launch_template = object({
      id      = string
      version = string
      arn     = string
    })
  })
}
