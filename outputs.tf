output "resource_group_names" {
  description = "The names of all resource groups created"
  value       = [for rg in module.resource_groups : rg.resource_group_name]
}

output "resource_group_ids" {
  description = "The IDs of all resource groups created"
  value       = [for rg in module.resource_groups : rg.resource_group_id]
}

output "public_ips" {
  description = "A map of all public IP addresses for the virtual machines"
  value       = { for student, vm in module.virtual_machine : student => vm.public_ip }
}
