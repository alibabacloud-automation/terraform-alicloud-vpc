data "alicloud_zones" "default" {
}

data "alicloud_images" "default" {
  name_regex = "ubuntu_18"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_zones.default.zones.0.id
}

data "alicloud_resource_manager_resource_groups" "default" {
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

module "ecs_instance" {
  source = "alibaba/ecs-instance/alicloud"

  number_of_instances = 1

  instance_type      = data.alicloud_instance_types.default.instance_types.0.id
  image_id           = data.alicloud_images.default.images.0.id
  vswitch_ids        = [module.vpc.this_vswitch_ids]
  security_group_ids = [module.security_group.this_security_group_id]
}

module "vpc" {
  source = "../../"

  #alicloud_vpc
  create = true

  vpc_name          = var.vpc_name
  vpc_cidr          = "172.16.0.0/12"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
  vpc_description   = var.vpc_description
  vpc_tags          = var.vpc_tags

  #alicloud_vswitch
  vswitch_cidrs       = ["172.16.0.0/21"]
  availability_zones  = [data.alicloud_zones.default.zones.0.id]
  vswitch_name        = var.vswitch_name
  use_num_suffix      = true
  vswitch_description = var.vswitch_description
  vswitch_tags        = var.vswitch_tags

}

module "router" {
  source = "../../"

  #alicloud_vpc and alicloud_vswitch
  create = true

  vpc_id            = module.vpc.this_vpc_id
  vpc_name          = var.vpc_name
  vpc_cidr          = "172.16.0.0/12"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids.0
  vpc_description   = var.vpc_description
  vpc_tags          = var.vpc_tags

  #alicloud_route_entry
  destination_cidrs = ["192.168.0.0/24"]
  nexthop_ids       = module.ecs_instance.this_instance_id

}