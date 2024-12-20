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