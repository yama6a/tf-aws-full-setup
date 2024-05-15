# Ensure that two replicas are running for resiliency reasons
locals {
  high_availability_settings = {
    "replicaCount" : 2
    "leaderElect" : true
    "podLabels" : { "app" : "external-secrets" }
    "affinity" : {
      "podAntiAffinity" : {
        "preferredDuringSchedulingIgnoredDuringExecution" : [
          {
            "weight" : 100
            "podAffinityTerm" : {
              "topologyKey" : "topology.kubernetes.io/zone"
              "labelSelector" : {
                "matchExpressions" : [
                  {
                    "key" : "app"
                    "operator" : "In"
                    "values" : ["external-secrets"]
                  }
                ]
              }
            }
          }
        ]
      }
    }
  }
}


resource "helm_release" "external-secrets-operator" {
  name       = "external-secrets"
  chart      = "external-secrets"
  version    = "0.9.18"
  repository = "https://charts.external-secrets.io"

  namespace        = "external-secrets"
  create_namespace = true

  wait = true

  values = [yamlencode(local.high_availability_settings)]
}
