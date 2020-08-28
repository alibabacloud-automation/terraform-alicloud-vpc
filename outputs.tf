output "vpc_id" {
  description = "The VPC identifier"
  value       = local.vpc_id
}

output "vpc_cidr_block" {
  description = "The VPC CIDR Block"
  value       = concat(alicloud_vpc.this.*.cidr_block, [""])[0]
}

output "vpc_name" {
  description = "The VPC name assigned"
  value       = concat(alicloud_vpc.this.*.name, [""])[0]
}

output "vpc_tags" {
  description = "The VPC tags assigned"
  value       = concat(alicloud_vpc.this.*.tags, [{}])[0]
}

output "resource_group_id" {
  description = "The identifier of resource group which the VPC belongs"
  value       = concat(alicloud_vpc.this.*.resource_group_id, [""])[0]
}

output "nat_gateway_id" {
  description = "The NAT Gateway Identifier if created"
  value       = concat(alicloud_nat_gateway.this.*.id, [""])[0]
}

output "nat_gateway_eips_ids" {
  description = "The EIPs associated to the NAT Gateway"
  value       = concat(alicloud_eip.nat.*.id, [""])[0]
}

output "nat_gateway_snat_table_id" {
  description = "The SNAT table of the NAT Gateway"
  value       = concat(alicloud_nat_gateway.this.*.snat_table_ids, [""])[0]
}

output "nat_gateway_dnat_table_id" {
  description = "The DNAT table of the NAT Gateway"
  value       = concat(alicloud_nat_gateway.this.*.forward_table_ids, [""])[0]
}

output "vswitches_ids" {
  description = "List of vswitch identifiers created by the module"
  value       = [for value in alicloud_vswitch.this : value.id]
}

output "vswitches" {
  description = "List of vswitches created by the module"
  value       = [for value in alicloud_vswitch.this : value]
}

