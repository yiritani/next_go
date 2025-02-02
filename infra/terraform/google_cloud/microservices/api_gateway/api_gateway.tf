resource "google_project_service" "api_gateway_api" {
  service = "apigateway.googleapis.com"
  project = var.project_id
  disable_on_destroy = false
}

resource "google_api_gateway_api" "api" {
  depends_on = [google_project_service.api_gateway_api]
  provider = google-beta
  project = var.project_id
  api_id = "next-go-api"
  display_name = "Backend API"
}
