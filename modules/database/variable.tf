variable "config" {
  type = object({
    name    = string
    vpc_id  = string
    subnets = list(string)

    database = object({
      identifier = string
      name       = string
      user       = string
    })

    security_groups = list(string)
  })
}
