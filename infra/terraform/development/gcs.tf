resource "google_project_service" "gcs_api" {
  project = var.project_id
  service = "storage-component.googleapis.com"
  disable_on_destroy          = true
  disable_dependent_services  = true
}

resource "google_storage_bucket" "bucket" {
    name          = var.bucket_name
    location      = var.region
    project       = var.project_id
    force_destroy = true

    uniform_bucket_level_access = true

    versioning {
        enabled = false
    }

    lifecycle_rule {
        condition {
            age = 30
        }

        action {
            type = "Delete"
        }
    }
}