
resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnets)
  name                 = var.subnets[count.index].name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnets[count.index].address_prefixes
}

resource "azurerm_subnet_network_security_group_association" "subnet-links" {
  depends_on = [ azurerm_subnet.subnets ]
  count                     = length(var.subnets)
  subnet_id                 = azurerm_subnet.subnets[count.index].id
  network_security_group_id = var.nsg-id
}