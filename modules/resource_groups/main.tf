resource "azurerm_resource_group" "rs" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
