output "public_ip" {
  description = "The public IP address of the virtual machine"
  value       = azurerm_public_ip.student_public_ip.ip_address
}

output "vm_name" {
  description = "The name of the virtual machine"
  value       = azurerm_virtual_machine.student_vm.name
}

output "vm_id" {
  description = "The ID of the virtual machine"
  value       = azurerm_virtual_machine.student_vm.id
}
