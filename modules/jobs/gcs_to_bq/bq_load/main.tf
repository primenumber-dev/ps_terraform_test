resource "google_bigquery_job" "gcs_to_bq_load_job" {
  job_id = "${terraform.workspace}_gcs_to_bq_load_job_${entity_name}_${timestamp()}" # ジョブIDはユニークな値を使用する

  labels = {
    "project" = var.project
  }

  load {
    source_uris = var.source_uris # GCSからのソースURIを指定
    destination_table {
      project_id = var.project_id
      dataset_id = var.dataset_id
      table_id   = var.table_id
    }

    # スキーマを指定する
    schema = [
      {
        name = "date"
        type = "TIMESTAMP"
        mode = "NULLABLE"
      },
      {
        name = "country"
        type = "STRING"
        mode = "NULLABLE"
      },
      {
        name = "confirmed_cases"
        type = "INTEGER"
        mode = "NULLABLE"
      }
    ]

    # その他のロードオプション
    write_disposition = "WRITE_APPEND" # 書き込み方法（WRITE_APPEND, WRITE_TRUNCATE, WRITE_EMPTYなど）
    source_format     = "CSV"          # ソースフォーマット（CSV, NEWLINE_DELIMITED_JSONなど）
    field_delimiter   = ","            # CSVの場合の区切り文字
    skip_leading_rows = 1              # ヘッダー行をスキップ
  }
}
