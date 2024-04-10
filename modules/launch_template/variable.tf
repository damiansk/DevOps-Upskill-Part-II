variable "config" {
  type = object({
    name        = string
    description = string

    user_data = string

    public          = bool
    security_groups = list(string)

    # TODO: Use data-source as a fallback
    image_id = optional(string, "ami-0c101f26f147fa7fd")
  })
}
