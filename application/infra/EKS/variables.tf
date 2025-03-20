variable "project" {
  description = "description"
  default     = ""
}

variable "environment" {
  description = "description"
  default     = "auto"
}

variable "region" {
  default = "ca-central-1"
}

variable "capacity_type" {
  description = "description"
  default     = ""
}

variable "disk_size" {
  description = "description"
  default     = "30"
}
# #############################################

variable "alb_name" {
  description = "name of the alb"
  default     = ""
  type        = string
}

variable "aws_eks_cluster_version" {
  description = "Kubernetes version supported by EKS"
  type        = string
  default     = "1.29"
}

variable "instance_types" {
  description = " update here Instnace types"
  default     = ""
}

variable "ssh_key_name" {
  description = "add here ssh key name (pem key name) for instance"
  type        = string
  default     = "boobud-eks"
}

variable "desired_size" {
  description = "Add here desired number of nodes"
  # type        = string
  default = ""
}
variable "max_size" {
  description = "Add here max number of nodes"
  # type        = string
  default = ""
}
variable "min_size" {
  description = "Add here minimum number of nodes"
  # type        = string
  default = ""
}

variable "aws_auth_additional_labels" {
  description = "Additional kubernetes labels applied on aws-auth ConfigMap"
  type        = map(string)
  default     = {}
}

variable "account_ids" {
  description = "Additional AWS account numbers to add to the aws-auth configmap."
  type        = list(string)
  default     = ["348286729043"]
  # default     = ["${data.aws_caller_identity.current.account_id}"]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth ConfigMap"
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))
  default = [
  { rolearn = "arn:aws:iam::348286729043:role/seemore-OIDC-Role", username = "system:node:{{EC2PrivateDNSName}}", groups = ["system:nodes", "system:bootstrappers", "system:masters"] }]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth ConfigMap"
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))
  default = [{ userarn = "arn:aws:iam::348286729043:user/terraform", username = "terraform", groups = ["system:masters"] } ]
}

variable "cidr_blocks" {
  type = list(string)
}