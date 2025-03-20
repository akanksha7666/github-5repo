terraform {
  backend "s3" {
    key = "efs/efs.tfstate"
  }
}


locals {
  tf_backend_workspace = substr(terraform.workspace, 0, 4) == "prod" ? "${var.project}-prod" : substr(terraform.workspace, 0, 3) == "dev" ?  "${var.project}-dev" : "${var.project}-admin"
  environment = var.environment == "auto" ? regex("^(dev|admin|prod)-", terraform.workspace)[0] : var.environment
  default_tags = {
    "Environment" = "${local.environment}"
    "managed_by"  = "terraform"
    "Project_cost" = "${var.project}"
  }
}

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


data "aws_caller_identity" "current" {}

resource "aws_efs_file_system" "boobud_eks_efs" {
  creation_token = "boobud-${local.environment}-efs"
  performance_mode = "generalPurpose"
  throughput_mode = "bursting"
  encrypted = true
  tags = merge(local.default_tags, {
    Name = "boobud-${local.environment}-efs"
  })
}

# EFS File system mount target
resource "aws_efs_mount_target" "efs_mount_target" {
  count           = 3
  file_system_id  = aws_efs_file_system.boobud_eks_efs.id
  subnet_id = element(data.terraform_remote_state.vpc.outputs.private_subnets, count.index)
  security_groups = [aws_security_group.efs_security_group.id]
}

#Auto backups
resource "aws_efs_backup_policy" "policy" {
  file_system_id = aws_efs_file_system.boobud_eks_efs.id

  backup_policy {
    status = "ENABLED"
  }
}