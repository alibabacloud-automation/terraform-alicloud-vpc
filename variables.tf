# Cloud Project variable

variable "project_name" {
  description = "The project name"
  type        = string
  default     = ""
}

# Terraform general variables
variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

# VPC variables
variable "create_vpc" {
  description = "Whether to create vpc. If false, you must specify an existing vpc by setting 'vpc_id'."
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "The vpc name used to launch a new vpc."
  type        = string
  default     = "TF-VPC"
}

variable "vpc_description" {
  description = "The vpc description used to launch a new vpc."
  type        = string
  default     = "A new VPC created by Terrafrom module terraform-alicloud-vpc"
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc."
  type        = string
  default     = "172.16.0.0/12"
}

variable "vpc_id" {
  description = "The VPC ID when it is already created."
  type        = string
  default     = ""
}

variable "resource_group_id" {
  description = "The Id of resource group which the instance belongs."
  type        = string
  default     = ""
}

variable "tags" {
  description = "The tags assigned to the whole module."
  type        = map(string)
  default     = {}
}

variable "vpc_tags" {
  description = "The tags assigned to the vpc."
  type        = map(string)
  default     = {}
}

# VSwitch variables
variable "vswitches" {
  description = "A list of the specific CIDR blocks desired for each public subnet. The key must be in the form AZ-0, AZ-1, ... AZ-n where n is the number of Availability Zones."
  type        = map(object({ name = string, cidr_block = string, availability_zone = string, description = string }))
  default     = {}
}

variable "vswitches_tags" {
  description = "The tags assigned only to vswitches"
  type        = map(string)
  default     = {}
}

# NAT Gateway variables
variable "create_nat_gateway" {
  type    = bool
  default = false
}

variable "nat_gateway_specification" {
  default = "Small"
}

variable "nat_eip_bandwidth" {
  default = 1
}

variable "nat_gateway_num_eips" {
  default = 1
}

# Routes variables
variable "custom_routes" {
  description = "A list of the specific routes desired for the route table."
  type        = map(object({ destination_cidrblock = string, nexthop_type = string, nexthop_id = string }))
  default     = {}
}


# CEN
variable "cen_enabled" {
  description = "The VPC must or must not access to the CEN"
  type        = bool
  default     = false
}

variable "cen_id" {
  description = "The CEN identifier"
  type        = string
  default     = null
}

variable "cen_owner_id" {
  description = "The CEN owner identifier"
  type        = string
  default     = null
}