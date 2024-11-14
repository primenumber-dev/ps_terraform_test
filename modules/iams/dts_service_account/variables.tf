variable "project_id" {
  description = "project id"
  type        = string
}

variable "account_id" {
  description = "ServiceAccount account id"
  type        = string
}

variable "display_name" {
  description = "ServiceAccount display name"
  type        = string
}

variable "description" {
  description = "usecase for this service account"
  type        = string
  default     = ""
}
