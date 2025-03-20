resource "time_sleep" "wait_60_seconds" {
  depends_on = [module.eks]

  create_duration = "60s"
}

resource "helm_release" "external-secrets-store" {
  name       = "external-secrets-store"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
  namespace  = "external-secrets"
  provider   = helm
  create_namespace = true
  set {
    name  = "installCRDs"
    value = true
  }
  depends_on = [module.eks, time_sleep.wait_60_seconds]
}
