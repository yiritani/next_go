provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "cloudbuild_service_account" {
  account_id   = "cloudbuild-sa"
  display_name = "cloudbuild-sa"
  description  = "Cloud build service account"
}
