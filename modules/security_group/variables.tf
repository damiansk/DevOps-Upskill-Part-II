variable "config" {
  type = object({
    vpc_id = string
    name   = string

    ingress = optional(list(object({
      description     = optional(string)
      from_port       = optional(number)
      to_port         = optional(number)
      protocol        = optional(string)
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })), [])

    egress = optional(list(object({
      description     = optional(string)
      from_port       = optional(number)
      to_port         = optional(number)
      protocol        = optional(string)
      cidr_blocks     = optional(list(string))
      security_groups = optional(list(string))
    })), [])
  })
}
