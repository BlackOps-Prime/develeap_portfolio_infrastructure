# Enabling IAM Role for Service Account
data "tls_certificate" "tls" {
  url = aws_eks_cluster.self.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "opidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.tls.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.self.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "self" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.opidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.opidc.arn]
      type        = "Federated"
    }
  }
}