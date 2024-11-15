module "iam" {
  source = "./modules/iams/dts_service_account"

  project_id   = local.project_id
  account_id   = "kono-test-dts-sa"
  display_name = "kono_test_dts_sa"
}

module "kono_test" {
  source     = "./modules/jobs/gcs_to_bq/bq_dts"
  project_id = local.project_id

  # bq設定
  create_bq_dataset = true
  dataset_id        = "stg_kono_playground"

  create_bq_table                       = true
  table_id                              = "stg_covid19_italy_by_province"
  is_delete_contents_on_dataset_destroy = true
  is_table_deletion_protection_enabled  = false

  # dts設定
  entity_name           = "covid19_italy"
  service_account_email = module.iam.dts_service_account_email

  data_path_template = "gs://kono_playground/terraform_playground/covid19_intaly_by_province"
  write_disposition  = "WRITE_TRUNCATE"


  bq_table_schema = [
    { name = "date", type = "TIMESTAMP", mode = "NULLABLE" },
    { name = "country", type = "STRING", mode = "NULLABLE" },
    { name = "region_code", type = "STRING", mode = "NULLABLE" },
    { name = "name", type = "STRING", mode = "NULLABLE" },
    { name = "province_code", type = "STRING", mode = "NULLABLE" },
    { name = "province_name", type = "STRING", mode = "NULLABLE" },
    { name = "province_abbreviation", type = "STRING", mode = "NULLABLE" },
    { name = "latitude", type = "FLOAT", mode = "NULLABLE" },
    { name = "longitude", type = "FLOAT", mode = "NULLABLE" },
    { name = "location_geom", type = "GEOGRAPHY", mode = "NULLABLE" },
    { name = "confirmed_cases", type = "INTEGER", mode = "NULLABLE" },
    { name = "note", type = "STRING", mode = "NULLABLE" }
  ]
}
