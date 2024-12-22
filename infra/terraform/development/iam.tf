resource "google_project_service" "enable_iam_credentials_api" {
    project = var.project_id
    service = "iamcredentials.googleapis.com"
}

resource "google_service_account" "cloudbuild_service_account" {
  account_id   = "cloudbuild-sa"
  display_name = "cloudbuild-sa"
  description  = "Cloud build service account"
}
resource "google_service_account" "cloudrun_service_account" {
  account_id   = "cloudrun-sa"
  display_name = "cloudrun-sa"
  description  = "Cloud run service account"
}
resource "google_service_account" "job_service_account" {
  account_id   = "job-sa"
  display_name = "job-sa"
}

resource "google_project_iam_member" "logs_logging_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}

resource "google_project_iam_member" "artifact_registry_writer" {
  project = var.project_id
  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}
resource "google_project_iam_member" "artifact_registry_reader" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}
resource "google_project_iam_member" "artifact_registry_writer_job" {
  project = var.project_id
  role   = "roles/artifactregistry.writer"
  member = "serviceAccount:${google_service_account.job_service_account.email}"
}
resource "google_project_iam_member" "artifact_registry_reader_job" {
  project = var.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.job_service_account.email}"
}

resource "google_project_iam_member" "cloud_run_developer" {
  project = var.project_id
  role    = "roles/run.developer"
  member  = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}
resource "google_service_account_iam_member" "cloudrun_service_account_user" {
    service_account_id = google_service_account.cloudrun_service_account.id
    role               = "roles/iam.serviceAccountUser"
    member             = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}
resource "google_service_account_iam_member" "job_service_account_user" {
  service_account_id = google_service_account.job_service_account.id
  role               = "roles/iam.serviceAccountUser"
  member             = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}

# data "google_iam_policy" "backend_invoker" {
#   binding {
#     role    = "roles/run.invoker"
#     members = [
#       "serviceAccount:${google_service_account.cloudrun_service_account.email}",
#       "serviceAccount:${google_service_account.job_service_account.email}"
#     ]
#   }
# }
# resource "google_cloud_run_service_iam_policy" "restrict-backend" {
#   location    = var.region
#   project     = var.project_id
#   service     = google_cloud_run_service.backend.name
#   policy_data = data.google_iam_policy.backend_invoker.policy_data
# }