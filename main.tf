# // Resource Group
# resource "azurerm_resource_group" "example" {
#   name     = var.rg-name
#   location = var.rg-location
# }


# // NSG

# resource "azurerm_network_security_group" "example" {
#   name                = var.nsg-name
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

# resource "azurerm_network_security_rule" "SSH-rule" {
#   name                        = "SSH-Rule"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "22"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.example.name
#   network_security_group_name = azurerm_network_security_group.example.name
# }

# resource "azurerm_network_security_rule" "HTTP-rule" {
#   name                        = "HTTP-Rule"
#   priority                    = 110
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "80"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.example.name
#   network_security_group_name = azurerm_network_security_group.example.name
# }


# resource "azurerm_network_security_rule" "SQL-Rule" {
#   name                        = "MySQL-Rule"
#   priority                    = 120
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "3306"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.example.name
#   network_security_group_name = azurerm_network_security_group.example.name
# }


# // Vnet
# resource "azurerm_virtual_network" "example" {
#   name                = var.Vnet-Name
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
#   address_space       = var.Address-Space
# }

# resource "azurerm_subnet" "subnetA" {
#   name                 = "subnetA"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = var.subnetA-Addr-Pref
# }

# resource "azurerm_subnet" "subnetB" {
#   name                 = "subnetB"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefixes     = var.subnetB-Addr-Pref
# }

# resource "azurerm_subnet_network_security_group_association" "subnetA-link" {
#   subnet_id                 = azurerm_subnet.subnetA.id
#   network_security_group_id = azurerm_network_security_group.example.id
# }

# resource "azurerm_subnet_network_security_group_association" "subnetB-link" {
#   subnet_id                 = azurerm_subnet.subnetB.id
#   network_security_group_id = azurerm_network_security_group.example.id
# }


# //  VM for DB

# resource "azurerm_network_interface" "db_nic" {
#   name                = "db-nic"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnetB.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_linux_virtual_machine" "db_vm" {
#   name                            = "db-vm"
#   resource_group_name             = azurerm_resource_group.example.name
#   location                        = azurerm_resource_group.example.location
#   size                            = "Standard_B1s"
#   admin_username                  = "adminuser"
#   admin_password                  = "P@ssw0rd1234!"
#   custom_data                     = base64encode(local.custom_data_db)
#   disable_password_authentication = false
#   network_interface_ids = [
#     azurerm_network_interface.db_nic.id,
#   ]


#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }

#   os_disk {
#     storage_account_type = "Standard_LRS"
#     caching              = "ReadWrite"
#   }
# }


# // VM for WordPress

# # resource "azurerm_public_ip" "example" {
# #   name                = "Wp_publicIP"
# #   resource_group_name = azurerm_resource_group.example.name
# #   location            = azurerm_resource_group.example.location
# #   allocation_method   = "Static"
# # }

# # resource "azurerm_network_interface" "wp_nic" {
# #   name                = "wp-nic"
# #   resource_group_name = azurerm_resource_group.example.name
# #   location            = azurerm_resource_group.example.location

# #   ip_configuration {
# #     name                          = "internal"
# #     subnet_id                     = azurerm_subnet.subnetA.id
# #     private_ip_address_allocation = "Dynamic"
# #     public_ip_address_id          = azurerm_public_ip.example.id
# #   }
# # }

# # resource "azurerm_linux_virtual_machine" "wp_vm" {
# #   name                            = "WP-vm"
# #   resource_group_name             = azurerm_resource_group.example.name
# #   location                        = azurerm_resource_group.example.location
# #   size                            = "Standard_B1s"
# #   admin_username                  = "adminuser"
# #   admin_password                  = "P@ssw0rd1234!"
# #   custom_data                     = base64encode(local.custom_data_wp)
# #   disable_password_authentication = false
# #   network_interface_ids = [
# #     azurerm_network_interface.wp_nic.id,
# #   ]


# #   source_image_reference {
# #     publisher = "Canonical"
# #     offer     = "0001-com-ubuntu-server-jammy"
# #     sku       = "22_04-lts"
# #     version   = "latest"
# #   }

# #   os_disk {
# #     storage_account_type = "Standard_LRS"
# #     caching              = "ReadWrite"
# #   }
# # }

# // VMSS for WordPress
# resource "azurerm_linux_virtual_machine_scale_set" "example" {
#   name                = "wp-vmss"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   sku                 = "Standard_B1s"
#   instances           = 2
#   admin_username      = "adminuser"
#   admin_password      = "Ar1234567890" 
#   custom_data         =  base64encode(local.custom_data_wp)
#   disable_password_authentication = false
#   upgrade_mode = "Automatic"

