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
        # env {
        #   name  = "DATABASE_AUTO_MIGRATION"
        #   value = "true"
        # }
        # env {
        #   name  = "DATABASE_PROTOCOL"
        #   value = "cloudsql"
        # }
        # env {
        #   name  = "DATABASE_HOST"
        #   value = google_sql_database_instance.db_instance.connection_name
        # }
        # env {
        #   name  = "DATABASE_TIMEZONE"
        #   value = "JST"
        # }
        # env {
        #   name  = "DATABASE_NAME"
        #   value = google_sql_database.main_database.name
        # }
        # env {
        #   name  = "DATABASE_USER"
        #   value = google_sql_user.db_user.name
        # }
        # env {
        #   name  = "DATABASE_PASSWORD"
        #   value = var.app_db_user_password
        # }
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
      service_account_name = google_service_account.cloudrun_service_account.email

      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/frontend:latest"
        env {
          name  = "NEXT_PUBLIC_API_URL"
          value = google_cloud_run_service.backend.status[0].url
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