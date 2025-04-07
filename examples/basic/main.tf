module "dns" {
  source = "../../"

  dns_zones = [
    {
      name   = "example-zone"
      zone   = "example.com."
      public = true
      labels = { "managed_by" = "terraform" }
      recordsets = [
        {
          name = "www.example.com."
          type = "A"
          ttl  = 300
          data = ["192.168.1.1"]
        },
        {
          name = "mail.example.com."
          type = "MX"
          ttl  = 300
          data = ["10 mail.example.com."]
        }
      ]
    }
  ]
}
