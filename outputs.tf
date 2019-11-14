// Output the IDs of the ECS instances created
output "vpc_id" {
  value = var.vpc_id == "" ? alicloud_vpc.vpc.*.id[0] : var.vpc_id
}

output "cidr_block" {
  value = alicloud_vpc.vpc.*.cidr_block[0]
}

output "vswitch_ids" {
  value = alicloud_vswitch.vswitches.*.id
}

output "availability_zones" {
  value = alicloud_vswitch.vswitches.*.availability_zone
}

output "router_id" {
  value = alicloud_route_entry.route_entry.*.router_id
}

output "route_table_id" {
  value = alicloud_route_entry.route_entry.*.route_table_id
}
