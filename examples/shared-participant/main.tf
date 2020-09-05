module "vpc" {

  source   = "../../../terraform-modules/github-terraform-alicloud-vpc"
 
  create_vpc = false
  vpc_id = "abc-123"

  route_table_description = "Route description"

  vswitches = {
    aze = {
      name              = "subnet-1",
      cidr_block        = "172.18.2.0/24",
      availability_zone = "cn-shanghai-g",
      description       = ""
    },
    azf = {
      name              = "subnet-2",
      cidr_block        = "172.18.0.0/24",
      availability_zone = "cn-shanghai-e",
      description       = ""
    }
  }

}