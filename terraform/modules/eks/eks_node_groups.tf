# EKS Node Groups
resource "aws_eks_node_group" "self" {
  cluster_name    = aws_eks_cluster.self.name
  node_group_name = var.project
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = var.private_subnet[*].id

  scaling_config {
    desired_size = 4
    max_size     = 7
    min_size     = 1
  }

  ami_type       = "AL2_x86_64" # AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM
  capacity_type  = "ON_DEMAND"  # ON_DEMAND, SPOT
  disk_size      = 50
  instance_types = ["t3.medium"]

  depends_on = [
    aws_iam_role_policy_attachment.node_AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node_AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node_AmazonEC2ContainerRegistryReadOnly,
  ]
}

