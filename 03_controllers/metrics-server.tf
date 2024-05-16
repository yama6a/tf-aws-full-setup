// Ref: https://artifacthub.io/packages/helm/metrics-server/metrics-server
resource "helm_release" "metrics-server" {
  name            = "metrics-server"
  chart           = "metrics-server"
  version         = "3.12.1"
  repository      = "https://kubernetes-sigs.github.io/metrics-server/"
  wait            = true
  cleanup_on_fail = true

  namespace        = "kube-system"
  create_namespace = false

  set {
    name  = "args[0]"
    value = "--kubelet-preferred-address-types=InternalIP"
  }
#  serviceaccount = "metrics-server"
}

// Todo
