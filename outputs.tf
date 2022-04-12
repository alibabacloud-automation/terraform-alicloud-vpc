# Output the IDs of the ECS instances created
output "vpc_id" {
  description = "Deprecated and use this_vpc_id instead"
  value       = local.this_vpc_id
}

output "cidr_block" {
  description = "Deprecated and use this_vpc_cidr_block instead"
  value       = concat(alicloud_vpc.vpc.*.cidr_block, [""])[0]
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
  description = "The VPC id"
  value       = local.this_vpc_id
}

output "this_vpc_name" {
  description = "The VPC name"
  value       = local.this_vpc_name
}

output "this_vpc_cidr_block" {
  description = "The VPC cidr block"
  value       = local.this_vpc_cidr_block
}

output "this_vpc_tags" {
  description = "The VPC tags"
  value       = concat(alicloud_vpc.vpc.*.tags, [{}])[0]
}

output "this_resource_group_id" {
  description = "The Id of resource group which the instance belongs."
  value       = concat(alicloud_vpc.vpc.*.resource_group_id, [""])[0]
}

output "this_vswitch_ids" {
  description = "List of vswitch ids"
  value       = alicloud_vswitch.vswitches.*.id
}

output "this_vswitch_names" {
  description = "List of vswitch names"
  value       = alicloud_vswitch.vswitches.*.name
}

output "this_vswitch_cidr_blocks" {
  description = "The vswitch cidr block"
  value       = alicloud_vswitch.vswitches.*.cidr_block
}

output "this_vswitch_tags" {
  description = "List of vswitch tags."
  value       = alicloud_vswitch.vswitches.*.tags
}

output "this_availability_zones" {
  description = "List of availability zones in which vswitches launched."
  value       = alicloud_vswitch.vswitches.*.availability_zone
}

output "this_route_table_id" {
  description = "The vpc route table id."
  value       = local.route_table_id
}

output "this_router_id" {
  description = "The vpc router id."
  value       = concat(alicloud_route_entry.route_entry.*.router_id, [""])[0]
}