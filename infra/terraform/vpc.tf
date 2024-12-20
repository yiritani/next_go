# resource "google_compute_network" "vpc" {
#   name = "next-go-vpc"
# }
#
# resource "google_compute_subnetwork" "subnet" {
#   name          = "next-go-subnet"
#   ip_cidr_range = "10.0.0.0/16"
#   network       = google_compute_network.vpc.id
#   region        = var.region
# }
# resource "google_vpc_access_connector" "vpc_connector" {
#   name   = "cloudrun-vpc-connector"
#   region = var.region
#   network = google_compute_network.vpc.name
#   ip_cidr_range = "10.8.0.0/28"
# }