output "firewall" {
  description = "contains firewall configuration"
  value       = azurerm_firewall.this
}

output "public_ip_addresses" {
  description = "public ip addresses associated with the firewall"
  value = var.firewall.sku_name == "AZFW_Hub" ? (
    azurerm_firewall.this.virtual_hub[0].public_ip_addresses
    ) : ([
      for ip_config in azurerm_firewall.this.ip_configuration : ip_config.public_ip_address_id
  ])
}
