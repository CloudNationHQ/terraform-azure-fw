# firewalls
resource "azurerm_firewall" "this" {
  resource_group_name = coalesce(
    var.firewall.resource_group_name, var.resource_group_name
  )

  location = coalesce(
    var.firewall.location, var.location
  )

  name               = var.firewall.name
  sku_tier           = var.firewall.sku_tier
  sku_name           = var.firewall.sku_name
  firewall_policy_id = var.firewall.firewall_policy_id
  dns_proxy_enabled  = var.firewall.dns_proxy_enabled
  dns_servers        = var.firewall.dns_servers
  threat_intel_mode  = var.firewall.threat_intel_mode
  private_ip_ranges  = var.firewall.private_ip_ranges
  zones              = var.firewall.zones

  tags = coalesce(
    var.firewall.tags, var.tags
  )

  dynamic "virtual_hub" {
    for_each = var.firewall.virtual_hub != null ? { "this" = var.firewall.virtual_hub } : {}

    content {
      virtual_hub_id  = virtual_hub.value.virtual_hub_id
      public_ip_count = virtual_hub.value.public_ip_count
    }
  }

  dynamic "management_ip_configuration" {
    for_each = var.firewall.management_ip_configuration != null ? { "this" = var.firewall.management_ip_configuration } : {}

    content {
      name                 = management_ip_configuration.value.name
      subnet_id            = management_ip_configuration.value.subnet_id
      public_ip_address_id = management_ip_configuration.value.public_ip_address_id
    }
  }

  dynamic "ip_configuration" {
    for_each = var.firewall.ip_configurations

    content {
      name = coalesce(
        ip_configuration.value.name, ip_configuration.key
      )

      subnet_id            = ip_configuration.value.subnet_id
      public_ip_address_id = ip_configuration.value.public_ip_address_id
    }
  }
}
