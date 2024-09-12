module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 1.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name
      location = "westeurope"
    }
  }
}


module "network" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 3.0"

  naming = local.naming

  vnet = {
    name           = module.naming.virtual_network.name
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
    cidr           = ["10.18.0.0/16"]

    subnets = {
      fw1 = {
        name = "AzureFirewallSubnet"
        cidr = ["10.18.0.0/26"]
      }
    }
  }
}

module "public_ips" {
  source  = "cloudnationhq/pip/azure"
  version = "~> 1.0"

  naming = local.naming

  resource_group = module.rg.groups.demo.name
  location       = module.rg.groups.demo.location

  configs = {
    pub1 = {
      name  = "${module.naming.public_ip.name}1"
      zones = ["1", "2", "3"]
      prefix = {
        prefix_length = 31
      }
    }
    pub2 = {
      name  = "${module.naming.public_ip.name}2"
      zones = ["1", "2", "3"]
      prefix = {
        prefix_length = 31
      }
    }
  }
}

module "firewall" {
  source  = "cloudnationhq/fw/azure"
  version = "~> 1.0"

  instance = {
    name              = module.naming.firewall.name
    resource_group    = module.rg.groups.demo.name
    location          = module.rg.groups.demo.location
    sku_name          = "AZFW_VNet"
    sku_tier          = "Standard"
    dns_servers       = ["168.63.129.16"]
    dns_proxy_enabled = true
    threat_intel_mode = "Alert"

    ip_configurations = {
      ipconfig1 = {
        name                 = "ipconfig1"
        subnet_id            = module.network.subnets.fw1.id
        public_ip_address_id = module.public_ips.configs.pub1.id
      }

      ipconfig2 = {
        name                 = "ipconfig2"
        public_ip_address_id = module.public_ips.configs.pub2.id
      }
    }
  }
}
