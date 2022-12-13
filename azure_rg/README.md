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
