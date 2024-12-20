resource "google_cloudbuild_trigger" "backend" {
  name = "${var.service_name}-build-trigger-backend"

  substitutions = {
    _IMAGE      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/backend"
    _REGION     = var.region
    _SERVICE    = var.service_name
    _DOCKERFILE = var.dockerfile_backend
    _REPO       = var.image_repo
  }

  github {
    owner = "yiritani"
    name  = "next_go"
    push {
      branch = "main"
    }
  }

  service_account = google_service_account.cloudbuild_service_account.id
  filename = "cloudbuild.backend.yaml"
}

resource "google_cloud_run_service" "backend" {
  name     = "${var.service_name}-cloudrun-backend"
  location = var.region

  template {
    spec {
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