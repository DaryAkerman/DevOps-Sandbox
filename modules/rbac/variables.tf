variable "students_info" {
  description = "Map of students' names and emails"
  type = map(object({
    name  = string
    email = string
  }))
}

variable "resource_group_ids" {
  description = "Map of resource group IDs per student"
  type        = map(string)
}

variable "default_password" {
  description = "Default password for Azure AD users"
  type        = string
}

variable "role_definition_name" {
  description = "Role definition for student resource groups (e.g., Contributor)"
  type        = string
}