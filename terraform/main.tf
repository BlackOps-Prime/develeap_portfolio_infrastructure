# Network Setup
module "networking" {
  source = "./modules/networking"
}

# Cluster Setup
module "eks" {
  source = "./modules/EKS"

  subnet_ids     = module.networking.subnet_ids
  private_subnet = module.networking.private_subnet
}


# ArgoCD Deployment
resource "helm_release" "argo-cd" {

  name             = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  create_namespace = true
  cleanup_on_fail  = true
  version          = "5.19.x"

  values = [
    file("${path.module}./argo-cd/values.yaml")
  ]

  namespace  = "argocd"
  depends_on = [null_resource.local_path_storage]
}

data "aws_eks_node_group" "node_name" {
  depends_on      = [data.aws_eks_cluster.cluster]
  node_group_name = module.eks.node_group_name
  cluster_name    = module.eks.cluster_id
}


resource "null_resource" "kubectl" {
  depends_on = [data.aws_eks_cluster.cluster]

  # Update KubeConfig File
  provisioner "local-exec" {
    command = "aws eks --region us-west-2 update-kubeconfig --profile develeap --name ${data.aws_eks_cluster.cluster.name} "
  }
}

resource "null_resource" "local_path_storage" {
  depends_on = [data.aws_eks_node_group.node_name]

  #  Create Local Storage Class
  provisioner "local-exec" {
    command = "bash ./script/storage_class.sh"
  }

}