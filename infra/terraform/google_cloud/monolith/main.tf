terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.34.0"
    }
  }
}
provider "google" {
  project = var.project_id
  region  = var.region
}
