# 全体設定
variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "project" {
  description = "label"
  type        = string
  default     = ""
}

# Job設定
variable "entity_name" {
  description = "job target entity name"
  type        = string
}

variable "source_uris" {
  description = "job source uris"
  type        = list(string)
}

# BigQuery設定
variable "create_bq_dataset" {
  description = "Whether to create a BigQuery dataset"
  type        = bool
  default     = false
}

variable "create_bq_table" {
  description = "Whether to create a BigQuery table"
  type        = bool
  default     = false
}

variable "dataset_id" {
  description = "BigQuery Dataset ID"
  type        = string
}

variable "table_id" {
  description = "BigQuery Table ID"
  type        = string
}
