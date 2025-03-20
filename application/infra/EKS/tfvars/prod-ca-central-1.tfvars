aws_eks_cluster_version = 1.29
# service_ipv4_cidr = "172.19.12.0/24"
# nodegroup_release_version = "1.27.4-20230825"
# nodegroup_ami_type = "AL2_x86_64"
# nodegroup_disk_size = 30
# disk_size = 30
# capacity_type = "SPOT"
capacity_type = "ON_DEMAND"
instance_types = ["c5.large"]
desired_size = 2
max_size = 2
min_size = 1
cidr_blocks = ["172.18.0.0/16","172.17.0.0/16","172.19.0.0/16","192.168.248.0/21"]
account_ids = ["348286729043"]
map_roles = [ { rolearn = "arn:aws:iam::348286729043:role/seemore-OIDC-role", username = "system:node:{{EC2PrivateDNSName}}", groups = ["system:nodes", "system:bootstrappers", "system:masters"] }, { rolearn = "arn:aws:iam::348286729043:role/onelogin-administrator-access", username = "onelogin-administrator-access", groups = ["system:nodes", "system:bootstrappers", "system:masters"] }, { rolearn = "arn:aws:iam::348286729043:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_AdministratorAccess_dd440c3c9028d7b2", username = "AWSReservedSSO_AdministratorAccess_dd440c3c9028d7b2", groups = ["system:nodes", "system:bootstrappers", "system:masters"] }, { rolearn = "arn:aws:iam::348286729043:role/AWSReservedSSO_AdministratorAccess_dd440c3c9028d7b2", username = "AWSReservedSSO_AdministratorAccess_dd440c3c9028d7b2", groups = ["system:masters"] }]
map_users = [{ userarn = "arn:aws:iam::348286729043:user/terraform", username = "terraform", groups = ["system:masters"] } ]