variable "config" {
  type = object({
    name        = string
    description = string

    user_data = string

    public          = bool
    subnet_id       = string
    security_groups = list(string)

    image_id = {
      type = string
      # TODO: Use data-source as a fallback
      default = "ami-0c101f26f147fa7fd"
    }
  })
}
