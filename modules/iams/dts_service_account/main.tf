# サービスアカウントの作成
resource "google_service_account" "dts_service_account" {
  account_id   = var.account_id
  display_name = var.display_name
  description  = var.description
}

# サービスアカウントにロールを付与
resource "google_project_iam_binding" "dts_sa_bq_role_binding" {
  project = var.project_id
  role    = "roles/bigquery.admin"

  members = [
    "serviceAccount:${google_service_account.dts_service_account.email}"
  ]
}

resource "google_project_iam_binding" "dts_sa_gcs_role_binding" {
  project = var.project_id
  role    = "roles/storage.objectViewer"

  members = [
    "serviceAccount:${google_service_account.dts_service_account.email}"
  ]
}
