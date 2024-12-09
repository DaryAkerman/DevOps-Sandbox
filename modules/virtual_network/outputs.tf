output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.student_vnet.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = azurerm_subnet.student_subnet.id
}

output "nsg_id" {
  description = "The ID of the network security group"
  value       = azurerm_network_security_group.student_nsg.id
}
