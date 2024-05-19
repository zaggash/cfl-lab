module "downstream_rke2" {
  source = "./modules/downstream/aws/v2/"

  aws_access_key           = var.aws_access_key
  aws_secret_key           = var.aws_secret_key
  aws_region               = var.aws_region
  ami                      = var.ds_rke_ami
  instance_type            = var.instance_type
  spot_instances           = var.spot_instances

  vpc_id                  = var.vpc_id                      
  subnet_id               = var.subnet_id
  zone                    = var.zone
  
  volume_size              = var.ds_rke2_volume_size
  all_roles_node_pool_name = "${var.prefix}-all"
  security_group_name      = var.ds_rke2_security_group_name
  kubernetes_version       = var.ds_rke2_kubernetes_version
  cni_provider             = var.ds_rke2_cni_provider
}

