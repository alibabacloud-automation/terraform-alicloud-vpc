locals {
  vpc_id         = var.vpc_id != "" ? var.vpc_id : var.vpc_name_regex != "" || length(var.vpc_tags) > 0 ? data.alicloud_vpcs.this.ids.0 : ""
  route_table_id = local.vpc_id == "" ? alicloud_vpc.vpc[0].route_table_id : data.alicloud_route_tables.this.ids.0
}

data "alicloud_vpcs" "this" {
  name_regex = var.vpc_name_regex
  tags       = var.vpc_tags
}
data "alicloud_route_tables" "this" {
  vpc_id = local.vpc_id
}