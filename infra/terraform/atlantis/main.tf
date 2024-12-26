resource "google_compute_network" "default" {
  name                    = "example-network"
  auto_create_subnetworks = false
  project                 = "next-go-445902"
}

# cloud run
resource "google_cloud_run_service" "default" {
  name     = "example-service"
  location = "us-central1"
  project  = "next-go-445902"

  template {
    spec {
      containers {
        image = "gcr.io/cloudrun/hello"
      }
    }
  }
}