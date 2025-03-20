# resource "time_sleep" "wait_10_seconds" {
#   depends_on = [resource.helm_release.external-secrets-store]
#   create_duration = "10s"
# }

# resource "helm_release" "istio-base" {
#   name       = "istio-base"
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   chart      = "base"
#   namespace  = "istio-system"
#   provider   = helm
#   create_namespace = true
#   version    = "1.21.0"
#   set {
#     name  = "global.istioNamespace"
#     value = "istio-system"
#   }
#   depends_on = [time_sleep.wait_10_seconds]
# }

# resource "helm_release" "istiod" {
#   name       = "istiod"
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   chart      = "istiod"
#   namespace  = "istio-system"
#   provider   = helm
#   create_namespace = true
#   version    = "1.21.0"
#   set {
#     name  = "telemetry.enabled"
#     value = "true"
#   }
#   set {
#     name  = "global.istioNamespace"
#     value = "istio-system"
#   }
#   set {
#     name  = "meshConfig.ingressService"
#     value = "istio-gateway"
#   }
#   set {
#     name  = "meshConfig.ingressSelector"
#     value = "gateway"
#   }
#   depends_on = [resource.helm_release.istio-base]
# }

# resource "helm_release" "istio-Gateways" {
#   name       = "istio-gateway"
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   chart      = "gateway"
#   namespace  = "istio-system"
#   provider   = helm
#   create_namespace = true
#   version    = "1.21.0"
#   depends_on = [resource.helm_release.istiod]
# }