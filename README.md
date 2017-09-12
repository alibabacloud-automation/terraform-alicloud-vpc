Alicloud VPC, VSwitch and Route Entry Terraform Module
terraform-alicloud-vpc
=========================================

A terraform module to provide an Alicloud VPC, VSwitch and configure route entry for it.

- The module contains one VPC, several VSwitches and several custom route entries.
- If VPC is not specified, the module will launch a new one using its own parameters.
- The number of VSwitch depends on the length of the parameter `vswitch_cidrs`.
- The number of custom route entry depends on the length of the parameter `destination_cidrs`
- If you have no idea availability zones, the module will provide default values according to `cpu_core_count` and `memory_size`.



Module Input Variables
----------------------

The module aim to build a VPC environment. Its input variables contains VPC, VSwitch and Route Entry.

#### Common Input Vairables

- `alicloud_access_key` - The Alicloud Access Key ID to launch resources
- `alicloud_secret_key` - The Alicloud Access Secret Key to launch resources
- `region` - The region to launch resources - default to "cn-hongkong"
- `availability_zones` - List of availability zone IDs to launch several VSwitches in the different zones
                         and its item is "" means the value will be from zones' data source - default to [""]
- `number_format` - The number format used to mark multiple resources - default to "%02d"

#### VPC Input variables

- `vpc_id` - VPC ID to launch a new VSwitch and Security Group
- `vpc_cidr` - VPC CIDR block to launch a new VPC when `vpc_id` is not specified - default to "172.16.0.0/12"
- `vpc_name` - VPC name to mark a new VPC when `vpc_id` is not specified - default to "TF-VPC"
- `vpc_description` - VPC description used to launch a new vpc when 'vpc_id' is not specified - default to "A new VPC created by Terrafrom module tf-alicloud-vpc-cluster"

#### VSwitch Input Variables

- `vswitch_name` - VSwitch name prefix to mark a new VSwitch - default to "TF_VSwitch"
- `vswitch_cidrs` - List of VSwitch CIDR blocks to launch several new VSwitches
- `vswitch_description` - VSwitch description used to describe new vswitch - default to "New VSwitch created by Terrafrom module tf-alicloud-vpc-cluster."


#### Custom Route Entry Input Variables

- `route_table_id` - Route table ID of virtual router in the specified VPC. If `vpc_id` is not specified, you must specify `route_table_id` when to launch new route entries.
- `destination_cidrs` - List of destination CIDR blocks of virtual route table in the specified VPC
- `server_ids` -List of ECS instance IDs as route entry's next hop in the specified VPC


Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


        module "tf-vpc-cluster" {
           source = "github.com/terraform-community-modules/terraform-alicloud-vpc"

           alicloud_access_key = "${var.alicloud_access_key}"
           alicloud_secret_key = "${var.alicloud_secret_key}"

           vpc_name = "my_module_vpc"

           vswitch_name = "my_module_vswitch"
           vswitch_cidr = [
              "172.16.1.0/24",
              "172.16.2.0/24"
           ]

           destination_cidrs = "${var.destination_cidrs}"
           nexthop_ids = "${var.server_ids}"

        }

2. Setting values for the following variables, either through terraform.tfvars or environment variables or -var arguments on the CLI

- alicloud_access_key
- alicloud_secret_key
- destination_cidrs
- server_ids

Module Output Variables
-----------------------

- vpc_id - A new VPC ID
- vswitch_ids - A list of new VSwitch IDs
- router_id - The virtual router ID in which new route entries are launched
- route_table_id - The route table ID in which new route entries are launched

Authors
-------
Created and maintained by He Guimin(@xiaozhu36 heguimin36@163.com)