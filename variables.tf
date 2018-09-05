variable "availability_zones" {
  description = "List available zones to launch several VSwitches."
  type        = "list"
  default     = [""]
}

variable "number_format" {
  description = "The number format used to output."
  default     = "%02d"
}

# Instance typs variables
variable "cpu_core_count" {
  description = "CPU core count used to fetch instance types."
  default     = 1
}

variable "memory_size" {
  description = "Memory size used to fetch instance types."
  default     = 2
}

# VPC variables
variable "vpc_id" {
  description = "The vpc id used to launch several vswitches."
  default     = ""
}

variable "vpc_name" {
  description = "The vpc name used to launch a new vpc when 'vpc_id' is not specified."
  default     = "TF-VPC"
}

variable "vpc_description" {
  description = "The vpc description used to launch a new vpc when 'vpc_id' is not specified."
  default     = "A new VPC created by Terrafrom module tf-alicloud-vpc-cluster"
}

variable "vpc_cidr" {
  description = "The cidr block used to launch a new vpc when 'vpc_id' is not specified."
  default     = "172.16.0.0/12"
}

# VSwitch variables
variable "vswitch_cidrs" {
  description = "List of cidr blocks used to launch several new vswitches."
  type        = "list"
  default     = []
}

variable "vswitch_name" {
  description = "The vswitch name prefix used to launch several new vswitch."
  default     = "TF_VSwitch"
}

variable "vswitch_description" {
  description = "The vswitch description used to launch several new vswitch."
  default     = "New VSwitch created by Terrafrom module tf-alicloud-vpc-cluster."
}

// According to the vswitch cidr blocks to launch several vswitches
variable "route_table_id" {
  description = "The route table ID of virtual router in the specified VPC."
  default     = ""
}

variable "destination_cidrs" {
  description = "List of destination CIDR block of virtual router in the specified VPC."
  type        = "list"
  default     = []
}

variable "nexthop_ids" {
  description = "List of next hop instance IDs of virtual router in the specified VPC."
  type        = "list"
  default     = []
}
