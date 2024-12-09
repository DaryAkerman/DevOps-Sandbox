variable "name" {
  description = "The name of the virtual machine"
  type        = string
}

variable "location" {
  description = "The location of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "The resource group name for the VM"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the VM will be deployed"
  type        = string
}

variable "vm_size" {
  description = "The size of the virtual machine"
  type        = string
}

variable "image" {
  description = "The image configuration for the virtual machine"
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
}

variable "admin_username" {
  description = "The admin username for the virtual machine"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the virtual machine"
  type        = string
}
