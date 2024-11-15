# 入力変数を定義
variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
}

variable "project" {
  description = "label"
  type        = string
  default     = ""
}

# DTS設定
variable "entity_name" {
  description = "sync target entity name"
  type        = string
  default     = "every 24 hours"
}

variable "schedule" {
  description = "Schedule for the data transfer in cron format"
  type        = string
  default     = "every 24 hours"
}

variable "service_account_email" {
  description = "ServiceAccount email responsible for this dts job"
  type        = string
  default     = ""
}

variable "skip_leading_rows" {
  description = "skip row count when job start"
  type        = number
  default     = 1
}

variable "max_bad_records" {
  description = "skip row count when job start"
  type        = number
  default     = 0
}

variable "file_format" {
  description = "file_format of source file"
  type        = string
  default     = "CSV"
}

variable "write_disposition" {
  description = "Specifies whether to overwrite or append data when loading into BigQuery."
  type        = string
  default     = "WRITE_APPEND"
  validation {
    condition     = contains(["WRITE_APPEND", "WRITE_TRUNCATE"], var.write_disposition)
    error_message = "write_disposition must be either 'WRITE_APPEND' or 'WRITE_TRUNCATE'."
  }
}

variable "data_path_template" {
  description = "source path"
  type        = string
}

variable "ignore_unknown_values" {
  description = "whether to ignore error caused by unkown column in source"
  type        = bool
  default     = false
}

variable "allow_quoted_newlines" {
  description = "whether to allow quoted new lines in csv"
  type        = bool
  default     = true
}

variable "allow_jagged_rows" {
  description = "whether to ignore error caused by redundant column in source"
  type        = bool
  default     = false
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

variable "is_delete_contents_on_dataset_destroy" {
  description = "Whether to delete all tables in the dataset when destroying"
  type        = bool
  default     = false
}

variable "is_table_deletion_protection_enabled" {
  description = "Whether to enable protection upon deleting instruction"
  type        = bool
  default     = true
}

variable "bq_table_schema" {
  description = "Schema for the BigQuery table as a list of maps"
  type = list(
    object({
      name = string
      type = string
      mode = optional(string, "NULLABLE")
    })
  )
  default = [
    {
      name = "column1"
      type = "STRING"
      mode = "NULLABLE"
    },
    {
      name = "column2"
      type = "INTEGER"
      mode = "NULLABLE"
    }
  ]
}
