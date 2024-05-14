terraform {
  required_providers {
    ssh = {
      source  = "loafoe/ssh"
      version = "2.6.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.13.1"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = ">= 3.1.1"
    }
  }
} 
