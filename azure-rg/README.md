# tazure_rg

Terraform module for creating Azure Resource Group resources

## Examples

```
provider "azurerm" {
  features {}
}

module "resource-group" {
  source = ""

  rg_name     = "ResourceGroup-Name"
  rg_location = "UK South"

  rg_tags = {
    Environment   = "Dev"
    Terraform     = "true"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.12 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | =3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | =3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.az_rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.0.0/docs/resources/resource_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rg_location"></a> [rg\_location](#input\_rg\_location) | The Azure Region where the Resource Group should exist | `string` | n/a | yes |
| <a name="input_rg_name"></a> [rg\_name](#input\_rg\_name) | The Name of the Resource Group | `string` | n/a | yes |
| <a name="input_rg_tags"></a> [rg\_tags](#input\_rg\_tags) | A mapping of tags which should be assigned to all resources | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rg_location"></a> [rg\_location](#output\_rg\_location) | The Azure Region where the Resource Group should exist |
| <a name="output_rg_name"></a> [rg\_name](#output\_rg\_name) | The Name which should be used for this Resource Group |
<!-- END_TF_DOCS -->