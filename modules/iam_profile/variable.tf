variable "config" {
  type = object({
    name = string
    policies = list(object({
      name   = string
      policy = string
    }))
  })
}
