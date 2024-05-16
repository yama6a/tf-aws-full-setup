locals {
  alb_namespace = "kube-system"
  alb_sa_name   = "aws-load-balancer-controller"
}

// Ref: https://artifacthub.io/packages/helm/aws/aws-load-balancer-controller
resource "helm_release" "alb-ingress-controller" {
  name            = "aws-load-balancer-controller"
  chart           = "aws-load-balancer-controller"
  version         = "1.7.2"
  repository      = "https://aws.github.io/eks-charts"
  wait            = true
  cleanup_on_fail = true

  namespace        = "kube-system" // todo: switch to own namespace?
  create_namespace = false       // todo: switch to true if using own namespace


  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.irsa.arn
  }
}

### iam policy document
data "http" "iam_policy_json" {
  url             = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
  request_headers = { Accept = "application/json" }
}

# create policy in AWS IAM
resource "aws_iam_policy" "lbc" {
  name        = "aws-loadbalancer-controller"
  tags        = var.tags
  description = "Allow ALB-controller to manage AWS resources, such as ELBs, VPC, WAF, Certs, SecurityGroups, etc."
  policy      = data.http.iam_policy_json.response_body

  lifecycle {
    precondition {
      condition     = data.http.iam_policy_json.status_code == 200
      error_message = "Fetching ALB Policy Document failed with status code ${data.http.iam_policy_json.status_code}"
    }
  }
}

// create role in AWS IAM
resource "aws_iam_role" "irsa" {
  name               = "aws-loadbalancer-controller"
  path               = "/"
  tags               = var.tags
  assume_role_policy = jsonencode({
    Statement = [
      {
        Action    = "sts:AssumeRoleWithWebIdentity"
        Effect    = "Allow"
        Principal = { Federated = var.oidc_arn }
        Condition = {
          StringEquals = {
            join(":", [var.oidc_url, "aud"]) = "sts.amazonaws.com"
            join(":", [var.oidc_url, "sub"]) = "system:serviceaccount:${local.alb_namespace}:${local.alb_sa_name}"
          }
        }
      }
    ]
    Version = "2012-10-17"
  })
}

// attach policy to role
resource "aws_iam_role_policy_attachment" "irsa" {
  policy_arn = aws_iam_policy.lbc.arn
  role       = aws_iam_role.irsa.name
}
