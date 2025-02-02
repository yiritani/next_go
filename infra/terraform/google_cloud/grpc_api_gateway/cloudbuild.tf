# TODO: github リポとの接続は画面からやらないとダメなのかもしれない

resource "google_project_service" "cloud_build_api" {
  service = "cloudbuild.googleapis.com"
  project = var.project_id
  disable_on_destroy = false
}

resource "google_cloudbuild_trigger" "backend_grpc" {
  depends_on = [google_project_service.cloud_build_api]

  name = "${var.service_name}-cloudbuild-trigger-backend-grpc"

  substitutions = {
    _IMAGE      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/backend-grpc"
    _REGION     = var.region
    _SERVICE    = var.service_name
    _DOCKERFILE = var.dockerfile_backend_grpc
    _REPO       = var.image_repo
    _CLOUD_RUN_SERVICE = google_cloud_run_service.backend_grpc.name
    _CLOUD_RUN_SERVICE_ACCOUNT = google_service_account.cloudrun_service_account.email
    _NEXT_PUBLIC_API_URL_GRPC = google_cloud_run_service.backend_grpc.status[0].url
  }

  github {
    owner = "yiritani"
    name  = "next_go"
    push {
      branch = "main"
    }
  }

  service_account = google_service_account.cloudbuild_service_account.id
  filename = "cloudbuild.backend_grpc.yaml"
}
