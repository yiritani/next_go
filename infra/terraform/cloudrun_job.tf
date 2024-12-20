resource "google_cloud_run_v2_job" "job" {
  name     = "${var.service_name}-cloudrun-job"
  location = var.region

  template {
    template {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/job:latest"
      }
    }
  }
}