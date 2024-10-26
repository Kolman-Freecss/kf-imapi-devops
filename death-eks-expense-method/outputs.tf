# output "eks_cluster_endpoint" {
#   description = "Endpoint URL of the EKS cluster"
#   value       = aws_eks_cluster.this.endpoint
# }
# 
# output "eks_cluster_name" {
#   description = "Name of the EKS cluster"
#   value       = aws_eks_cluster.this.name
# }
# 
# output "eks_cluster_kubeconfig" {
#   description = "Kubeconfig file content for accessing the EKS cluster"
#   value       = <<EOT
# apiVersion: v1
# clusters:
# - cluster:
#     server: ${aws_eks_cluster.this.endpoint}
#     certificate-authority-data: ${aws_eks_cluster.this.certificate_authority[0].data}
#   name: ${aws_eks_cluster.this.name}
# contexts:
# - context:
#     cluster: ${aws_eks_cluster.this.name}
#     user: aws
#   name: ${aws_eks_cluster.this.name}
# current-context: ${aws_eks_cluster.this.name}
# kind: Config
# preferences: {}
# users:
# - name: aws
#   user:
#     exec:
#       apiVersion: client.authentication.k8s.io/v1alpha1
#       command: aws
#       args:
#         - eks
#         - get-token
#         - --cluster-name
#         - ${aws_eks_cluster.this.name}
# EOT
# }
