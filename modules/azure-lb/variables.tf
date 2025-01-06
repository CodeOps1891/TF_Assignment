variable "lb_public_ip_name" {
  description = "Name of the public IP for the load balancer"
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

variable "lb_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "lb_sku" {
  description = "SKU of the load balancer (e.g., Basic, Standard)"
  type        = string
}

variable "frontend_ip_config_name" {
  description = "Name of the frontend IP configuration"
  type        = string
}

variable "backend_pool_name" {
  description = "Name of the backend address pool"
  type        = string
}

variable "probe_name" {
  description = "Name of the health probe"
  type        = string
}

variable "probe_protocol" {
  description = "Protocol for the health probe (e.g., TCP, HTTP)"
  type        = string
}

variable "probe_port" {
  description = "Port for the health probe"
  type        = number
}

variable "lb_rule_name" {
  description = "Name of the load balancer rule"
  type        = string
}

variable "lb_rule_protocol" {
  description = "Protocol for the load balancer rule (e.g., TCP)"
  type        = string
}

variable "lb_rule_frontend_port" {
  description = "Frontend port for the load balancer rule"
  type        = number
}

variable "lb_rule_backend_port" {
  description = "Backend port for the load balancer rule"
  type        = number
}
