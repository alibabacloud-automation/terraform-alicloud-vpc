module "vpc" {

  source   = "../../../terraform-modules/github-terraform-alicloud-vpc"
  vpc_name = "vpc-standalone"
  vpc_cidr = "172.18.0.0/16"

  create_nat_gateway = true

  route_table_description = "Route description"

}