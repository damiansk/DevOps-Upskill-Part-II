variable "ec2_config" {
  type = object({
    ami             = string
    instance_type   = string
    subnet_id       = string
    name            = string
    user_data       = optional(string)
    security_groups = optional(list(string))
    public          = optional(bool)
  })
}
