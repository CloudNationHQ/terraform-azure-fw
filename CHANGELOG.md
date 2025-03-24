# Changelog

## [2.5.0](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v2.4.0...v2.5.0) (2025-03-24)


### Features

* **deps:** bump golang.org/x/net from 0.34.0 to 0.36.0 in /tests ([#30](https://github.com/CloudNationHQ/terraform-azure-fw/issues/30)) ([3f4ee52](https://github.com/CloudNationHQ/terraform-azure-fw/commit/3f4ee527222774791c6a0548a7c51b2d63e83c9d))
* format documentation to include type definitions ([#31](https://github.com/CloudNationHQ/terraform-azure-fw/issues/31)) ([751d735](https://github.com/CloudNationHQ/terraform-azure-fw/commit/751d7355a6b13279508af6423ba01a5d2f2039d9))

## [2.4.0](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v2.3.0...v2.4.0) (2025-02-24)


### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#25](https://github.com/CloudNationHQ/terraform-azure-fw/issues/25)) ([cf68fcc](https://github.com/CloudNationHQ/terraform-azure-fw/commit/cf68fccb97117a4f07406bdba5f18057d670b8c5))


### Bug Fixes

* fix output to use public_ip_address_id for AZFW_VNet sku and revise complete example ([#27](https://github.com/CloudNationHQ/terraform-azure-fw/issues/27)) ([9d2b2ea](https://github.com/CloudNationHQ/terraform-azure-fw/commit/9d2b2ea894d98266c7a87812bde15df015917fee))

## [2.3.0](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v2.2.0...v2.3.0) (2025-01-20)


### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#20](https://github.com/CloudNationHQ/terraform-azure-fw/issues/20)) ([dcd91c8](https://github.com/CloudNationHQ/terraform-azure-fw/commit/dcd91c8c3e70836dfb9ab243c449a1de1ebc328a))
* **deps:** bump golang.org/x/net from 0.31.0 to 0.33.0 in /tests ([#23](https://github.com/CloudNationHQ/terraform-azure-fw/issues/23)) ([da4c6d8](https://github.com/CloudNationHQ/terraform-azure-fw/commit/da4c6d8c5d6e372d448d8b01a8340b83aa3fc657))
* remove temporary files when deployment tests fails ([#21](https://github.com/CloudNationHQ/terraform-azure-fw/issues/21)) ([573f27f](https://github.com/CloudNationHQ/terraform-azure-fw/commit/573f27fdc2d4e46e93e0e7a5e2116e52316b4f0a))

## [2.2.0](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v2.1.0...v2.2.0) (2024-11-11)


### Features

* enhance testing with sequential, parallel modes and flags for exceptions and skip-destroy ([#17](https://github.com/CloudNationHQ/terraform-azure-fw/issues/17)) ([c4c0f83](https://github.com/CloudNationHQ/terraform-azure-fw/commit/c4c0f83fb6aacd84eb3b85cfd86d1dbfee55bd5d))

## [2.1.0](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v2.0.0...v2.1.0) (2024-10-11)


### Features

* auto generated docs and refine makefile ([#15](https://github.com/CloudNationHQ/terraform-azure-fw/issues/15)) ([043661a](https://github.com/CloudNationHQ/terraform-azure-fw/commit/043661ae199951e207c384cd44f33c8606deca89))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#14](https://github.com/CloudNationHQ/terraform-azure-fw/issues/14)) ([ff7a7bc](https://github.com/CloudNationHQ/terraform-azure-fw/commit/ff7a7bc151cd12b49fb3358fad5d3a7b9ee5b041))

## [2.0.0](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v1.0.3...v2.0.0) (2024-09-24)


### ⚠ BREAKING CHANGES

* Version 4 of the azurerm provider includes breaking changes.

### Features

* upgrade azurerm provider to v4 ([#12](https://github.com/CloudNationHQ/terraform-azure-fw/issues/12)) ([f7fbb98](https://github.com/CloudNationHQ/terraform-azure-fw/commit/f7fbb98c2798336402676f626a3180879aff972f))

### Upgrade from v1.0.3 to v2.0.0:

- Update module reference to: `version = "~> 2.0"`

## [1.0.3](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v1.0.2...v1.0.3) (2024-09-18)


### Bug Fixes

* add public ip addresses output ([#10](https://github.com/CloudNationHQ/terraform-azure-fw/issues/10)) ([741fdc9](https://github.com/CloudNationHQ/terraform-azure-fw/commit/741fdc923c06c0ff2324eded82740e8a9dfc6f93))

## [1.0.2](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v1.0.1...v1.0.2) (2024-09-17)


### Bug Fixes

* remove redundant provider block ([#6](https://github.com/CloudNationHQ/terraform-azure-fw/issues/6)) ([d79d487](https://github.com/CloudNationHQ/terraform-azure-fw/commit/d79d4874329ec9bb342da4e975cad9dd2f86f86d))

## [1.0.1](https://github.com/CloudNationHQ/terraform-azure-fw/compare/v1.0.0...v1.0.1) (2024-09-17)


### Bug Fixes

* set default threat intelligence mode to null instead of alert ([#4](https://github.com/CloudNationHQ/terraform-azure-fw/issues/4)) ([5d07f9a](https://github.com/CloudNationHQ/terraform-azure-fw/commit/5d07f9ae47b2477e4a0694b9dad69359903860f5))

## 1.0.0 (2024-09-12)


### Features

* add initial resources ([#2](https://github.com/CloudNationHQ/terraform-azure-fw/issues/2)) ([50ff1f8](https://github.com/CloudNationHQ/terraform-azure-fw/commit/50ff1f8eb026fd82e5ce7f3aa54f7d574bb44a71))
