# EKS Cluster
resource "aws_eks_cluster" "self" {
  name     = "${var.project}-cluster"
  role_arn = aws_iam_role.cluster.arn
  version  = "1.24"

  vpc_config {
    # security_group_ids      = [aws_security_group.eks_cluster.id, aws_security_group.eks_nodes.id]
    subnet_ids              = var.subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy
  ]
}


resource "aws_eks_addon" "coredns" {
  cluster_name      = aws_eks_cluster.self.name
  addon_name        = "coredns"
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name      = aws_eks_cluster.self.name
  addon_name        = "kube-proxy"
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name      = aws_eks_cluster.self.name
  addon_name        = "vpc-cni"
  resolve_conflicts = "OVERWRITE"
}




# resource "null_resource" "kubectl" {

#     #  Create Storage Class
#   provisioner "local-exec" {
#     command = "helm install local-path-storage ${path.module}/manifest/storage-class/"
#   }

# #   depends_on = [aws_eks_cluster.self, aws_eks_node_group.self]


# #     // Create namespaces
# #   provisioner "local-exec" {
# #     command = "kubectl apply -f ${path.module}/additional_manifests/"
# #   }

# # #   // Update kubeconfig file
# # #   provisioner "local-exec" {
# # #     command = "aws eks update-kubeconfig --name christopher-portfolio-cluster --region us-west-2"
# # #   }


