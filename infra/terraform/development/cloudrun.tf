resource "google_cloud_run_service" "backend" {
  name     = "${var.service_name}-cloudrun-backend"
  location = var.region

  template {
    spec {
      service_account_name = "serviceAccount:cloudrun-sa@${var.project_id}.iam.gserviceaccount.com"

      containers {
        # TODO: こうすることで初回のterraform apply時にcloudbuildとの相互参照を回避できる
        image = "gcr.io/cloudrun/hello"
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
      service_account_name = "serviceAccount:cloudrun-sa@${var.project_id}.iam.gserviceaccount.com"

      containers {
        image = "gcr.io/cloudrun/hello"
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

# フロントエンドのサービスアカウントに限定するIAMポリシー
resource "google_cloud_run_service_iam_member" "allow-frontend-to-backend" {
  location = var.region
  project  = var.project_id
  service  = google_cloud_run_service.backend.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:cloudrun-sa@${var.project_id}.iam.gserviceaccount.com"
}

# フロントエンドは匿名ユーザーからのアクセスを許可 (公開)
data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}
resource "google_cloud_run_service_iam_policy" "noauth-frontend" {
  location    = var.region
  project     = var.project_id
  service     = google_cloud_run_service.frontend.name
  policy_data = data.google_iam_policy.noauth.policy_data
}