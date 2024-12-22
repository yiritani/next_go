resource "google_cloud_run_v2_job" "job" {
  name     = "${var.service_name}-cloudrun-job"
  location = var.region

  template {
    template {
      service_account = google_service_account.job_service_account.email

      containers {
        image = "gcr.io/cloudrun/hello"
        env {
          name  = "NEXT_PUBLIC_API_URL"
          value = google_cloud_run_service.backend.status[0].url
        }
      }
    }
  }
}

# resource "google_project_service" "enable_cloud_scheduler" {
#   project = var.project_id
#   service = "cloudscheduler.googleapis.com"
# }
resource "google_cloud_scheduler_job" "cloud_run_job_trigger" {
  # depends_on = [google_project_service.enable_cloud_scheduler]

  name             = "${var.service_name}-cloud-run-job-trigger"
  description      = "Trigger Cloud Run Job on a schedule"
  schedule         = "0 12 * * *"
  time_zone        = "Etc/UTC"

  http_target {
    uri             = "https://${var.region}-run.googleapis.com/apis/run.googleapis.com/v2/projects/${var.project_id}/locations/${var.region}/jobs/${google_cloud_run_v2_job.job.name}:run"
    http_method     = "POST"

    oidc_token {
      service_account_email = google_service_account.scheduler_service_account.email
      audience              = "https://${var.region}-run.googleapis.com/"
    }
  }
}

resource "google_service_account" "scheduler_service_account" {
  account_id   = "scheduler-sa"
  display_name = "scheduler-sa"
}
resource "google_project_iam_member" "scheduler_invoker" {
  project = var.project_id
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.scheduler_service_account.email}"
}