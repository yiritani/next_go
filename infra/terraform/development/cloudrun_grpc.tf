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

resource "google_cloud_run_service" "frontend_grpc" {
  name     = "${var.service_name}-cloudrun-frontend-grpc"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloudrun_service_account.email

      containers {
        # image = "gcr.io/cloudrun/hello"
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/frontend-grpc"
        env {
          name  = "NEXT_PUBLIC_API_URL"
          value = google_cloud_run_service.backend_grpc.status[0].url
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
      "run.googleapis.com/ingress"     = "internal-and-cloud-load-balancing"
    }
  }

  depends_on = [google_project_service.cloud_run_api]
}
output "frontend_grpc_url" {
  value = google_cloud_run_service.frontend_grpc.status[0].url
}

resource "google_cloud_run_service_iam_policy" "noauth-frontend_grpc" {
  location    = var.region
  project     = var.project_id
  service     = google_cloud_run_service.frontend_grpc.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

# Network Endpoint Group for Cloud Run (Serverless NEG)
resource "google_compute_region_network_endpoint_group" "app_grpc" {
  name                  = "neg-frontend-grpc"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.frontend_grpc.name
  }
}

# Backend Service for Application Load Balancer
resource "google_compute_backend_service" "frontend_backend_grpc" {
  name                  = "frontend-backend-grpc-service"
  protocol              = "HTTP"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_network_endpoint_group.app_grpc.id
  }
}

# URL Map for Application Load Balancer
resource "google_compute_url_map" "frontend_grpc_url_map" {
  name            = "${var.service_name}-url-map-grpc"
  default_service = google_compute_backend_service.frontend_backend_grpc.self_link
}

# Target HTTP Proxy
resource "google_compute_target_http_proxy" "frontend_grpc_http_proxy" {
  name    = "${var.service_name}-http-proxy-grpc"
  url_map = google_compute_url_map.frontend_grpc_url_map.self_link
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "frontend_grpc_http_forwarding_rule" {
  name                  = "${var.service_name}-http-forwarding-rule-grpc"
  target                = google_compute_target_http_proxy.frontend_grpc_http_proxy.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
}
