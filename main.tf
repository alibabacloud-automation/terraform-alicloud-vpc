provider "alicloud" {
  version                 = ">=1.56.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/vpc"
}

// Zones data source for availability_zone
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

// If there is not specifying vpc_id, the module will launch a new vpc
resource "alicloud_vpc" "vpc" {
  count       = local.vpc_id == "" ? 1 : 0
  name        = var.vpc_name
  cidr_block  = var.vpc_cidr
  description = var.vpc_description
}

// According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "vswitches" {
  count             = length(var.vswitch_cidrs)
  vpc_id            = var.vpc_id != "" ? var.vpc_id : concat(alicloud_vpc.vpc.*.id, [""])[0]
  cidr_block        = var.vswitch_cidrs[count.index]
  availability_zone = length(var.availability_zones) > 0 ? var.availability_zones[count.index] : element(data.alicloud_zones.default.ids.*, count.index)
  name              = length(var.vswitch_cidrs) < 2 ? var.vswitch_name : format("%s_%s", var.vswitch_name, format(var.number_format, count.index + 1))
  description       = length(var.vswitch_cidrs) < 2 ? var.vswitch_description : format("%s This is NO.%s", var.vswitch_description, format(var.number_format, count.index + 1))
}

// According to the destination cidr block to launch a new route entry
resource "alicloud_route_entry" "route_entry" {
  count                 = length(var.destination_cidrs)
  route_table_id        = local.route_table_id
  destination_cidrblock = var.destination_cidrs[count.index]
  nexthop_type          = "Instance"
  nexthop_id            = var.nexthop_ids[count.index]
}
