provider "aws" {
  access_key = var.aws_access_key != null ? var.aws_access_key : null
  secret_key = var.aws_secret_key != null ? var.aws_secret_key : null
  region     = var.aws_region
}

provider "rancher2" {
  api_url   = "https://${local.rancher_hostname}"
  insecure = true
  token_key = module.rancher_install.rancher_admin_token
  timeout   = "1800s"
}
