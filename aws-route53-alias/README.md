```terraform
inputs = {
  records = {
    "dev.foulplay.live" = {
      name = "dev.foulplay.live"
      zone_id = "Z090068228754S5CAUC0Y"

      target_dns_name = "dgtrlrb3f75kj.cloudfront.net"
      target_zone_id = "Z2FDTNDATAQYW2"
      evaluate_target_health = "true"
    }
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | >= 1.2 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_record"></a> [record](#module\_record) | ./aws_alias | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_records"></a> [records](#input\_records) | A map of record with parameters | <pre>map(object({<br>    name            = optional(string, "")<br>    zone_id         = optional(string, "")<br>    zone_name       = optional(string, "")<br>    private_zone    = optional(bool, false)<br>    allow_overwrite = optional(bool, false)<br>    target_dns_name = optional(string)<br>    target_zone_id  = optional(string)<br>    evaluate_target_health     = optional(bool, false)<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->