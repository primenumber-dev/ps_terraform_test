terraform {
  backend "s3" {
    bucket  = "terraform-state-bucket"
    key     = "terraform.state.test"
    region  = "ap-northeast-1"
    profile = "test"
  }
}
