resource "azurerm_resource_group" "az_rg" {
  name     = var.az_rg_name
  location = var.az_rg_location

  tags = var.rg_tags
}

