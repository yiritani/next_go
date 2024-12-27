resource "google_compute_network" "default" {
  name                    = "example-network2"
  auto_create_subnetworks = false
  project                 = "next-go-445902"
}