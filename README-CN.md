Alicloud VPC, VSwitch and Route Entry Terraform Module
terraform-alicloud-vpc
=====================================================================

本 Module，用于创建阿里云 VPC、多个虚拟交换机和配置路由条目。

- 该模块包含一个 VPC、几个交换机和几个自定义路由条目。
- 如果未指定 VPC，则模块将使用默认参数创建一个新资源。
- 虚拟交换机的数量取决于参数 `VSwitch_cidrs` 的数量。
- 自定义路由条目的数量取决于参数 `destination_cidr` 的数量。
- 每个虚拟交换机需要一个可用区。如果 `availability_zones` 的数量小于 `vswitch_cidrs` 的数量，`availability_zones` 将被重复使用。

本 Module 支持创建以下资源:

* [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)
* [VSwitch](https://www.terraform.io/docs/providers/alicloud/r/vswitch.html)
* [Route Entry](https://www.terraform.io/docs/providers/alicloud/r/route_entry.html)

## Terraform 版本

本 Module 要求使用 Terraform 0.13 和 阿里云 Provider 1.56.0+。

## 用法

```hcl
module "vpc" {
  source  = "alibaba/vpc/alicloud"
  region  = "cn-hangzhou"
  profile = "Your-Profile-Name"
    
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

## 示例

* [创建完整 VPC 示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-vpc/tree/master/examples/complete)
* [使用默认 VPC 示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-vpc/tree/master/examples/use-default-vpc)

## 注意事项
本Module从版本v1.9.0开始已经移除掉如下的 provider 的显式设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/vpc"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.8.0:

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

如果你想对正在使用中的Module升级到 1.9.0 或者更高的版本，那么你可以在模板中显式定义一个相同Region的provider：
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
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显式指定这个provider：

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

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)