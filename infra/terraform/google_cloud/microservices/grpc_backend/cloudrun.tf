resource "google_cloud_run_service" "frontend" {
  name     = "${var.service_name}-cloudrun-frontend"
  location = var.region

  template {
    spec {
      service_account_name = google_service_account.cloudrun_service_account.email

      containers {
        # image = "gcr.io/cloudrun/hello"
        image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/frontend"
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
output "frontend_url" {
  value = google_cloud_run_service.frontend.status[0].url
}

resource "google_cloud_run_service_iam_policy" "noauth-frontend" {
  location    = var.region
  project     = var.project_id
  service     = google_cloud_run_service.frontend.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_compute_region_network_endpoint_group" "app" {
  depends_on = [google_project_service.cloud_run_api]

  name                  = "neg-frontend"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  cloud_run {
    service = google_cloud_run_service.frontend.name
  }
}

resource "google_compute_backend_service" "frontend_backend" {
  name                  = "frontend-backend-service"
  protocol              = "HTTP"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL"

  backend {
    group = google_compute_region_network_endpoint_group.app.id
  }
}

resource "google_compute_url_map" "frontend_url_map" {
  name            = "${var.service_name}-url-map"
  default_service = google_compute_backend_service.frontend_backend.self_link
}

resource "google_compute_target_http_proxy" "frontend_http_proxy" {
  name    = "${var.service_name}-http-proxy"
  url_map = google_compute_url_map.frontend_url_map.self_link
}

resource "google_compute_global_forwarding_rule" "frontend_http_forwarding_rule" {
  name                  = "${var.service_name}-http-forwarding-rule"
  target                = google_compute_target_http_proxy.frontend_http_proxy.self_link
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
}
