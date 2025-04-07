## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_dns_recordset.recordsets](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_recordset) | resource |
| [yandex_dns_zone.zones](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dns_zones"></a> [dns\_zones](#input\_dns\_zones) | A list of DNS zones to create, each with its associated record sets. | <pre>list(object({<br/>    name   = string<br/>    zone   = string<br/>    public = bool<br/>    labels = optional(map(string), {})<br/>    recordsets = optional(list(object({<br/>      name = string<br/>      type = string<br/>      ttl  = number<br/>      data = list(string)<br/>    })), [])<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dns_recordsets"></a> [dns\_recordsets](#output\_dns\_recordsets) | n/a |
| <a name="output_dns_zones"></a> [dns\_zones](#output\_dns\_zones) | n/a |
