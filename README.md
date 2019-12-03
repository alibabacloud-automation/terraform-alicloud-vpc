Alicloud VPC, VSwitch and Route Entry Terraform Module
terraform-alicloud-vpc
=========================================

A terraform module used to create an Alibaba Cloud VPC, several VSwitches and configure route entry.

- The module contains one VPC, several VSwitches and several custom route entries.
- If VPC is not specified, the module will retrieve existing VPC or launch a new one using default parameters.
- The number of VSwitch depends on the length of the parameter `vswitch_cidrs`.
- The number of custom route entry depends on the length of the parameter `destination_cidrs`
- Each VSwitch needs an availability zone. If there is no values in the parameter `availability_zones`, data source `alicloud_zones` will retrieve them automatically.

The following resources are supported:

* [VPC](https://www.terraform.io/docs/providers/alicloud/r/vpc.html)
* [VSwitch](https://www.terraform.io/docs/providers/alicloud/r/vswitch.html)
* [Route Entry](https://www.terraform.io/docs/providers/alicloud/r/route_entry.html)

Usage
-----

```hcl
module "vpc" {
  source = "alibaba/vpc/alicloud"

  vpc_name     = "my_module_vpc"
  vswitch_name = "my_module_vswitch"
  vswitch_cidrs = [
    "172.16.1.0/24",
    "172.16.2.0/24"
  ]

  destination_cidrs = var.destination_cidrs
  nexthop_ids       = var.server_ids
}
```
**NOTE:** This module using AccessKey and SecretKey are from `profile` and `shared_credentials_file`.
If you have not set them yet, please install [aliyun-cli](https://github.com/aliyun/aliyun-cli#installation) and configure it.

## Conditional Creation

This moudle can retrieve existing VPC to meet more scenarios.

1. Specify the VPC id:  

    ```hcl
    vpc_id = "existing-vpc-id"
    ```
    
2. Retrieve the existing VPC by name or tags: 
 
    ```hcl
    vpc_name_regex = "existing-vpc-name-regex"
    vpc_tags       = {
      created_by = "TF"
      usage = "ecs"
    }
    ```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region  | The region ID used to launch this module resources. If not set, it will be sourced from followed by ALICLOUD_REGION environment variable and profile | string  | ''  | no  |
| profile  | The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable. | string  | ''  | no  |
| shared_credentials_file  | This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used. | string  | ''  | no  |
| skip_region_validation  | Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet). | bool  | false | no  |
| vpc_id  | Specifying existing VPC ID. If not set, the existing VPC will be retrieved by `vpc_name_regex` and `vpc_tags` or a new one will be created named with `vpc_name`.  | string  | ''  | no  |
| vpc_name  | The name for a new VPC | string  | 'TF-VPC'  | no  |
| vpc_description  | The vpc description used to launch a new vpc when 'vpc_id' is not specified | string  | See variables.tf  | no  |
| vpc_name_regex  | A default filter applied to retrieve existing VPC by name regex | string  | ""  | no  |
| vpc_tags  | A default filter applied to retrieve existing VPC by tags | map(string)  | {}  | no  |
| availability_zones | List available zones to launch several VSwitches. If not set, data source `alicloud_zones` will retrieve them automatically  | string  | []  | no  |
| vswitch_cidrs  | List of cidr blocks used to launch several new vswitches | list  | []  | yes  |
| vswitch_name  | The vswitch name prefix used to launch several new vswitch  | string  | "TF-VSwitch"  | no  |
| vswitch_description  | The vswitch description used to launch several new vswitch | string  | See variables.tf | no  |
| destination_cidrs  | List of destination CIDR block of virtual router in the specified VPC  | list  | []  | no  |
| nexthop_ids  | List of next hop instance IDs of virtual router in the specified VPC | list  |[]| no |

## Outputs

| Name | Description |
|------|-------------|
| this_vpc_id  | The ID of VPC  |
| this_vpc_cidr_block  | The Cidr block of VPC  |
| this_vswitch_ids  | The IDs of VSwitches  |
| this_availability_zones  | The availability zones of VSwitches  |
| this_route_table_id  | The route table ID of the VPC  |
| this_router_id  | The Router ID of the VPC  |

Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

