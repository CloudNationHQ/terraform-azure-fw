# firewalls
resource "azurerm_firewall" "fw" {

  resource_group_name = coalesce(
    lookup(
      var.instance, "resource_group_name", null
    ), var.resource_group_name
  )

  location = coalesce(
    lookup(var.instance, "location", null
    ), var.location
  )

  name               = var.instance.name
  sku_tier           = var.instance.sku_tier
  sku_name           = var.instance.sku_name
  firewall_policy_id = var.instance.firewall_policy_id
  dns_proxy_enabled  = var.instance.dns_proxy_enabled
  dns_servers        = var.instance.dns_servers
  threat_intel_mode  = var.instance.threat_intel_mode
  private_ip_ranges  = var.instance.private_ip_ranges
  zones              = var.instance.zones

  tags = coalesce(
    var.instance.tags, var.tags
  )

  dynamic "virtual_hub" {
    for_each = lookup(var.instance, "virtual_hub", null) != null ? [var.instance.virtual_hub] : []

    content {
      virtual_hub_id  = virtual_hub.value.virtual_hub_id
      public_ip_count = virtual_hub.value.public_ip_count
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
      subnet_id            = ip_configuration.value.subnet_id
      public_ip_address_id = ip_configuration.value.public_ip_address_id
    }
  }
}
