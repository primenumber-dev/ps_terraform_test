variable "environment" {
  type = string
}

variable "config" {
  type = map(any)
}

resource "aws_glue_job" "example" {
  name        = var.config["job_name"]
  role_arn    = var.config["role_arn"]
  command {
    name            = "glueetl"
    script_location = var.config["script_location"]
  }
}
