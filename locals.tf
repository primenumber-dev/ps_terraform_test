locals {
  customer = {
    environment    = "production"
    airbyte_config = {
      workspace_id = "your_workspace_id"
      source_id    = "your_source_id"
      destination_id = "your_destination_id"
    }
    trocco_config = {
      project_id = "your_project_id"
      api_key    = "your_trocco_api_key"
    }
    aws_glue_config = {
      job_name        = "example_glue_job"
      role_arn        = "arn:aws:iam::123456789012:role/GlueJobRole"
      script_location = "s3://your-bucket/path/to/script.py"
    }
  }
}
