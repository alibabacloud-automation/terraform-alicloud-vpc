Alicloud VPC, VSwitch and Route Entry Terraform Module
terraform-alicloud-vpc
=========================================

A terraform module to provide an Alicloud VPC, VSwitch and configure route entry for it.

- The module contains one VPC, several VSwitches and several custom route entries.
- If VPC is not specified, the module will launch a new one using its own parameters.
- The number of VSwitch depends on the length of the parameter `vswitch_cidrs`.
- The number of custom route entry depends on the length of the parameter `destination_cidrs`
- If you have no idea availability zones, the module will provide default values according to `cpu_core_count` and `memory_size`.

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


        module "tf-vpc-cluster" {
           source = "alibaba/vpc/alicloud"

           vpc_name = "my_module_vpc"

           vswitch_name = "my_module_vswitch"
           vswitch_cidrs = [
              "172.16.1.0/24",
              "172.16.2.0/24"
           ]

           destination_cidrs = "${var.destination_cidrs}"
           nexthop_ids = "${var.server_ids}"

        }

2. Setting values for the following variables:

    through environment variables

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY

    and, either through terraform.tfvars or -var arguments on the CLI

    - destination_cidrs
    - server_ids

Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

