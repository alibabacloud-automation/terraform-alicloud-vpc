locals {
  route_table_id = var.vpc_id == "" ? concat(alicloud_vpc.vpc.*.route_table_id, [""])[0] : data.alicloud_route_tables.this.ids.0

  # Get ID of created Security Group
  this_vpc_id = var.vpc_id != "" ? var.vpc_id : concat(alicloud_vpc.vpc.*.id, [""])[0]
  # Whether to create other resources in which the vpc
  create_sub_resources = var.vpc_id != "" || var.create ? true : false
  this_vpc_cidr_block  = local.this_vpc_id == "" ? "" : concat(data.alicloud_vpcs.this.vpcs.*.cidr_block, [""])[0]
  this_vpc_name        = local.this_vpc_id == "" ? "" : concat(data.alicloud_vpcs.this.vpcs.*.vpc_name, [""])[0]
}

data "alicloud_route_tables" "this" {
  vpc_id = local.this_vpc_id
}

data "alicloud_vpcs" "this" {
  ids = var.vpc_id != "" ? [var.vpc_id] : null
}