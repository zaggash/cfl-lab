variable "aws_access_key" {
  type        = string
  description = "AWS access key used to create infrastructure"
  default     = null
}

variable "aws_secret_key" {
  type        = string
  description = "AWS secret key used to create AWS infrastructure"
  default     = null
}

variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
}

variable "prefix" {
  type        = string
  description = "Prefix added to names of all resources"
  default     = null
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
  default     = null
}

variable "instance_type" {
  type        = string
  description = "Instance type used for all EC2 instances"
  default     = null
}

variable "instance_disk_size" {
  type        = string
  description = "Specify root disk size (GB)"
  default     = null
}

variable "rke2_version" {
  type        = string
  description = "Kubernetes version to use for the RKE2 cluster"
  default     = null
}

variable "rke2_token" {
  description = "Token to use when configuring RKE2 nodes"
  default     = null
}

variable "rke2_config" {
  description = "Additional RKE2 configuration to add to the config.yaml file"
  default     = null
}

variable "kube_config_path" {
  description = "The path to write the kubeconfig for the RKE cluster"
  type        = string
  default     = null
}

variable "kube_config_filename" {
  description = "Filename to write the kube config"
  type        = string
  default     = null
}

variable "rancher_bootstrap_password" {
  description = "Password to use for bootstrapping Rancher (min 12 characters)"
  default     = "initial-admin-password"
  type        = string
}

variable "rancher_password" {
  description = "Password to use for Rancher (min 12 characters)"
  default     = null
  type        = string

  validation {
    condition     = length(var.rancher_password) >= 12
    error_message = "The password provided for Rancher (rancher_password) must be at least 12 characters"
  }
}

variable "rancher_version" {
  description = "Rancher version to install"
  default     = null
  type        = string
}

variable "rancher_replicas" {
  description = "Value for replicas when installing the Rancher helm chart"
  default     = 3
  type        = number
}

variable "create_ssh_key_pair" {
  type        = bool
  description = "Specify if a new SSH key pair needs to be created for the instances"
  default     = null
}

variable "ssh_key_pair_name" {
  type        = string
  description = "Specify the SSH key name to use (that's already present in AWS)"
  default     = null
}

variable "ssh_key_pair_path" {
  type        = string
  description = "Path to the SSH private key used as the key pair (that's already present in AWS)"
  default     = null
}

variable "ssh_username" {
  type        = string
  description = "Username used for SSH with sudo access"
  default     = "ubuntu"
}

variable "spot_instances" {
  type        = bool
  description = "Use spot instances"
  default     = null
}

variable "vpc_id" {
  type        = string   
  description = "VPC ID to create the instance(s) in"                                                                                                                                                                                                    
  default     = null
}

variable "subnet_id" {
  type        = string
  description = "VPC Subnet ID to create the instance(s) in"
  default     = null
}

variable "create_security_group" {
  type        = bool
  description = "Should create the security group associated with the instance(s)"
  default     = null
}

# TODO: Add a check based on above value
variable "instance_security_group" {
  type        = string
  description = "Provide a pre-existing security group ID"
  default     = null
}

variable "wait" {
  description = "An optional wait before installing the Rancher helm chart"
  default     = "20s"
}

variable "ds_rke_cluster_name" {
  description = "The cluster name"
  default     = "rke-ds"
}

variable "ds_rke_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for the RKE2/k3s cluster"
  default     = null
}

variable "ds_rke_ami" {
  default     = null
  description = "AMI to use when launching nodes"

  validation {
    condition     = can(regex("^ami-[[:alnum:]]{10}", var.ds_rke_ami))
    error_message = "The ami value must be a valid AMI id, starting with \"ami-\"."
  }
}

variable "ds_rke_security_group_name" {
  description = "Set downstream SG to use"
}

variable "ds_rke_cni_provider" {
  description = "CNI provider to use"
  default     = "calico"
}

variable "ds_rke_volume_size" {                                                                      
  description = "Specify root volume size (GB)"
  default     = 20 
  type        = number
}

variable "ds_rke2_cluster_name" {
  description = "The cluster name"
  default     = "rke2-ds"
}
  
variable "ds_rke2_kubernetes_version" {
  type        = string
  description = "Kubernetes version to use for the RKE2/k3s cluster"
  default     = null
}
  
variable "ds_rke2_ami" {
  default     = null
  description = "AMI to use when launching nodes"
 
  validation {
    condition     = can(regex("^ami-[[:alnum:]]{10}", var.ds_rke2_ami))
    error_message = "The ami value must be a valid AMI id, starting with \"ami-\"."
  }
}
 
variable "ds_rke2_security_group_name" {
  description = "Set downstream SG to use"
}
 
variable "ds_rke2_cni_provider" {
  description = "CNI provider to use"
  default     = "calico"
}

variable "ds_rke2_volume_size" {
  description = "Specify root volume size (GB)"
  default     = 20
  type        = number
}

variable "do_s3_access" {  
  type        = string
  description = "DO S3 access key"
  default     = null
}
variable "do_s3_secret" {
  type        = string
  description = "DO S3 secret key"
  default     = null
}
variable "do_s3_bucket" {
  type        = string
  description = "DO S3 bucket name"
  default     = null
}
variable "do_s3_region" {
  type        = string
  description = "DO S3 bucket region"
  default     = null
}
variable "do_s3_endpoint" {
  type        = string
  description = "DO S3 bucket region"
  default     = null
}

