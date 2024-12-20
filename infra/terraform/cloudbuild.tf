resource "google_cloudbuild_trigger" "job" {
  name = "${var.service_name}-build-trigger-job"

  substitutions = {
      _IMAGE      = "${var.region}-docker.pkg.dev/${var.project_id}/${var.image_repo}/job"
      _REGION     = var.region
      _SERVICE    = var.service_name
      _DOCKERFILE = var.dockerfile_job
      _REPO       = var.image_repo
      # _CLOUD_RUN_SERVICE = google_cloud_run_v2_job.job.name
      _CLOUD_RUN_SERVICE_ACCOUNT = google_service_account.cloudrun_service_account.email
  }

  github {
    owner = "yiritani"
    name  = "next_go"
    push {
      branch = "main"
    }
  }

  service_account = google_service_account.cloudbuild_service_account.id
  filename = "cloudbuild.job.yaml"
}
