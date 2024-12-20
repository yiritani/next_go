resource "google_cloud_run_service" "backend" {
  name     = "${var.service_name}-cloudrun-backend"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloudrun_service_account.email

      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/backend:latest"
        ports {
          container_port = 8080
        }
      }
    }
  }

  metadata {
    annotations = {
      "run.googleapis.com/client-name" = "terraform"
    }
  }
}