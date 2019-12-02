// Output the IDs of the ECS instances created
output "vpc_id" {
  description = "Deprecated and use this_vpc_id instead"
  value       = local.vpc_id == "" ? alicloud_vpc.vpc.0.id : local.vpc_id
}

output "cidr_block" {
  description = "Deprecated and use this_vpc_cidr_block instead"
  value       = alicloud_vpc.vpc.0.cidr_block
}

output "vswitch_ids" {
  description = "Deprecated and use this_vswitch_ids instead"
  value       = alicloud_vswitch.vswitches.*.id
}

output "availability_zones" {
  description = "Deprecated and use this_availability_zones instead"
  value       = alicloud_vswitch.vswitches.*.availability_zone
}

output "router_id" {
  description = "Deprecated and use this_router_id instead"
  value       = alicloud_route_entry.route_entry.*.router_id
}

output "route_table_id" {
  description = "Deprecated and use this_route_table_id instead"
  value       = alicloud_route_entry.route_entry.*.route_table_id
}

output "this_vpc_id" {
  value = local.vpc_id == "" ? alicloud_vpc.vpc.0.id : local.vpc_id
}

output "this_vpc_cidr_block" {
  value = alicloud_vpc.vpc.0.cidr_block
}

output "this_vswitch_ids" {
  value = alicloud_vswitch.vswitches.*.id
}

output "this_availability_zones" {
  value = alicloud_vswitch.vswitches.*.availability_zone
}

output "this_route_table_id" {
  value = local.route_table_id
}
output "this_router_id" {
  value = alicloud_route_entry.route_entry.0.router_id
}