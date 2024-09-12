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
      fw = {
        name = "AzureFirewallSubnet"
        cidr = ["10.18.0.0/26"]
      }
      fwmgmt = {
        name = "AzureFirewallManagementSubnet"
        cidr = ["10.18.0.64/26"]
      }
    }
  }
}

module "public_ips" {
  source  = "cloudnationhq/pip/azure"
  version = "~> 1.0"

  configs = {
    name           = module.naming.public_ip.name
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name

    zones = ["1", "2", "3"]
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
    private_ip_ranges = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
    zones             = [1, 2, 3]

    ip_configurations = {
      ipconfig1 = {
        name      = "config"
        subnet_id = module.network.subnets.fw.id
      }
    }

    management_ip_configuration = {
      name                 = "config_mgt"
      subnet_id            = module.network.subnets.fwmgmt.id
      public_ip_address_id = module.public_ip.configs.id
    }
  }
}
