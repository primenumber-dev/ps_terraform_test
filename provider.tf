
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.65"
    }
    trocco = {
      source = "registry.terraform.io/trocco-io/trocco"
    }
  }
}

provider "aws" {
  region = local.customer.aws_region
}

provider "google" {
  project = local.customer.gcp_project
  region  = local.customer.gcp_region
}

provider "trocco" {
  api_key = var.trocco_api_key
  region  = "japan"
}