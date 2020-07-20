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

本 Module 要求使用 Terraform 0.12 和 阿里云 Provider 1.56.0+。

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

* 本 Module 使用的 AccessKey 和 SecretKey 可以直接从 `profile` 和 `shared_credentials_file` 中获取。如果未设置，可通过下载安装 [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) 后进行配置。

提交问题
-------
如果在使用该 Terraform Module 的过程中有任何问题，可以直接创建一个 [Provider Issue](https://github.com/terraform-providers/terraform-provider-alicloud/issues/new)，我们将根据问题描述提供解决方案。

**注意:** 不建议在该 Module 仓库中直接提交 Issue。

作者
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)