# VPC variables
variable "vpc_name" {
  description = "The vpc name used to launch a new vpc."
  type        = string
  default     = "tf-vpc-name"
}

variable "vpc_description" {
  description = "The vpc description used to launch a new vpc."
  type        = string
  default     = "tf-vpc-description"
}

variable "vpc_tags" {
  description = "The tags used to launch a new vpc. Before 1.5.0, it used to retrieve existing VPC."
  type        = map(string)
  default = {
    Name = "VPC"
  }
}

# VSwitch variables
variable "vswitch_name" {
  description = "The vswitch name prefix used to launch several new vswitches."
  type        = string
  default     = "tf-vswitch-name"
}

variable "vswitch_description" {
  description = "The vswitch description used to launch several new vswitch."
  type        = string
  default     = "tf-vswitch-description"
}

variable "vswitch_tags" {
  description = "The tags used to launch serveral vswitches."
  type        = map(string)
  default = {
    Name = "VSWITCH"
  }
}