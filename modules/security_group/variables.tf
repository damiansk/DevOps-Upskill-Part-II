variable "config" {
  type = object({
    vpc_id = string
    name   = string

    security_groups = list(object({
      name = string

      ingress_rules = optional(list(object({
        description     = optional(string)
        from_port       = optional(number)
        to_port         = optional(number)
        protocol        = optional(string)
        cidr_blocks     = optional(list(string))
        security_groups = optional(list(string))
      })), [])

      egress_rules = optional(list(object({
        description     = optional(string)
        from_port       = optional(number)
        to_port         = optional(number)
        protocol        = optional(string)
        cidr_blocks     = optional(list(string))
        security_groups = optional(list(string))
      })), [])
    }))
  })
}
