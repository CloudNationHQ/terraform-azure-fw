output "network_rule_collections" {
  description = "contains all network rule collections"
  value       = azurerm_firewall_network_rule_collection.this
}

output "nat_rule_collections" {
  description = "contains all nat rule collections"
  value       = azurerm_firewall_nat_rule_collection.this
}

output "application_rule_collections" {
  description = "contains all application rule collections"
  value       = azurerm_firewall_application_rule_collection.this
}
