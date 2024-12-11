# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "monitoring_workspace" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_days

  tags = var.tags
}

# Install Log Analytics Agent
resource "azurerm_virtual_machine_extension" "log_analytics_agent" {
  for_each = var.vm_ids

  name                 = "${each.key}-oms-agent"
  virtual_machine_id   = each.value
  publisher            = "Microsoft.EnterpriseCloud.Monitoring"
  type                 = "OmsAgentForLinux"
  type_handler_version = "1.16"

  settings = jsonencode({
    workspaceId = azurerm_log_analytics_workspace.monitoring_workspace.workspace_id
  })

  protected_settings = jsonencode({
    workspaceKey = azurerm_log_analytics_workspace.monitoring_workspace.primary_shared_key
  })
}

# Install Dependency Agent
resource "azurerm_virtual_machine_extension" "dependency_agent" {
  for_each = var.vm_ids

  name                 = "${each.key}-dependency-agent"
  virtual_machine_id   = each.value
  publisher            = "Microsoft.Azure.Monitoring.DependencyAgent"
  type                 = "DependencyAgentLinux"
  type_handler_version = "9.10"
}
