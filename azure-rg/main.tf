resource "azurerm_resource_group" "az_rg" {
  name     = var.rg_name
  location = var.rg_location

  tags = var.rg_tags
}

