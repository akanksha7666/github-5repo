variable "project" {
  type        = string
  default     = "dhruv"
  description = "Project name is used to identify resources"
}

variable "environment" {
  description = "used to compute environment value"
  default     = "auto"
}

variable "availability_zones" {
  type        = list(string)
  default     = []
  description = "A list of availability zones in the region"
}

variable "vpc_cidr" {
  default     = "0.0.0.0/16"
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
}

variable "private_subnet" {
  type        = list(string)
  default     = []
  description = "A list of private subnets for ECS inside the VPC"
}

variable "public_subnet" {
  type        = list(string)
  default     = []
  description = "A list of public subnets for LB inside the VPC"
}

variable "enable_nat_gateway" {
  default     = ""
  description = "Should be true if you want to provision NAT Gateways for each of your private networks"
}

variable "single_nat_gateway" {
  default     = ""
  description = "Should be true if you want to provision a single shared NAT Gateway across all of your private networks"
}

variable "enable_vpn_gateway" {
  default = ""
}

variable "region" {
  default = ""
}