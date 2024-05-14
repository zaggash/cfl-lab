resource "rancher2_secret_v2" "rancher-backup-s3" {
  cluster_id = "local"
  name = "s3-creds"
  namespace = "default"
  data = {
      accessKey = var.do_s3_access
      secretKey = var.do_s3_secret
  }
}

resource "rancher2_app_v2" "rancher-backup" {
  cluster_id       = "local"
  name             = "rancher-backup"
  namespace        = "cattle-resources-system"
  repo_name        = "rancher-charts"
  chart_name       = "rancher-backup"
  #chart_version    = "103.0.2+up4.0.2"
  cleanup_on_fail  = true
  values           = templatefile("${path.module}/chart-values-rancher-backup.yaml.tftpl",
                       {
                         "region" = var.do_s3_region,
                         "bucketName" = var.do_s3_bucket,
                         "folder" = "${var.prefix}-rancher-backup"
                         "endpoint" = var.do_s3_endpoint
                       })
}

