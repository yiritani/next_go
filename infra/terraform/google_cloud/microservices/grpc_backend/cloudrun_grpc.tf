resource "google_project_service" "cloud_run_api" {
  service = "run.googleapis.com"
  project = var.project_id

  disable_on_destroy = false
}

resource "google_cloud_run_service" "backend_grpc" {
  depends_on = [google_project_service.cloud_run_api]

  name     = "${var.service_name}-cloudrun-backend-grpc"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloudrun_service_account.email

      containers {
        # image = "gcr.io/cloudrun/hello"
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/backend-grpc"
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

output "backend_grpc_url" {
  value = google_cloud_run_service.backend_grpc.status[0].url
}
resource "google_cloud_run_service_iam_policy" "noauth-backend_grpc" {
  location    = var.region
  project     = var.project_id
  service     = google_cloud_run_service.backend_grpc.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}