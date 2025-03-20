#################################################
#                Remote tfstate                 #
#################################################
# Read VPC
data "terraform_remote_state" "vpc" {
  backend = "s3"

  workspace = substr(terraform.workspace, 0, 4) == "prod" ? terraform.workspace : substr(terraform.workspace, 0, 3) == "dev" ? terraform.workspace : "staging-${var.region}"
  config = {
    bucket               = "boobud-tf-state-bucket"
    key                  = "vpc/vpc.tfstate"
    region               = "ca-central-1"
  }
}

#################################################
#            create local variable              #
#################################################
locals {
  env_vpc_cidr            = data.terraform_remote_state.vpc.outputs.cidr_blocks
  env_vpc_id              = data.terraform_remote_state.vpc.outputs.vpc_id
  env_private_subnet_a_id = data.terraform_remote_state.vpc.outputs.private_subnets[0]
  env_private_subnet_c_id = data.terraform_remote_state.vpc.outputs.private_subnets[3]
  env_private_subnet_b_id = data.terraform_remote_state.vpc.outputs.private_subnets[1]
  env_private_subnet_d_id = data.terraform_remote_state.vpc.outputs.private_subnets[2]
}