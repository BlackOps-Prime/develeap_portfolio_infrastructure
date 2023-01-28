output "endpoint" {
  value = aws_eks_cluster.self.endpoint
}
output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.self.certificate_authority[0].data
}
output "cluster_id" {
  value = aws_eks_cluster.self.id
}
output "cluster_endpoint" {
  value = aws_eks_cluster.self.endpoint
}
output "cluster_name" {
  value = aws_eks_cluster.self.name
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "AmazonEKSWorkerNodePolicy" {
  value = aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy
}

output "AmazonEKS_CNI_Policy" {
  value = aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy
}

output "AmazonEC2ContainerRegistryReadOnly" {
  value = aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy
}

output "cluster_role_arn" {
  value = aws_iam_role.cluster.arn
}

output "AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
}

output "AmazonEKSVPCResourceController" {
  value = aws_iam_role_policy_attachment.AmazonEKSVPCResourceController
}


output "nodegroup_id" {
  value = aws_eks_node_group.self.id
}

output "node_group_name" {
  value = aws_eks_node_group.self.node_group_name
}