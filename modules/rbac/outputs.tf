output "user_object_ids" {
  description = "Object IDs of created Azure AD users"
  value       = { for key, user in azuread_user.students : key => user.object_id }
}

output "role_assignments" {
  description = "Role assignments for students"
  value       = azurerm_role_assignment.student_role_assignment
}
