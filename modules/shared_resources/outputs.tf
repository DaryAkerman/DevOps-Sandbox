output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.shared_storage.name
}

output "storage_account_primary_key" {
  description = "The primary access key for the storage account"
  value       = azurerm_storage_account.shared_storage.primary_access_key
}

output "student_containers" {
  description = "Map of student names to their storage containers"
  value       = { for name, container in azurerm_storage_container.student_containers : name => container.name }
}
