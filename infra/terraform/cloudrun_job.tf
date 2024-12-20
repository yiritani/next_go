resource "google_cloud_run_v2_job" "job" {
  name     = "${var.service_name}-cloudrun-job"
  location = var.region

  template {
    template {
      service_account = google_service_account.cloudrun_service_account.email
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/job:latest"
        env {
          name  = "NEXT_PUBLIC_API_URL"
          value = "https://backend-service-${var.region}.a.run.app"
        }
      }
    }
  }
}