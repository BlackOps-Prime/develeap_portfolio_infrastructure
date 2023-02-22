# Configure the AWS Provider
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.0"
    }

  }

  # Setting the Backend to store state files in S3
  backend "s3" {
    bucket = "christoher-terraform-states"
    key    = "portfolio/terraform.tfstate"
    region = "us-west-2"
    # dynamodb_table = "christopher_portfolio_terraform_state_lock"
    encrypt = true
    profile = "develeap"
  }
}

# Account Details Setup
provider "aws" {
  region  = "us-west-2"
  profile = "develeap"
  default_tags {
    tags = {
      owner           = var.owner_tag
      bootcamp        = var.bootcamp_tag
      expiration_date = var.exp_date_tag
    }
  }
}

provider "helm" {
  kubernetes {
    cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    config_path            = "~/.kube/config"
    exec {
      api_version = "client.authentication.k8s.io/v1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}


provider "kubernetes" {
  cluster_ca_certificate = base64decode(module.eks.kubeconfig-certificate-authority-data)
  host                   = data.aws_eks_cluster.cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster.token
  config_path            = "~/.kube/config"
}


