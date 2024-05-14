output "rancher_instances_public_ip" {                                                                                                                                                                              
  value = concat([module.rancher_rke2_first_server.instances_public_ip], [module.rancher_rke2_additional_servers.instances_public_ip])
}
 
output "rancher_instances_private_ip" {
  value = concat([module.rancher_rke2_first_server.instances_private_ip], [module.rancher_rke2_additional_servers.instances_private_ip])
}
 
output "rancher_hostname" {
  value = local.rancher_hostname
}
 
output "rancher_url" {
  value = "https://${local.rancher_hostname}"
}

output "rancher_backup_url" {
  value = "https://${local.rancher_hostname}/dashboard/c/local/backup/resources.cattle.io.backup"
}

output "longhorn_Downstream_RKE1_URL" {
  value = "https://${local.rancher_hostname}/k8s/clusters/${module.downstream_rke.cluster_id}/api/v1/namespaces/longhorn-system/services/http:longhorn-frontend:80/proxy/#/dashboard"
}

output "longhorn_Downstream_RKE2_URL" { 
  value = "https://${local.rancher_hostname}/k8s/clusters/${module.downstream_rke2.cluster_id}/api/v1/namespaces/longhorn-system/services/http:longhorn-frontend:80/proxy/#/dashboard"
}
 
output "rancher_password" {
  value = var.rancher_password
}
