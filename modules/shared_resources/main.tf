resource "azurerm_storage_account" "shared_storage" {
  name                     = var.storage_account_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "student_containers" {
  for_each                 = toset(var.students)
  name                     = each.key
  storage_account_id       = azurerm_storage_account.shared_storage.id
  container_access_type    = "private"
}