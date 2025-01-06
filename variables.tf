# variable "rg-name" {
#   description = "To hold Resource group Name"
# }

# variable "rg-location" {
#   description = "To hold Resource group Name"
# }


# # ------------------------------

# variable "nsg-name" {
#   description = "This will be NSG Name"
# }

# # ------------------------------

# variable "Vnet-Name" {
#   description = "This will be name of virtual network"
# }

# variable "Address-Space" {
#   description = "Address Space of Vnet"
# }

# variable "subnetA-Addr-Pref" {
#   description = "SubnetA Address Prefix"
# }

# variable "subnetB-Addr-Pref" {
#   description = "SubnetA Address Prefix"
# }

# // taken help
# // https://github.com/kumarvna/terraform-azurerm-vm-scale-sets
# // https://terraformguru.com/terraform-real-world-on-azure-cloud/18-Azure-VM-ScaleSets-Manual-scaling/


# *********************************** Above for when develop infra using one main.tf file

variable "rg-location" {
  description = "Azure region for the resources"
  type        = string
}

variable "rg-name" {
  description = "Resource Group Name"
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name            = string
    address_prefixes = list(string)
  }))
}

variable "nsg_name" {
  description = "Name of the network security groups"
  type        = string
}

variable "nsg_rules" {
  description = "Map of NSG rules"
  type = map(object({
    name                        = string
    priority                    = number
    direction                   = string
    access                      = string
    protocol                    = string
    source_port_range           = string
    destination_port_range      = string
    source_address_prefix       = string
    destination_address_prefix  = string
  }))
}

variable "vmss_name" {
  description = "Name of the VMSS"
  type        = string
}

variable "vmss_instances" {
  description = "Number of instances in the VMSS"
  type        = number
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
}

variable "admin_password" {
  description = "Admin password for VMs"
  type        = string
}

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "lb_sku" {
  description = "SKU for the load balancer (e.g., Standard)"
  type        = string
}
