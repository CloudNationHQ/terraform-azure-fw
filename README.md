# Firewall

This terraform module streamlines the deployment and management of azure firewall, offering customizable rules and configurations for secure and scalable network traffic control.

## Features

Utilization of terratest for robust validation.

Support for multiple IP configurations.

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

- [azurerm_firewall.fw](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_instance"></a> [instance](#input\_instance)

Description: Contains all firewall configuration

Type:

```hcl
object({
    name               = string
    resource_group     = optional(string, null)
    location           = optional(string, null)
    sku_tier           = string
    sku_name           = string
    firewall_policy_id = optional(string, null)
    dns_proxy_enabled  = optional(bool, false)
    dns_servers        = optional(list(string), null)
    threat_intel_mode  = optional(string, null)
    private_ip_ranges  = optional(list(string), null)
    zones              = optional(list(string), null)
    tags               = optional(map(string), null)
    virtual_hub = optional(object({
      virtual_hub_id  = string
      public_ip_count = optional(number, 1)
    }), null)
    management_ip_configuration = optional(object({
      name                 = string
      subnet_id            = string
      public_ip_address_id = string
    }), null)
    ip_configurations = optional(map(object({
      name                 = string
      subnet_id            = optional(string, null)
      public_ip_address_id = optional(string, null)
    })), {})
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_instance"></a> [instance](#output\_instance)

Description: contains firewall configuration

### <a name="output_public_ip_addresses"></a> [public\_ip\_addresses](#output\_public\_ip\_addresses)

Description: public ip addresses associated with the firewall
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-fw/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-fw" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/firewall/)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/firewall/azure-firewalls)
