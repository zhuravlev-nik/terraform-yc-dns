resource "yandex_dns_zone" "zones" {
  for_each = { for zone in var.dns_zones : zone.name => zone }

  name   = each.value.name
  zone   = each.value.zone
  public = each.value.public
  labels = merge({ managed_by = "terraform" }, lookup(each.value, "labels", {}))
}


locals {
  zone_domain_by_name = {
    for z in var.dns_zones : z.name => z.zone
  }
  recordsets_map = {
    for rs in flatten([
      for z in var.dns_zones : [
        for r in lookup(z, "recordsets", []) : {
          zone_name = z.name
          zone_fqdn = z.zone
          name_fqdn = (
            contains(r.name, ".")
            ? lower(trimsuffix(r.name, "."))
            : lower("${r.name}.${trimsuffix(z.zone, ".")}")
          )
          type = upper(r.type)
          ttl  = coalesce(r.ttl, var.default_ttl)
          data = sort(distinct(tolist(r.data)))
        }
      ]
    ]) :
    "${rs.zone_name}|${rs.name_fqdn}|${rs.type}" => rs
  }
}



resource "yandex_dns_recordset" "recordsets" {
  for_each = local.recordsets_map

  zone_id = yandex_dns_zone.zones[each.value.zone_name].id
  name    = "${each.value.name_fqdn}."
  type    = each.value.type
  ttl     = each.value.ttl
  data    = each.value.data
}
