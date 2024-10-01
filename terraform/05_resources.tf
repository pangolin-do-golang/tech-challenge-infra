resource "helm_release" "metrics-server" {
  namespace  = "kube-system"
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server"
  chart      = "metrics-server"
  version    = var.metrics_server_version
  wait       = false



  depends_on = [
    module.eks.eks_managed_node_groups,
    helm_release.karpenter,
    kubectl_manifest.karpenter_node_class,
    kubectl_manifest.karpenter_node_pool
  ]
}

resource "helm_release" "kube-state-metrics" {
  namespace        = "kube-state-metrics"
  name             = "kube-state-metrics"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-state-metrics"
  version          = var.kube_state_metrics_version
  create_namespace = true
  wait             = false



  depends_on = [
    module.eks.eks_managed_node_groups,
    helm_release.karpenter,
    kubectl_manifest.karpenter_node_class,
    kubectl_manifest.karpenter_node_pool
  ]
}
