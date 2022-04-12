Alicloud VPC, VSwitch and Route Entry Terraform Module
terraform-alicloud-vpc
=========================================

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-vpc/blob/master/README-CN.md)

A terraform module used to create an Alibaba Cloud VPC, several VSwitches and configure route entry.

- The module contains one VPC, several VSwitches and several custom route entries.
- If VPC is not specified, the module will launch a new one using default parameters.
- The number of VSwitch depends on the length of the parameter `vswitch_cidrs`.
- The number of custom route entry depends on the length of the parameter `destination_cidrs`
- Each VSwitch needs an availability zone. If the length of `availability_zones` is less than the length of `vswitch_cidrs`, `availability_zones` item will be used repeatedly.

The following resources are supported:

* [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)
* [VSwitch](https://www.terraform.io/docs/providers/alicloud/r/vswitch.html)
* [Route Entry](https://www.terraform.io/docs/providers/alicloud/r/route_entry.html)

Usage
-----

```hcl
module "vpc" {
  source  = "alibaba/vpc/alicloud"

  create            = true
  vpc_name          = "my-env-vpc"
  vpc_cidr          = "10.10.0.0/16"
  resource_group_id = "rg-acfmwvvtg5o****"

  availability_zones = ["cn-hangzhou-e", "cn-hangzhou-f", "cn-hangzhou-g"]
  vswitch_cidrs      = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]

  vpc_tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "complete"
  }

  vswitch_tags = {
    Project  = "Secret"
    Endpoint = "true"
  }

  destination_cidrs = var.destination_cidrs
  nexthop_ids       = var.server_ids
}
```

## Examples

* [Complete VPC example](https://github.com/terraform-alicloud-modules/terraform-alicloud-vpc/tree/master/examples/complete)
* [Use Default VPC example](https://github.com/terraform-alicloud-modules/terraform-alicloud-vpc/tree/master/examples/use-default-vpc)

## Notes
From the version v1.9.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/vpc"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.8.0:

```hcl
module "vpc" {
  source  = "alibaba/vpc/alicloud"

  version     = "1.8.0"
  region      = "cn-hangzhou"
  profile     = "Your-Profile-Name"

  create            = true
  vpc_name          = "my-env-vpc"
  // ...
}
```

If you want to upgrade the module to 1.9.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
}
module "vpc" {
  source  = "alibaba/vpc/alicloud"

  create            = true
  vpc_name          = "my-env-vpc"
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  alias   = "hz"
}

module "vpc" {
  source  = "alibaba/vpc/alicloud"

  providers = {
    alicloud = alicloud.hz
  }

  create            = true
  vpc_name          = "my-env-vpc"
  // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Submit Issues
-------------
If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)