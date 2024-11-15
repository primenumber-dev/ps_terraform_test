# BigQuery Datasetの作成（オプション）
resource "google_bigquery_dataset" "gcs_to_bigquery" {
  count                      = var.create_bq_dataset ? 1 : 0
  dataset_id                 = var.dataset_id
  description                = "Dataset for ${terraform.workspace} workspace"
  delete_contents_on_destroy = var.is_delete_contents_on_dataset_destroy
}

# BigQuery Tableの作成（オプション）
resource "google_bigquery_table" "gcs_to_bigquery" {
  count               = var.create_bq_table ? 1 : 0
  dataset_id          = var.dataset_id
  table_id            = var.table_id
  deletion_protection = var.is_table_deletion_protection_enabled
  depends_on          = [google_bigquery_dataset.gcs_to_bigquery[0]]

  schema = jsonencode(var.bq_table_schema)
}

# BigQuery Data Transfer Serviceの設定
resource "google_bigquery_data_transfer_config" "gcs_to_bigquery" {
  depends_on = [google_bigquery_dataset.gcs_to_bigquery[0]]

  destination_dataset_id = var.dataset_id
  display_name           = "${terraform.workspace}_${var.entity_name}_gcs_to_bq_job"
  data_source_id         = "google_cloud_storage"

  params = {
    destination_table_name_template = var.table_id
    data_path_template              = var.data_path_template
    skip_leading_rows               = var.skip_leading_rows
    max_bad_records                 = var.max_bad_records
    file_format                     = var.file_format
    write_disposition               = local.transformed_write_disposition
    ignore_unknown_values           = var.ignore_unknown_values
    allow_quoted_newlines           = var.allow_quoted_newlines
    allow_jagged_rows               = var.allow_jagged_rows
  }
  service_account_name = var.service_account_email

  schedule = var.schedule
}

# デフォルトのDTS params定義
locals {
  transformed_write_disposition = (
    var.write_disposition == "WRITE_APPEND" ? "APPEND" :
    var.write_disposition == "WRITE_TRUNCATE" ? "MIRROR" :
    null
  )
}
