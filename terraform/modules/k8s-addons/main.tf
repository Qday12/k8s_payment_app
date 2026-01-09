
# AWS Load Balancer Controller
resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.6.2" 
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "region"
    value = var.region
  }

  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = var.alb_controller_role_arn
  }

  # Recommended settings
  set {
    name  = "enableShield"
    value = "false"
  }

  set {
    name  = "enableWaf"
    value = "false"
  }

  set {
    name  = "enableWafv2"
    value = "false"
  }

  # Wait for CRDs to be ready
  wait = true
  timeout = 600

  depends_on = [var.cluster_endpoint]
}


# Wait for ALB Controller Webhook to be ready
resource "time_sleep" "wait_for_alb_webhook" {
  depends_on = [helm_release.aws_load_balancer_controller]

  create_duration = "60s"
}

# External Secrets Operator
resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  version    = "0.9.13"
  namespace  = "external-secrets-system"

  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  # Configure webhook
  set {
    name  = "webhook.port"
    value = "9443"
  }

  # Resource limits
  set {
    name  = "resources.requests.cpu"
    value = "10m"
  }

  set {
    name  = "resources.requests.memory"
    value = "32Mi"
  }

  set {
    name  = "resources.limits.cpu"
    value = "100m"
  }

  set {
    name  = "resources.limits.memory"
    value = "128Mi"
  }

  wait = true
  timeout = 600

  depends_on = [time_sleep.wait_for_alb_webhook]
}
