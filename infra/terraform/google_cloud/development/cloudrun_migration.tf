resource "google_cloud_run_v2_job" "migration" {
  name     = "${var.service_name}-cloudrun-migration"
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
