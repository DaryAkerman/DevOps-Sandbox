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
    Environment = "DevOps Sandox"
    Owner       = each.key
  }
}

module "virtual_network" {
  source              = "./modules/virtual_networks"
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
