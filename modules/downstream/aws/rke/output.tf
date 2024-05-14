output "cluster_id" {
  value = rancher2_cluster_sync.sync.id
}

output "system_project_id" {
  value = data.rancher2_project.system.id
}
