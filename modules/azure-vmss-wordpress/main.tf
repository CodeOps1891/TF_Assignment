resource "azurerm_linux_virtual_machine_scale_set" "example" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.vm_size
  instances           = var.instances
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  custom_data         = var.custom_data
  disable_password_authentication = false
  upgrade_mode        = var.upgrade_mode

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = var.os_disk_storage_account_type
    caching              = var.os_disk_caching
  }

  network_interface {
    name    = var.nic_name
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = var.backend_address_pool_ids
    }
  }
}

