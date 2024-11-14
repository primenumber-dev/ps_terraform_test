# 入力変数を定義
variable "project_id" {
  description = "Google Cloud Project ID"
  type        = string
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

# DTSのparamsをmap型で定義
variable "dts_params" {
  description = "Parameters for BigQuery Data Transfer Service"
  type        = map(string)
  default = {
    write_disposition               = "WRITE_APPEND"
    destination_table_name_template = "your_table"
    data_path_template              = "gs://your_bucket/your_data_path"
    file_format                     = "CSV"
    skip_leading_rows               = "1"
  }
}

# BigQueryテーブルのスキーマをリストのマップで定義
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
