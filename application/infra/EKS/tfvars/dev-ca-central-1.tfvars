aws_eks_cluster_version = "1.30"
# service_ipv4_cidr = "172.19.12.0/24"
# nodegroup_release_version = "1.27.4-20230825"
# nodegroup_ami_type = "AL2_x86_64"
# nodegroup_disk_size = 30
# disk_size = 30
capacity_type = "SPOT"
# capacity_type = "ON_DEMAND"
instance_types = ["t3a.xlarge"]
desired_size = 2
max_size = 3
min_size = 1
cidr_blocks = ["172.18.0.0/16","172.17.0.0/16","172.19.0.0/16","192.168.248.0/21"]
account_ids = ["688567282837"]
map_users = [{ userarn = "arn:aws:iam::688567282837:user/dhruv", username = "dhruv", groups = ["system:masters"] } ]
project="boobud"