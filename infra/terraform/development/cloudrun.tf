resource "google_project_service" "cloud_run_api" {
  service = "run.googleapis.com"
  project = var.project_id
}

resource "google_cloud_run_service" "backend" {
  depends_on = [google_project_service.cloud_run_api]

  name     = "${var.service_name}-cloudrun-backend"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloudrun_service_account.email

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
      service_account_name = google_service_account.cloudrun_service_account.email

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

  depends_on = [google_project_service.cloud_run_api]
}
output "frontend_url" {
  value = google_cloud_run_service.frontend.status[0].url
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

# HTTPS Load Balancer (External)
resource "google_compute_region_network_endpoint_group" "app" {
  name                  = "neg-frontend"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.frontend.name
  }
}
# Not classic load balancer
resource "google_compute_url_map" "frontend_url_map" {
  name = "${var.service_name}-url-map"
  default_service = google_compute_backend_service.frontend_backend.self_link


}
resource "google_compute_target_http_proxy" "frontend_http_proxy" {
  name   = "${var.service_name}-http-proxy"
  url_map = google_compute_url_map.frontend_url_map.self_link
}
resource "google_compute_global_forwarding_rule" "frontend_http_forwarding_rule" {
  name                  = "${var.service_name}-http-forwarding-rule"
  target                = google_compute_target_http_proxy.frontend_http_proxy.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
}
resource "google_compute_backend_service" "frontend_backend" {
  name        = "backend-test-app"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 30

  backend {
    group = google_compute_region_network_endpoint_group.app.id
  }
}