module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.32"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}


module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 10.0"


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

module "public_ips" {
  source  = "cloudnationhq/pip/azure"
  version = "~> 5.0"

  resource_group_name = module.rg.groups.demo.name
  location            = module.rg.groups.demo.location

  public_ips = {
    pub1 = {
      name  = "${module.naming.public_ip.name}1"
      zones = ["1", "2", "3"]
    }
    pub2 = {
      name  = "${module.naming.public_ip.name}2"
      zones = ["1", "2", "3"]
    }
  }
}

module "firewall" {
  source  = "cloudnationhq/fw/azure"
  version = "~> 4.0"

  firewall = {
    name                = module.naming.firewall.name
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    sku_name            = "AZFW_VNet"
    sku_tier            = "Standard"
    dns_servers         = ["168.63.129.16"]
    dns_proxy_enabled   = true
    threat_intel_mode   = "Alert"

    ip_configurations = {
      pub1 = {
        subnet_id            = module.network.subnets.fw1.id
        public_ip_address_id = module.public_ips.public_ips.pub1.id
      }

      pub2 = {
        public_ip_address_id = module.public_ips.public_ips.pub2.id
      }
    }
  }
}
