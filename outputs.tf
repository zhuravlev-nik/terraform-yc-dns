output "dns_zones" {
  value = yandex_dns_zone.zones
}

output "dns_recordsets" {
  value = yandex_dns_recordset.recordsets
}
