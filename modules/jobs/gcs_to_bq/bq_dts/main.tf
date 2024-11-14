# BigQuery Datasetの作成（オプション）
resource "google_bigquery_dataset" "gcs_to_bigquery" {
  count       = var.create_bq_dataset ? 1 : 0
  dataset_id  = var.dataset_id
  description = "Dataset for ${terraform.workspace} workspace"
}

# BigQuery Tableの作成（オプション）
resource "google_bigquery_table" "gcs_to_bigquery" {
  count      = var.create_bq_table ? 1 : 0
  dataset_id = var.dataset_id
  table_id   = var.table_id

  schema = jsonencode(var.bq_table_schema)
}

# BigQuery Data Transfer Serviceの設定
resource "google_bigquery_data_transfer_config" "gcs_to_bigquery" {
  destination_dataset_id = var.dataset_id
  display_name           = "${terraform.workspace}_${var.entity_name}_gcs_to_bq_job"
  data_source_id         = "google_cloud_storage"

  params               = merge(local.default_dts_params, var.dts_params)
  service_account_name = var.service_account_email

  schedule = var.schedule
}

# デフォルトのDTS params定義
locals {
  default_dts_params = {
    destination_table_name_template = var.table_id
    write_disposition               = "MIRROR" # ソースがgcsの場合はAPPEND | MIRROR
    file_format                     = "CSV"
    skip_leading_rows               = 1
    max_bad_records                 = 0
    ignore_unknown_values           = false
    allow_quoted_newlines           = true
    allow_jagged_rows               = false
  }
}
