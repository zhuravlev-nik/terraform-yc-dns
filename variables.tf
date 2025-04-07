variable "dns_zones" {
  description = "A list of DNS zones to create, each with its associated record sets."
  type = list(object({
    name   = string
    zone   = string
    public = bool
    labels = optional(map(string), {})
    recordsets = optional(list(object({
      name = string
      type = string
      ttl  = number
      data = list(string)
    })), [])
  }))
}
