# Public IP
resource "azurerm_public_ip" "student_public_ip" {
  name                = "${var.name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Basic"
}

# Network Interface
resource "azurerm_network_interface" "vm_nic" {
  name                              = "${var.name}-nic"
  location                          = var.location
  resource_group_name               = var.resource_group_name

  ip_configuration {
    name                            = "Internal"
    subnet_id                       = var.subnet_id
    private_ip_address_allocation   = "Dynamic"
    public_ip_address_id            = azurerm_public_ip.student_public_ip.id
  }
}

# Virtual Machine
resource "azurerm_virtual_machine" "student_vm" {
  name                  = "${var.name}-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.vm_nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name                = "${var.name}-disk"
    caching             = "ReadWrite"
    create_option       = "FromImage"
    managed_disk_type   = "Standard_LRS"
  }

  storage_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  os_profile {
    computer_name  = var.name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
