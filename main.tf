# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12.6 syntax, which means it is no longer compatible with any versions below 0.12.6
# ----------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12.6"
}

locals {
  vpc_id = var.create_vpc ? alicloud_vpc.this[0].id : var.vpc_id
}

provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/vpc"
}

resource "alicloud_vpc" "this" {
  count             = var.create_vpc ? 1 : 0
  name              = var.vpc_name
  cidr_block        = var.vpc_cidr
  resource_group_id = var.resource_group_id
  description       = var.vpc_description
  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.tags,
    var.vpc_tags
  )
}


# ---------------------------------------------------------------------------------------------------------------------
# LAUNCH THE NAT GATEWAY
# A NAT Gateway enables instances in the private subnet to connect to the Internet or other Alibaba services, but prevents
# the Internet from initiating a connection to those instances.
# See https://www.alibabacloud.com/product/nat
# ---------------------------------------------------------------------------------------------------------------------

resource "alicloud_nat_gateway" "this" {
  count         = var.create_nat_gateway ? 1 : 0
  vpc_id        = local.vpc_id
  name          = var.vpc_name
  specification = var.nat_gateway_specification
}

# create one or more eips for NAT GW
resource "alicloud_eip" "nat" {
  name      = var.vpc_name
  count     = var.create_nat_gateway && var.nat_gateway_num_eips > 0 ? var.nat_gateway_num_eips : 0
  bandwidth = var.nat_eip_bandwidth
  tags      = var.tags
}

# attach eips to nat gateway
resource "alicloud_eip_association" "nat" {
  count         = var.create_nat_gateway && var.nat_gateway_num_eips > 0 ? var.nat_gateway_num_eips : 0
  allocation_id = alicloud_eip.nat[count.index].id
  instance_id   = alicloud_nat_gateway.this[0].id
}

# ---------------------------------------------------------------------------------------------------------------------
#  VSwitch
# ---------------------------------------------------------------------------------------------------------------------
resource "alicloud_vswitch" "this" {
  for_each          = var.vswitches
  vpc_id            = local.vpc_id
  name              = each.value.name
  availability_zone = each.value.availability_zone
  cidr_block        = each.value.cidr_block
  description       = each.value.description

  tags = merge(
    {
      Name = format(
        "%s",
        "${each.value.name}"
      )
    },
    var.tags,
    var.vswitches_tags,
  )

}

# Create a dedicated Route Table for vswitches
# Alibaba has no notion of Internet Gateway, it may be necessary to add custom routes for certain VSwitches
resource "alicloud_route_table" "this" {
  count       = length(var.vswitches) > 0 ? 1 : 0
  vpc_id      = local.vpc_id
  name        = var.route_table_name
  description = var.route_table_description
  tags        = var.tags
}

# Associate each vswitch with the route table
resource "alicloud_route_table_attachment" "this" {
  for_each       = alicloud_vswitch.this
  vswitch_id     = each.value.id
  route_table_id = alicloud_route_table.this.0.id
}

resource "alicloud_route_entry" "this" {
  for_each              = var.custom_routes
  route_table_id        = alicloud_route_table.this[0].id
  destination_cidrblock = each.value.destination_cidrblock
  nexthop_type          = each.value.nexthop_type
  nexthop_id            = each.value.nexthop_id
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE CEN Grant
# Grant access to CEN
# ---------------------------------------------------------------------------------------------------------------------
resource "alicloud_cen_instance_grant" "this" {
  count             = var.cen_enabled ? 1 : 0
  cen_id            = var.cen_id
  cen_owner_id      = var.cen_owner_id
  child_instance_id = local.vpc_id
}