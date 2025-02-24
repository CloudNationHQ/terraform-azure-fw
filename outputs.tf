output "instance" {
  description = "contains firewall configuration"
  value       = azurerm_firewall.fw
}

output "public_ip_addresses" {
  description = "public ip addresses associated with the firewall"
  value = var.instance.sku_name == "AZFW_Hub" ? (
    azurerm_firewall.fw.virtual_hub[0].public_ip_addresses
    ) : ([
      for ip_config in azurerm_firewall.fw.ip_configuration : ip_config.public_ip_address_id
  ])
}
