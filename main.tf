# firewalls
resource "azurerm_firewall" "fw" {
  name                = var.instance.name
  resource_group_name = coalesce(lookup(var.instance, "resource_group", null), var.resource_group)
  location            = coalesce(lookup(var.instance, "location", null), var.location)
  sku_tier            = var.instance.sku_tier
  sku_name            = var.instance.sku_name
  firewall_policy_id  = try(var.instance.firewall_policy_id, null)
  dns_proxy_enabled   = try(var.instance.dns_proxy_enabled, false)
  dns_servers         = try(var.instance.dns_servers, null)
  threat_intel_mode   = try(var.instance.threat_intel_mode, "Alert")
  private_ip_ranges   = try(var.instance.private_ip_ranges, null)
  zones               = try(var.instance.zones, null)
  tags                = try(var.instance.tags, var.tags, {})

  dynamic "virtual_hub" {
    for_each = lookup(var.instance, "virtual_hub", null) != null ? [var.instance.virtual_hub] : []

    content {
      virtual_hub_id  = virtual_hub.value.virtual_hub_id
      public_ip_count = try(virtual_hub.value.public_ip_count, 1)
    }
  }

  dynamic "management_ip_configuration" {
    for_each = lookup(var.instance, "management_ip_configuration", null) != null ? [var.instance.management_ip_configuration] : []

    content {
      name                 = management_ip_configuration.value.name
      subnet_id            = management_ip_configuration.value.subnet_id
      public_ip_address_id = management_ip_configuration.value.public_ip_address_id
    }
  }

  dynamic "ip_configuration" {
    for_each = lookup(var.instance, "ip_configurations", {})

    content {
      name                 = ip_configuration.value.name
      subnet_id            = try(ip_configuration.value.subnet_id, null)
      public_ip_address_id = lookup(ip_configuration.value, "public_ip_address_id", null)
    }
  }
}
