// If there is not specifying vpc_id, the module will launch a new vpc
resource "alicloud_vpc" "vpc" {
  count             = var.vpc_id != "" ? 0 : var.create ? 1 : 0
  vpc_name          = var.vpc_name
  cidr_block        = var.vpc_cidr
  resource_group_id = var.resource_group_id
  description       = var.vpc_description
  tags = merge(
    {
      "Name" = format("%s", var.vpc_name)
    },
    var.vpc_tags,
  )
}

// According to the vswitch cidr blocks to launch several vswitches
resource "alicloud_vswitch" "vswitches" {
  count        = local.create_sub_resources ? length(var.vswitch_cidrs) : 0
  vpc_id       = var.vpc_id != "" ? var.vpc_id : concat(alicloud_vpc.vpc.*.id, [""])[0]
  cidr_block   = var.vswitch_cidrs[count.index]
  zone_id      = element(var.availability_zones, count.index)
  vswitch_name = length(var.vswitch_cidrs) > 1 || var.use_num_suffix ? format("%s%03d", var.vswitch_name, count.index + 1) : var.vswitch_name
  description  = var.vswitch_description
  tags = merge(
    {
      Name = format(
        "%s%03d",
        var.vswitch_name,
        count.index + 1
      )
    },
    var.vswitch_tags,
  )
}

// According to the destination cidr block to launch a new route entry
resource "alicloud_route_entry" "route_entry" {
  count                 = local.create_sub_resources ? length(var.destination_cidrs) : 0
  route_table_id        = local.route_table_id
  destination_cidrblock = var.destination_cidrs[count.index]
  nexthop_type          = "Instance"
  nexthop_id            = var.nexthop_ids[count.index]
}