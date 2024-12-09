# Virtual Network
resource "azurerm_virtual_network" "student_vnet" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  address_space                 = var.address_space
}

# Network Security Group
resource "azurerm_network_security_group" "student_nsg" {
  name                          = "${var.name}-nsg"
  location                      = var.location
  resource_group_name           = var.resource_group_name

  security_rule {
    name                        = "Allow-SSH"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

# Subnet
resource "azurerm_subnet" "student_subnet" {
  name                          = "${var.name}-subnet"
  resource_group_name           = var.resource_group_name
  virtual_network_name          = azurerm_virtual_network.student_vnet.name
  address_prefixes              = [var.subnet_address_prefix]
}

# Subnet - NSG Association
resource "azurerm_subnet_network_security_group_association" "student_nsg_subnet_association" {
  network_security_group_id     = azurerm_network_security_group.student_nsg.id
  subnet_id                     = azurerm_subnet.student_subnet.id
}
