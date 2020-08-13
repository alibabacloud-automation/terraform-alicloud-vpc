// Output the IDs of the ECS instances created

output "vpc_id" {
  description = "The VPC ID"
  value       = local.vpc_id
}

output "cidr_block" {
  description = "Deprecated and use this_vpc_cidr_block instead"
  value       = concat(alicloud_vpc.vpc.*.cidr_block, [""])[0]
}

output "vpc_name" {
  description = "The VPC name"
  value       = concat(alicloud_vpc.vpc.*.name, [""])[0]
}

output "vpc_tags" {
  description = "The VPC tags"
  value       = concat(alicloud_vpc.vpc.*.tags, [{}])[0]
}

output "resource_group_id" {
  description = "The Id of resource group which the instance belongs."
  value       = concat(alicloud_vpc.vpc.*.resource_group_id, [])[0]
}

output "nat_gateway_id" {
  description = "The Id of resource group which the instance belongs."
  value       = concat(alicloud_nat_gateway.default.*.id, [])[0]
}

output "nat_gateway_snat_table_ids" {
  description = "The Id of resource group which the instance belongs."
  value       = concat(alicloud_nat_gateway.default.*.snat_table_ids, [])[0]
}

output "vswitches_ids" {
  description = "List of vswitch ids"
  value       = [for value in alicloud_vswitch.vswitch : value.id]
}

/* convert in complex type ?
output "vswitch_names" {
  description = "List of vswitch names"
  value       = [for value in alicloud_vswitch.vswitch: value.name]
}

output "vswitch_cidr_blocks" {
  description = "The vswitch cidr block"
  value       = [for value in alicloud_vswitch.vswitch: value.cidr_block]
}

output "vswitch_tags" {
  description = "List of vswitch tags."
  value       = [for value in alicloud_vswitch.vswitch: value.tags]
}

output "this_availability_zones" {
  description = "List of availability zones in which vswitches launched."
  value       = alicloud_vswitch.vswitches.*.availability_zone
}
*/
