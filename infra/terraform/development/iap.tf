resource "google_iap_brand" "project_brand" {
  support_email     = var.support_email
  application_title = "Cloud IAP protected Application"
  project           = var.project_id
}

resource "google_iap_client" "cloudrun_client" {
  display_name = "cloudrun_iap_client"
  brand        = google_iap_brand.project_brand.name
}

resource "google_iap_web_backend_service_iam_binding" "this" {
  project = var.project_id
  web_backend_service = google_compute_backend_service.frontend_backend.name
  role = "roles/iap.httpsResourceAccessor"
  members = [
    "user:${var.access_user_email}",
  ]
}