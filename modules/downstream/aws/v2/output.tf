output "cluster_id" {                                                                                                                                                                                       
  value = rancher2_cluster_v2.cluster.cluster_v1_id
}

output "system_project_id" {
  value = data.rancher2_project.system.id
}
