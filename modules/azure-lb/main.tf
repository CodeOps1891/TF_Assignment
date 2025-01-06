resource "azurerm_public_ip" "lb_ip" {
  name                = var.lb_public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
}

resource "azurerm_lb" "web_lb" {
  name                = var.lb_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.lb_sku

  frontend_ip_configuration {
    name                 = var.frontend_ip_config_name
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                = var.backend_pool_name
  loadbalancer_id     = azurerm_lb.web_lb.id
}

resource "azurerm_lb_probe" "health_probe" {
  name                = var.probe_name
  protocol            = var.probe_protocol
  port                = var.probe_port
  loadbalancer_id     = azurerm_lb.web_lb.id
}

resource "azurerm_lb_rule" "lb_rule" {
  name                           = var.lb_rule_name
  protocol                       = var.lb_rule_protocol
  frontend_port                  = var.lb_rule_frontend_port
  backend_port                   = var.lb_rule_backend_port
  frontend_ip_configuration_name = var.frontend_ip_config_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.health_probe.id
  loadbalancer_id                = azurerm_lb.web_lb.id
}

