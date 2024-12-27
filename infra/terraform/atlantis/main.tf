resource "google_compute_network" "default" {
  name                    = "example-networ"
  auto_create_subnetworks = false
  project                 = "next-go-445902"
}