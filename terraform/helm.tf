resource "helm_release" "nginx" {
  name = "nginx-ingress"

  repository = "https://helm.nginx.com/stable"
  chart      = "nginx-ingress"

  create_namespace = true
  namespace        = "nginx-ingress"
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.16.1"

  create_namespace = true
  namespace        = "cert-manager"

  set {
  name  = "crds.enabled"
  value = "true"
}


  values = [
    "${file("helm-values/cert-manager.yaml")}"
  ]
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"

  create_namespace = true
  namespace        = "external-dns"

 depends_on = [module.cert_manager_irsa_role]

  values = [
    "${file("helm-values/external-dns.yaml")}"
  ]
}

resource "helm_release" "argocd_deploy" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = "5.19.15"
  timeout          = 600

  namespace        = "argo-cd"
  create_namespace = true

  values = [
    file("helm-values/argocd.yaml")
  ]
}
