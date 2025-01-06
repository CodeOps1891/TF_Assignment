output "LB_frontend_ip_id" {
  value = azurerm_public_ip.lb_ip.id
}

output "lb_id" {
  value = azurerm_lb.web_lb.id
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.backend_pool.id
}