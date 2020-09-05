module "vpc" {

  source   = "../../../terraform-modules/github-terraform-alicloud-vpc"
  vpc_name = "vpc-standalone"
  vpc_cidr = "172.18.0.0/16"

  create_nat_gateway = true
  associate_nat_gateway = true

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