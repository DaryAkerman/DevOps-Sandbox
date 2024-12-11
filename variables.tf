variable "students" {
  description = "List of students"
  type        = list(string)
}

variable "students_info" {
  description = "Map of students' names and emails"
  type = map(object({
    name  = string
    email = string
  }))
}

variable "role_definition_name" {
  description = "Role definition for student resource groups (e.g., Contributor)"
  type        = string
  default     = "Contributor"
}

variable "shared_role_definition_name" {
  description = "Role definition for shared resources (e.g., Reader)"
  type        = string
  default     = "Reader"
}

variable "admin_username" {
  description   = "The admin username of the virtual machine"
  type          = string
}

variable "admin_password" {
  description   = "The admin password for the virtual machine"
  type          = string
}

variable "default_password" {
  description = "The default password for each Azure User"
  type        = string
}

variable "force_cleanup" {
  description = "Flag to force cleanup regardless of time"
  type        = bool
  default     = false
}