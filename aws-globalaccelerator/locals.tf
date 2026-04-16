locals {
  endpoint_configurations = try(length(var.endpoint_configuration), 0) > 0 ? var.endpoint_configuration : []
}