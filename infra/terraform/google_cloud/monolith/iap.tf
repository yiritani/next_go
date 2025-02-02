# resource "google_project_service" "iap_api" {
#   service = "iap.googleapis.com"
#   project = var.project_id
# }
#
# resource "google_iap_brand" "project_brand" {
#   depends_on = [google_project_service.iap_api]
#
#   support_email     = var.support_email
#   application_title = "Cloud IAP protected Application"
#   project           = var.project_id
# }
#
# resource "google_iap_client" "cloudrun_client" {
#   depends_on = [google_project_service.iap_api]
#
#   display_name = "cloudrun_iap_client"
#   brand        = google_iap_brand.project_brand.name
# }
#
# resource "google_iap_web_backend_service_iam_binding" "this" {
#   depends_on = [google_project_service.iap_api]
#
#   project = var.project_id
#   web_backend_service = google_compute_backend_service.frontend_backend.name
#   role = "roles/iap.httpsResourceAccessor"
#   members = [
#     "user:${var.access_user_email}",
#   ]
# }