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
output "backend_url" {
  value = google_cloud_run_service.backend.status[0].url
}

resource "google_cloud_run_service" "frontend" {
  name     = "${var.service_name}-cloudrun-frontend"
  location = var.region

  template {
    spec {
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/frontend:latest"
        env {
          name  = "NEXT_PUBLIC_API_URL"
          value = "https://backend-service-${var.region}.a.run.app"
        }
        ports {
          container_port = 3000
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
output "frontend_url" {
  value = google_cloud_run_service.frontend.status[0].url
}

data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}
resource "google_cloud_run_service_iam_policy" "noauth-frontend" {
  location = var.region
  project  = var.project_id
  service  = google_cloud_run_service.frontend.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
resource "google_cloud_run_service_iam_policy" "noauth-backend" {
  location = var.region
  project  = var.project_id
  service  = google_cloud_run_service.backend.name
  policy_data = data.google_iam_policy.noauth.policy_data
}