variable "airbyte_api_key" {
  description = "Airbyte API Key"
  type        = string
  sensitive   = true
}

variable "trocco_api_key" {
  description = "Trocco API Key"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}
