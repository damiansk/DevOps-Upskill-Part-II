variable "config" {
  type = object({
    cidr_block = string
    name       = string

    subnets = list(object({
      name              = string
      cidr_block        = string
      availability_zone = string
      tags              = map(string)
    }))
  })
}
