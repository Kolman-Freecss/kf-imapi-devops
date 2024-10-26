# resource "aws_eks_cluster" "this" {
#   name     = var.cluster_name
#   role_arn = aws_iam_role.eks_cluster_role.arn
# 
#   vpc_config {
#     subnet_ids = aws_subnet.eks_subnet[*].id
#   }
# }
# 
# resource "aws_iam_role" "eks_cluster_role" {
#   name = "${var.cluster_name}-eks-cluster-role"
# 
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action    = "sts:AssumeRole"
#       Principal = {
#         Service = "eks.amazonaws.com"
#       }
#       Effect    = "Allow"
#       Sid       = ""
#     }]
#   })
# }
# 
# resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
#   role       = aws_iam_role.eks_cluster_role.name
# }
# 
# resource "aws_vpc" "this" {
#   cidr_block = var.vpc_cidr
# }
# 
# resource "aws_subnet" "eks_subnet" {
#   count                   = var.subnet_count
#   vpc_id                 = aws_vpc.this.id
#   cidr_block             = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
#   availability_zone      = element(data.aws_availability_zones.available.names, count.index)
#   map_public_ip_on_launch = true
# }
# 
# data "aws_availability_zones" "available" {}
# 
# resource "aws_eks_node_group" "this" {
#   cluster_name    = aws_eks_cluster.this.name
#   node_group_name = "${var.cluster_name}-node-group"
#   node_role_arn   = aws_iam_role.eks_node_group_role.arn
#   subnet_ids      = aws_subnet.eks_subnet[*].id
#   scaling_config {
#     desired_size = var.node_desired_size
#     max_size     = var.node_max_size
#     min_size     = var.node_min_size
#   }
# }
# 
# resource "aws_iam_role" "eks_node_group_role" {
#   name = "${var.cluster_name}-node-group-role"
# 
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action    = "sts:AssumeRole"
#       Principal = {
#         Service = "ec2.amazonaws.com"
#       }
#       Effect    = "Allow"
#       Sid       = ""
#     }]
#   })
# }
# 
# resource "aws_iam_role_policy_attachment" "eks_node_group_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
#   role       = aws_iam_role.eks_node_group_role.name
# }
# 
# resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
#   role       = aws_iam_role.eks_node_group_role.name
# }
# 
# resource "aws_iam_role_policy_attachment" "eks_registry_policy" {
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   role       = aws_iam_role.eks_node_group_role.name
# }