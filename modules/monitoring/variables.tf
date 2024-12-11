variable "workspace_name" {
  description = "Name of the Log Analytics Workspace"
  type        = string
}

variable "retention_days" {
  description = "Retention period for logs in days"
  type        = number
  default     = 30
}

variable "location" {
  description = "Location for the monitoring resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the monitoring resources"
  type        = string
}

variable "tags" {
  description = "Tags for the monitoring resources"
  type        = map(string)
  default     = {}
}

