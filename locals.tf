locals {
  route_table_id = var.vpc_id == "" ? concat(alicloud_vpc.vpc.*.route_table_id, [""])[0] : data.alicloud_route_tables.this.ids.0

  # Get ID of created Security Group
  this_vpc_id = var.vpc_id != "" ? var.vpc_id : concat(alicloud_vpc.vpc.*.id, [""])[0]
  # Whether to create other resources in which the vpc
  create_sub_resources = var.vpc_id != "" || var.create ? true : false
  this_vpc_cidr_block  = var.vpc_cidr != "" ? var.vpc_cidr : data.alicloud_vpcs.this.cidr_block
  this_vpc_name = var.vpc_name != "" ? var.vpc_name : data.alicloud_vpcs.this.names.0
}

data "alicloud_route_tables" "this" {
  vpc_id = var.vpc_id
}

data "alicloud_vpcs" "this" {
  ids = var.vpc_id != "" ? [var.vpc_id] : null
}