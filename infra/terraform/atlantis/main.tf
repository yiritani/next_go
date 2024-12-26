resource "google_compute_network" "default2" {
  name                    = "example-network2"
  auto_create_subnetworks = false
  project                 = "next-go-445902"
}