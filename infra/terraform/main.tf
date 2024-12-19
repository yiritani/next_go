provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "cloudbuild_service_account" {
  account_id   = "cloudbuild-sa"
  display_name = "cloudbuild-sa"
  description  = "Cloud build service account"
}

resource "google_storage_bucket" "logs_bucket" {
  name                        = "${var.project_id}-build-logs"
  location                    = var.region
  storage_class               = "STANDARD"
  force_destroy               = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 30
    }
  }
}

resource "google_storage_bucket_iam_binding" "logs_bucket_writer" {
  bucket = "next-go-445113-build-logs"
  role = "roles/storage.objectAdmin"

  members = [
    "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
  ]
}