# EFS Security group
resource "aws_security_group" "efs_security_group" {
  name        = "${local.environment}-eks-efs-sg"
  description = "EFS security group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
    description = "NFS Access test"
  }
    egress {
    from_port        = 2049
    to_port          = 2049
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "outbount to internet"
  }
}