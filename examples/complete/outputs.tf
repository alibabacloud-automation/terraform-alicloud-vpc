# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.this_vpc_id
}

output "vpc_cidr_block" {
  description = "The VPC cidr block"
  value       = module.vpc.this_vpc_cidr_block
}

output "vpc_tags" {
  description = "The tags of the VPC"
  value       = module.vpc.this_vpc_tags
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = module.vpc.this_vpc_name
}

output "this_resource_group_id" {
  description = "The Id of resource group which the instance belongs."
  value       = module.vpc.this_resource_group_id
}

# Subnets
output "vswitch_ids" {
  description = "List of IDs of vswitch"
  value       = module.vpc.this_vswitch_ids
}
output "vswitch_tags" {
  description = "List of IDs of vswitch"
  value       = module.vpc.this_vswitch_tags
}

output "vswitch_cidr_block" {
  description = "The vswitch cidr block"
  value       = module.vpc.this_vswitch_cidr_blocks
}

output "vswitch_name" {
  description = "The name of vswitch"
  value       = module.vpc.this_vswitch_names
}