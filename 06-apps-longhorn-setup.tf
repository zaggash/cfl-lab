locals {
 downstream_clusters = {
   "ds-rke" = { cluster_id = module.downstream_rke.cluster_id, system_project_id = module.downstream_rke.system_project_id  },
   "ds-rke2" = { cluster_id = module.downstream_rke2.cluster_id, system_project_id = module.downstream_rke2.system_project_id },
 }
}

resource "rancher2_namespace" "longhorn" {
  for_each = local.downstream_clusters
  name = "longhorn-system"
  project_id = each.value.system_project_id
}

resource "rancher2_secret_v2" "longhorn-s3" {
  for_each = local.downstream_clusters

  depends_on = [                                                   
    rancher2_namespace.longhorn
  ]

  cluster_id = each.value.cluster_id
  name = "s3-secret"
  namespace = "longhorn-system"
  data = {    
      AWS_ACCESS_KEY_ID = var.do_s3_access
      AWS_SECRET_ACCESS_KEY = var.do_s3_secret
      AWS_ENDPOINTS = "https://${var.do_s3_endpoint}"
  }
}

resource "rancher2_app_v2" "rke-longhorn" {
  for_each = local.downstream_clusters

  depends_on = [
    rancher2_secret_v2.longhorn-s3
  ]

  cluster_id       = each.value.cluster_id
  name             = "longhorn"
  namespace        = "longhorn-system"
  repo_name        = "rancher-charts"
  chart_name       = "longhorn"
  #chart_version    = "103.3.0+up1.6.1"
  cleanup_on_fail  = true
  values           = templatefile("${path.module}/chart-values-longhorn.yaml.tftpl",
                       {                              
                         "region" = var.do_s3_region, 
                         "bucket" = var.do_s3_bucket,
                         "folder" = "${var.prefix}-longhorn"
                       })
}
