resource "google_artifact_registry_repository" "frontend" {
  description   = "frontend-repo"
  format        = "DOCKER"
  location      = var.region
  repository_id = var.image_repo_frontend
}

resource "google_cloudbuild_trigger" "frontend" {
  name = "${var.service_name}-build-trigger-frontend"

  substitutions = {
    _IMAGE      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo_frontend}"
    _REGION     = var.region
    _SERVICE    = var.service_name
    _DOCKERFILE = var.dockerfile_frontend
    _LOGS       = google_storage_bucket.logs_bucket.url
  }

  github {
    owner = "yiritani"
    name  = "next_go"
    push {
      branch = "main"
    }
  }

  service_account = google_service_account.cloudbuild_service_account.id
  filename = "cloudbuild.yaml"
}

# resource "google_cloud_run_service" "frontend" {
#   name     = "${var.service_name}-frontend"
#   location = var.region
#
#   template {
#     spec {
#       containers {
#         image = "us-central1-docker.pkg.dev/next-go-445113/next-go-frontend:latest"
#         env {
#           name  = "NEXT_PUBLIC_API_URL"
#           value = "https://backend-service-${var.region}.a.run.app"
#         }
#       }
#     }
#   }
#
#   metadata {
#     annotations = {
#       "run.googleapis.com/client-name" = "terraform"
#     }
#   }
# }
