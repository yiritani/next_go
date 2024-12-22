resource "google_cloudbuild_trigger" "backend" {
  name = "${var.service_name}-build-trigger-backend"

  substitutions = {
    _IMAGE      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/backend"
    _REGION     = var.region
    _SERVICE    = var.service_name
    _DOCKERFILE = var.dockerfile_backend
    _REPO       = var.image_repo
    _CLOUD_RUN_SERVICE = google_cloud_run_service.backend.name
    _CLOUD_RUN_SERVICE_ACCOUNT = "serviceAccount:cloudrun-sa@${var.project_id}.iam.gserviceaccount.com"
  }

  github {
    owner = "yiritani"
    name  = "next_go"
    push {
      branch = "main"
    }
  }

  service_account = "serviceAccount:cloudbuild-sa@${var.project_id}.iam.gserviceaccount.com"
  filename = "cloudbuild.backend.yaml"
}

resource "google_cloudbuild_trigger" "frontend" {
  name = "${var.service_name}-build-trigger-frontend"

  substitutions = {
    _IMAGE      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/frontend"
    _REGION     = var.region
    _SERVICE    = var.service_name
    _DOCKERFILE = var.dockerfile_frontend
    _REPO       = var.image_repo
    _CLOUD_RUN_SERVICE = google_cloud_run_service.frontend.name
    _CLOUD_RUN_SERVICE_ACCOUNT = "serviceAccount:cloudrun-sa@${var.project_id}.iam.gserviceaccount.com"
    _NEXT_PUBLIC_API_URL = google_cloud_run_service.backend.status[0].url
  }

  github {
    owner = "yiritani"
    name  = "next_go"
    push {
      branch = "main"
    }
  }

  service_account = "serviceAccount:cloudbuild-sa@${var.project_id}.iam.gserviceaccount.com"
  filename = "cloudbuild.frontend.yaml"
}

resource "google_cloudbuild_trigger" "job" {
  name = "${var.service_name}-build-trigger-job"

  substitutions = {
      _IMAGE      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/job"
      _REGION     = var.region
      _SERVICE    = var.service_name
      _DOCKERFILE = var.dockerfile_job
      _REPO       = var.image_repo
      _CLOUD_RUN_SERVICE = google_cloud_run_v2_job.job.name
      _CLOUD_RUN_SERVICE_ACCOUNT = "serviceAccount:cloudrun-sa@${var.project_id}.iam.gserviceaccount.com"
  }

  github {
    owner = "yiritani"
    name  = "next_go"
    push {
      branch = "main"
    }
  }

  service_account = "serviceAccount:cloudbuild-sa@${var.project_id}.iam.gserviceaccount.com"
  filename = "cloudbuild.job.yaml"
}
