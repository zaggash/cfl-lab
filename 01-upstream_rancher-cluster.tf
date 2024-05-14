locals {
  kc_path        = var.kube_config_path != null ? var.kube_config_path : path.cwd
  kc_file        = var.kube_config_filename != null ? "${local.kc_path}/${var.kube_config_filename}" : "${local.kc_path}/${var.prefix}_kube_config.yml"
  kc_file_backup = "${local.kc_file}.backup"
}

module "rancher_rke2_first" {
  source       = "./modules/distribution/rke2"
  rke2_token   = var.rke2_token
  rke2_version = var.rke2_version
  rke2_config  = var.rke2_config
}

module "rancher_rke2_first_server" {
  source                  = "./modules/infra/aws"
  prefix                  = var.prefix
  instance_count          = 1
  instance_type           = var.instance_type
  instance_disk_size      = var.instance_disk_size
  create_ssh_key_pair     = var.create_ssh_key_pair
  ssh_key_pair_name       = var.ssh_key_pair_name
  ssh_key_pair_path       = var.ssh_key_pair_path
  ssh_username            = var.ssh_username
  spot_instances          = var.spot_instances
  aws_region              = var.aws_region
  create_security_group   = var.create_security_group
  instance_security_group = var.ssh_key_pair_name
  vpc_id                  = var.vpc_id
  subnet_id               = var.subnet_id
  user_data               = module.rancher_rke2_first.rke2_user_data
}

module "rancher_rke2_additional" {
  source          = "./modules/distribution/rke2"
  rke2_token      = module.rancher_rke2_first.rke2_token
  rke2_version    = var.rke2_version
  rke2_config     = var.rke2_config
  first_server_ip = module.rancher_rke2_first_server.instances_private_ip[0]
}

module "rancher_rke2_additional_servers" {
  source                  = "./modules/infra/aws"
  prefix                  = var.prefix
  instance_count          = var.instance_count - 1
  instance_type           = var.instance_type
  instance_disk_size      = var.instance_disk_size
  create_ssh_key_pair     = false
  ssh_key_pair_name       = module.rancher_rke2_first_server.ssh_key_pair_name
  ssh_key_pair_path       = module.rancher_rke2_first_server.ssh_key_path
  ssh_username            = var.ssh_username
  spot_instances          = var.spot_instances
  tag-begin               = 2
  aws_region              = var.aws_region
  create_security_group   = false
  instance_security_group = module.rancher_rke2_first_server.sg-id
  vpc_id                  = var.vpc_id                      
  subnet_id               = var.subnet_id
  user_data               = module.rancher_rke2_additional.rke2_user_data
}

data "local_file" "ssh_private_key" {
  depends_on = [module.rancher_rke2_first_server]
  filename   = module.rancher_rke2_first_server.ssh_key_path
}

resource "ssh_resource" "retrieve_kubeconfig" {
  host = module.rancher_rke2_first_server.instances_public_ip[0]
  commands = [
    "sudo sed 's/127.0.0.1/${module.rancher_rke2_first_server.instances_public_ip[0]}/g' /etc/rancher/rke2/rke2.yaml"
  ]
  user        = var.ssh_username
  private_key = data.local_file.ssh_private_key.content
}

resource "local_file" "kube_config_yaml" {
  filename        = local.kc_file
  content         = ssh_resource.retrieve_kubeconfig.result
  file_permission = "0600"
}

resource "local_file" "kube_config_yaml_backup" {
  filename        = local.kc_file_backup
  content         = ssh_resource.retrieve_kubeconfig.result
  file_permission = "0600"
}
