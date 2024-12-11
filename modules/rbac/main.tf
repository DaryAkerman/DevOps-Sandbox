# Create Azure AD Users for Students
resource "azuread_user" "students" {
  for_each = var.students_info

  user_principal_name   = each.value.email
  display_name          = each.value.name
  password              = var.default_password
  force_password_change = true
}

# Assign Role for Each User to Resource Group
resource "azurerm_role_assignment" "student_role_assignment" {
  for_each = azuread_user.students

  scope                = var.resource_group_ids[each.key]
  principal_id         = each.value.object_id
  role_definition_name = var.role_definition_name
}
