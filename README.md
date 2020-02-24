Alicloud VPC, VSwitch and Route Entry Terraform Module   
terraform-alicloud-vpc
=========================================

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

## Terraform versions

For Terraform 0.12 use this module and Terraform Provider AliCloud 1.56.0+.

Usage
-----

```hcl
module "vpc" {
  source  = "alibaba/vpc/alicloud"
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
  
  create   = true
  vpc_name = "my-env-vpc"
  vpc_cidr = "10.10.0.0/16"

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
**NOTE:** This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

## Examples

* [Complete VPC example](https://github.com/terraform-alicloud-modules/terraform-alicloud-vpc/tree/master/examples/complete)
* [Use Default VPC example](https://github.com/terraform-alicloud-modules/terraform-alicloud-vpc/tree/master/examples/use-default-vpc)

Submit Issues
-------------

If you have any problems when using this module, please opening a [provider issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new) and let us know.

**Note:** There does not recommend to open an issue on this repo.

Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

