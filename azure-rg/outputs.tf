
output "rg_name" {
  value       = azurerm_resource_group.az_rg.name
  description = "The Name which should be used for this Resource Group"
}

output "rg_location" {
  value       = azurerm_resource_group.az_rg.location
  description = "The Azure Region where the Resource Group should exist"
}
