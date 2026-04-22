provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_resource_manager_resource_groups" "default" {
}


module "vpc" {
  source = "../../"

  vpc_name = "complete-example"

  vpc_cidr          = "10.10.0.0/16"
  resource_group_id = data.alicloud_resource_manager_resource_groups.default.ids[0]


  availability_zones = ["cn-hangzhou-e", "cn-hangzhou-f", "cn-hangzhou-g"]
  vswitch_cidrs      = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]

  vpc_tags = {
    Owner       = "user"
    Environment = "staging"
    Name        = "complete"
  }

  vswitch_tags = {
    Project  = "Secret"
    Endpoint = "true"
  }
}

# This vpc and other resources won't be created
module "vpc_zero" {
  source = "../../"

  create   = false
  vpc_name = "complete-example"

  vpc_cidr = "10.10.0.0/16"

  availability_zones = ["cn-hangzhou-e", "cn-hangzhou-f", "cn-hangzhou-g"]
  vswitch_cidrs      = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}