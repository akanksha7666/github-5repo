variable "project" {
  description = "description"
  default     = "boobud"
}

variable "environment" {
  description = "description"
  default     = "auto"
}

variable "region" {
  default = "us-east-1"
}

variable "cidr_blocks" {
  type = list(string)
}