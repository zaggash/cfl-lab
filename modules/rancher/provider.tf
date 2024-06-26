provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_file
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_file
}

provider "rancher2" {
  alias     = "bootstrap"

  api_url   = "https://${var.rancher_hostname}"
  bootstrap = true
  insecure  = true
}
