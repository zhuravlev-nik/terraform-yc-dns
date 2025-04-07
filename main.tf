resource "yandex_dns_zone" "zones" {
  for_each = { for zone in var.dns_zones : zone.name => zone }

  name   = each.value.name
  zone   = each.value.zone
  public = each.value.public
  labels = merge(
    { "managed_by" = "terraform" },
    each.value.labels
  )
}

resource "yandex_dns_recordset" "recordsets" {
  for_each = { for idx, record in flatten([
    for zone in var.dns_zones : [
      for recordset in zone.recordsets : {
        zone_name = zone.name
        zone_id   = yandex_dns_zone.zones[zone.name].id
        name      = recordset.name
        type      = recordset.type
        ttl       = recordset.ttl
        data      = recordset.data
      }
    ]
  ]) : "${record.zone_name}-${record.name}-${idx}" => record }

  zone_id = each.value.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = each.value.ttl
  data    = each.value.data
}
