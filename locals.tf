locals {
  route_table_id = var.vpc_id == "" ? concat(alicloud_vpc.vpc.*.route_table_id, [""])[0] : data.alicloud_route_tables.this.ids.0

  # Get ID of created Security Group
  this_vpc_id = var.vpc_id != "" ? var.vpc_id : concat(alicloud_vpc.vpc.*.id, [""])[0]
  # Whether to create other resources in which the vpc
  create_sub_resources = var.vpc_id != "" || var.create ? true : false
}

data "alicloud_route_tables" "this" {
  vpc_id = var.vpc_id
}