#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }

#   os_disk {
#     storage_account_type = "Standard_LRS"
#     caching              = "ReadWrite"
#   }

#   network_interface {
#     name    = "example"
#     primary = true

#     ip_configuration {
#       name      = "internal"
#       primary   = true
#       subnet_id = azurerm_subnet.subnetA.id
#       load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id]
#       // If want public-ip on vmss instances
#       # public_ip_address {
#       #   name = "vmss-pubip"
#       # }

#     }
#   }
# }


# // Azure Standard Load Balancer

# resource "azurerm_public_ip" "lb_ip" {
#   name                = "lb_publicIP"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   allocation_method   = "Static"
# }

# resource "azurerm_lb" "web_lb" {
#   name                = "web-lb"
#   resource_group_name = azurerm_resource_group.example.name
#   location            = azurerm_resource_group.example.location
#   sku = "Standard"
#   frontend_ip_configuration {
#     name                 = "web-lb-publicip-1"
#     public_ip_address_id = azurerm_public_ip.lb_ip.id
#   }
# }

# #   // ( Backend Pool )

# resource "azurerm_lb_backend_address_pool" "web_lb_backend_address_pool" {
#   name                = "web-backend"
#   loadbalancer_id     = azurerm_lb.web_lb.id
# }

# #   // ( Probe )
# resource "azurerm_lb_probe" "web_lb_probe" {
#   name                = "tcp-probe"
#   protocol            = "Tcp"
#   port                = 80
#   loadbalancer_id     = azurerm_lb.web_lb.id
# }

# #   // ( LB rule )

# resource "azurerm_lb_rule" "web_lb_rule_app1" {
#   name                           = "web-app1-rule"
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   frontend_ip_configuration_name = azurerm_lb.web_lb.frontend_ip_configuration[0].name
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web_lb_backend_address_pool.id]
#   probe_id                       = azurerm_lb_probe.web_lb_probe.id
#   loadbalancer_id                = azurerm_lb.web_lb.id
# }





# *************************************  Above Code if for whole infra in one file


# Resource Group Module
module "resource_group" {
  source      = "./modules/resource-group"
  rg-name     = var.rg-name
  rg-location = var.rg-location
}

# Network Security Group Module
module "nsg" {
  source              = "./modules/azure-nsg"
  nsg-name            = var.nsg_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  rules               = var.nsg_rules
}

# Network Module
module "network" {
  source              = "./modules/azure-vnet"
  vnet_name           = var.vnet_name
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = var.address_space
  subnets             = var.subnets
  nsg-id              = module.nsg.nsg-id
}

module "vmfor_db" {
  source              = "./modules/azure-vm-db"
  custom_data         = base64encode(local.custom_data_db)
  vm_name             = "db-vm"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  vm_size             = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"
  subnet_id           = module.network.subnet_ids[1]
}

# Load Balancer Module
module "load_balancer" {
  source                  = "./modules/azure-lb"
  lb_public_ip_name       = "lb-public-ip"
  resource_group_name     = module.resource_group.name
  location                = module.resource_group.location
  lb_name                 = var.lb_name
  lb_sku                  = var.lb_sku
  frontend_ip_config_name = "frontend-config"
  backend_pool_name       = "backend-pool"
  probe_name              = "health-probe"
  probe_protocol          = "Tcp"
  probe_port              = 80
  lb_rule_name            = "lb-rule"
  lb_rule_protocol        = "Tcp"
  lb_rule_frontend_port   = 80
  lb_rule_backend_port    = 80
}

# VMSS for WordPress Module
module "vmssfor_wordpress" {
  depends_on                   = [module.vmfor_db]
  source                       = "./modules/azure-vmss-wordpress"
  vmss_name                    = var.vmss_name
  resource_group_name          = module.resource_group.name
  location                     = module.resource_group.location
  vm_size                      = "Standard_B1s"
  instances                    = var.vmss_instances
  admin_username               = var.admin_username
  admin_password               = var.admin_password
  custom_data                  = base64encode(local.custom_data_wp)
  upgrade_mode                 = "Automatic"
  os_disk_storage_account_type = "Standard_LRS"
  os_disk_caching              = "ReadWrite"
  nic_name                     = "vmss-nic"
  subnet_id                    = module.network.subnet_ids[0]
  backend_address_pool_ids     = [module.load_balancer.backend_pool_id]
}
