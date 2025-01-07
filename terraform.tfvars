# rg-name     = "ar-rg"
# rg-location = "East US"

# Vnet-Name         = "app-vnet"
# Address-Space     = ["10.0.0.0/16"]
# subnetA-Addr-Pref = ["10.0.1.0/24"]
# subnetB-Addr-Pref = ["10.0.2.0/24"]

# nsg-name = "app-nsg"

# *********************************** Above for when develop infra using one main.tf file

rg-location   = "eastus"
rg-name       = "ar-rg"
vnet_name     = "example-vnet"
address_space = ["10.0.0.0/16"]

subnets = [
  {
    name             = "subnetA"
    address_prefixes = ["10.0.1.0/24"]
  },
  {
    name             = "subnetB"
    address_prefixes = ["10.0.2.0/24"]
  }
]

nsg_name = "app-nsg"

nsg_rules = {
  ssh = {
    name                       = "SSH-Rule"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  http = {
    name                       = "HTTP-Rule"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  mysql = {
    name                       = "MySQL-Rule"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3306"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

vmss_name      = "wp-vmss"
vmss_instances = 2
admin_username = "adminuser"
admin_password = "P@ssw0rd1234!"

lb_name = "web-lb"
lb_sku  = "Standard"














