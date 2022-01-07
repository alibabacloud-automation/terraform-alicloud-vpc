
terraform {
  required_version = ">= 0.12"

  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = ">= 1.119.0"
    }
  }
}
