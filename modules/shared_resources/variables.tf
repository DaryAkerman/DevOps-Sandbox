variable "students" {
  description = "The list of students"
  type        = list(string)
}

variable "storage_account_name" {
  description = "The name of the shared storage account"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location of the storage account"
  type        = string
}

variable "tags" {
  description = "Tags for the storage account"
  type        = map(string)
  default     = {}
}
