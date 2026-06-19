# network rule collections
resource "azurerm_firewall_network_rule_collection" "this" {
  for_each = var.collections.network_rule_collections

  name = coalesce(
    each.value.name, each.key
  )

  azure_firewall_name = coalesce(
    lookup(each.value, "azure_firewall_name", null), var.firewall_name
  )

  resource_group_name = coalesce(
    lookup(each.value, "resource_group_name", null), var.resource_group_name
  )

  priority = each.value.priority
  action   = each.value.action

  dynamic "rule" {
    for_each = each.value.rules

    content {
      name = coalesce(
        rule.value.name, rule.key
      )

      description           = rule.value.description
      protocols             = rule.value.protocols
      destination_ports     = rule.value.destination_ports
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      destination_addresses = rule.value.destination_addresses
      destination_ip_groups = rule.value.destination_ip_groups
      destination_fqdns     = rule.value.destination_fqdns
    }
  }
}

# nat rule collections
resource "azurerm_firewall_nat_rule_collection" "this" {
  for_each = var.collections.nat_rule_collections

  # azure serializes write operations against a single firewall; concurrent rule
  # collection changes return 409 AnotherOperationInProgress. chain the collection
  # types so terraform applies them sequentially rather than in parallel.
  depends_on = [azurerm_firewall_network_rule_collection.this]

  name = coalesce(
    each.value.name, each.key
  )

  azure_firewall_name = coalesce(
    lookup(each.value, "azure_firewall_name", null), var.firewall_name
  )

  resource_group_name = coalesce(
    lookup(each.value, "resource_group_name", null), var.resource_group_name
  )

  priority = each.value.priority
  action   = each.value.action

  dynamic "rule" {
    for_each = each.value.rules

    content {
      name = coalesce(
        rule.value.name, rule.key
      )

      description           = rule.value.description
      protocols             = rule.value.protocols
      destination_ports     = rule.value.destination_ports
      destination_addresses = rule.value.destination_addresses
      source_addresses      = rule.value.source_addresses
      source_ip_groups      = rule.value.source_ip_groups
      translated_address    = rule.value.translated_address
      translated_port       = rule.value.translated_port
    }
  }
}

# application rule collections
resource "azurerm_firewall_application_rule_collection" "this" {
  for_each = var.collections.application_rule_collections

  # see note on nat rule collections: serialize against the firewall to avoid 409.
  depends_on = [azurerm_firewall_nat_rule_collection.this]

  name = coalesce(
    each.value.name, each.key
  )

  azure_firewall_name = coalesce(
    lookup(each.value, "azure_firewall_name", null), var.firewall_name
  )

  resource_group_name = coalesce(
    lookup(each.value, "resource_group_name", null), var.resource_group_name
  )

  priority = each.value.priority
  action   = each.value.action

  dynamic "rule" {
    for_each = each.value.rules

    content {
      name = coalesce(
        rule.value.name, rule.key
      )

      description      = rule.value.description
      source_addresses = rule.value.source_addresses
      source_ip_groups = rule.value.source_ip_groups
      target_fqdns     = rule.value.target_fqdns
      fqdn_tags        = rule.value.fqdn_tags

      dynamic "protocol" {
        for_each = rule.value.protocols

        content {
          type = protocol.value.type
          port = protocol.value.port
        }
      }
    }
  }
}
