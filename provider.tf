
terraform {
  required_version = "1.9.8"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "6.11.1"
    }
    trocco = {
      source = "registry.terraform.io/trocco-io/trocco"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

provider "google" {
  project = "pn-playground"
}
