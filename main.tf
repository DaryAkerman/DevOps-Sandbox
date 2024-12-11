locals {
  student_map = zipmap(var.students, range(length(var.students)))
  vms = {
    for student in var.students : student => {
      subnet_id = module.virtual_network[student].subnet_id
      vm_size   = "Standard_B1s"
      image = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }
    }
  }
}

module "resource_groups" {
  source    = "./modules/resource_groups"
  for_each = toset(var.students)
  name      = "${each.key}-sandbox-rg"
  location  = "East US"
  tags      = {
    Environment = "DevOps Sandbox"
    Owner       = each.key
  }
}

module "shared_resource_group" {
  source = "./modules/resource_groups"

  name      = "shared-sandbox-rg"
  location  = "East US"
  tags      = {
    Environment = "DevOps Sandbox"
    Owner       = "Shared Resources"
  }
}

module "virtual_network" {
  source              = "./modules/virtual_network"
  for_each            = local.student_map

  name                = "${each.key}-vnet"
  location            = module.resource_groups[each.key].resource_group_location
  resource_group_name = module.resource_groups[each.key].resource_group_name
  address_space       = ["10.${each.value}.0.0/16"]
  subnet_address_prefix = "10.${each.value}.0.0/24"
}

module "virtual_machine" {
  source              = "./modules/virtual_machine"
  for_each            = local.student_map

  name                = each.key
  location            = module.resource_groups[each.key].resource_group_location
  resource_group_name = module.resource_groups[each.key].resource_group_name
  subnet_id           = module.virtual_network[each.key].subnet_id
  vm_size             = "Standard_B1s"
  image = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

module "shared_resources" {
  source              = "./modules/shared_resources"
  students            = var.students
  storage_account_name = "studentstorgtest"
  resource_group_name = module.shared_resource_group.resource_group_name
  location            = module.shared_resource_group.resource_group_location
  tags = {
    Environment = "DevOps Sandbox"
    Owner       = "Shared Resources"
  }
}

module "monitoring" {
  source              = "./modules/monitoring"
  workspace_name      = "sandbox-monitoring-workspace"
  location            = module.shared_resource_group.resource_group_location
  resource_group_name = module.shared_resource_group.resource_group_name
  retention_days      = 30

  tags = {
    Environment = "DevOps Sandbox"
    Owner       = "Monitoring"
  }
}

module "rbac" {
  source = "./modules/rbac"

  students_info         = var.students_info
  resource_group_ids    = { for key, module in module.resource_groups : key => module.resource_group_id }
  default_password      = var.default_password
  role_definition_name  = var.role_definition_name
}

