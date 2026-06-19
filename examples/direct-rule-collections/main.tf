module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.24"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 9.0"

  naming = local.naming

  vnet = {
    name                = module.naming.virtual_network.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    address_space       = ["10.18.0.0/16"]

    subnets = {
      fw1 = {
        name             = "AzureFirewallSubnet"
        address_prefixes = ["10.18.0.0/26"]
      }
    }
  }
}

module "public_ip" {
  source  = "cloudnationhq/pip/azure"
  version = "~> 4.0"

  naming = local.naming

  resource_group_name = module.rg.groups.demo.name
  location            = module.rg.groups.demo.location

  configs = {
    pub1 = {
      name  = module.naming.public_ip.name
      zones = ["1", "2", "3"]
    }
  }
}

module "firewall" {
  source = "../../"

  instance = {
    name                = module.naming.firewall.name
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    sku_name            = "AZFW_VNet"
    sku_tier            = "Standard"

    ip_configurations = {
      pub1 = {
        subnet_id            = module.network.subnets.fw1.id
        public_ip_address_id = module.public_ip.configs.pub1.id
      }
    }
  }
}

module "direct_rule_collections" {
  source  = "cloudnationhq/fw/azure//modules/direct-rule-collections"
  version = "~> 3.0"

  firewall_name       = module.firewall.instance.name
  resource_group_name = module.rg.groups.demo.name

  collections = local.collections
}
