variable "vmss_name" {
  description = "Name of the VMSS"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machines in the scale set"
  type        = string
}

variable "instances" {
  description = "Number of instances in the scale set"
  type        = number
}

variable "admin_username" {
  description = "Admin username for the VMSS instances"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VMSS instances"
  type        = string
}

variable "custom_data" {
  description = "Custom data for cloud-init on VMSS instances"
  type        = string
}

variable "upgrade_mode" {
  description = "Upgrade mode for the scale set (e.g., Manual, Automatic, or Rolling)"
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for the OS disk"
  type        = string
}

variable "os_disk_caching" {
  description = "Caching setting for the OS disk"
  type        = string
}

variable "nic_name" {
  description = "Name of the network interface for the VMSS instances"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the VMSS instances will be deployed"
  type        = string
}

variable "backend_address_pool_ids" {
  description = "List of backend address pool IDs for load balancing"
  type        = list(string)
}
