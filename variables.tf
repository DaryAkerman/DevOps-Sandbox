variable "students" {
  description = "A list of students (names)"
  type        = list(string)
}

variable "admin_username" {
  description   = "The admin username of the virtual machine"
  type          = string
}

variable "admin_password" {
  description   = "The admin password for the virtual machine"
  type          = string
}