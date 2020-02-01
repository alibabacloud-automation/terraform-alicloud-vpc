# VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.this_vpc_id
}

output "vpc_tags" {
  description = "The tags of the VPC"
  value       = module.vpc.this_vpc_tags
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