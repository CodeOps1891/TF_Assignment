variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
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

variable "nsg-id" {
  description = "Network Security Group ID"
}