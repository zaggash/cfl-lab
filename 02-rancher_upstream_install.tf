locals {
  rancher_hostname = join(".", ["rancher", module.rancher_rke2_first_server.instances_public_ip[0], "sslip.io"])
}

module "rancher_install" {
  source                     = "./modules/rancher"
  dependency                 = var.instance_count > 1 ? module.rancher_rke2_additional_servers.dependency : module.rancher_rke2_first_server.dependency
  kubeconfig_file            = local_file.kube_config_yaml.filename
  rancher_hostname           = local.rancher_hostname
  rancher_replicas           = min(var.rancher_replicas, var.instance_count)
  rancher_bootstrap_password = var.rancher_bootstrap_password
  rancher_password           = var.rancher_password
  rancher_version            = var.rancher_version
  wait                       = var.wait
}
