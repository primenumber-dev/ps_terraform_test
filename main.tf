terraform {
  required_providers {
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

# Airbyte用のモジュール呼び出し
module "airbyte" {
  source      = "./modules/airbyte"
  environment = local.customer.environment
  config      = local.customer.airbyte_config
}

# Trocco用のモジュール呼び出し
module "trocco" {
  source      = "./modules/trocco"
  environment = local.customer.environment
  config      = local.customer.trocco_config
}

# AWS Glue用のモジュール呼び出し
module "aws_glue" {
  source      = "./modules/aws/glue"
  environment = local.customer.environment
  config      = local.customer.aws_glue_config
}

