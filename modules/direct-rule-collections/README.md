# Direct Rule Collections

This submodule manages the classic (non-policy) azure firewall rule collections that attach directly to a VNet-deployed firewall: network, nat and application rule collections.

## Notes

These rule collection resources are only valid for VNet-deployed firewalls (`AZFW_VNet`), not for VWAN (`AZFW_Hub`) deployments. For firewalls managed through a firewall policy, use the firewall policy module instead.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_firewall_application_rule_collection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_application_rule_collection) (resource)
- [azurerm_firewall_nat_rule_collection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_nat_rule_collection) (resource)
- [azurerm_firewall_network_rule_collection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_network_rule_collection) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_collections"></a> [collections](#input\_collections)

Description: Contains all classic (non-policy) firewall rule collections config

Type:

```hcl
object({
    network_rule_collections = optional(map(object({
      name                = optional(string)
      azure_firewall_name = optional(string)
      resource_group_name = optional(string)
      priority            = number
      action              = string
      rules = map(object({
        name                  = optional(string)
        description           = optional(string)
        protocols             = list(string)
        destination_ports     = list(string)
        source_addresses      = optional(list(string), [])
        source_ip_groups      = optional(list(string), [])
        destination_addresses = optional(list(string), [])
        destination_ip_groups = optional(list(string), [])
        destination_fqdns     = optional(list(string), [])
      }))
    })), {})
    nat_rule_collections = optional(map(object({
      name                = optional(string)
      azure_firewall_name = optional(string)
      resource_group_name = optional(string)
      priority            = number
      action              = string
      rules = map(object({
        name                  = optional(string)
        description           = optional(string)
        protocols             = list(string)
        destination_ports     = optional(list(string))
        destination_addresses = optional(list(string))
        source_addresses      = optional(list(string))
        source_ip_groups      = optional(list(string))
        translated_address    = optional(string)
        translated_port       = optional(string)
      }))
    })), {})
    application_rule_collections = optional(map(object({
      name                = optional(string)
      azure_firewall_name = optional(string)
      resource_group_name = optional(string)
      priority            = number
      action              = string
      rules = map(object({
        name             = optional(string)
        description      = optional(string)
        source_addresses = optional(list(string))
        source_ip_groups = optional(list(string))
        target_fqdns     = optional(list(string))
        fqdn_tags        = optional(list(string))
        protocols = optional(list(object({
          type = string
          port = number
        })), [])
      }))
    })), {})
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_firewall_name"></a> [firewall\_name](#input\_firewall\_name)

Description: The name of the Azure Firewall to which the rule collections will be applied.

Type: `string`

Default: `null`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The name of the resource group in which the firewall exists.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_application_rule_collections"></a> [application\_rule\_collections](#output\_application\_rule\_collections)

Description: contains all application rule collections

### <a name="output_nat_rule_collections"></a> [nat\_rule\_collections](#output\_nat\_rule\_collections)

Description: contains all nat rule collections

### <a name="output_network_rule_collections"></a> [network\_rule\_collections](#output\_network\_rule\_collections)

Description: contains all network rule collections
<!-- END_TF_DOCS -->
