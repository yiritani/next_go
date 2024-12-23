# resource "google_project_service" "enable_vpc_access_api" {
#   project = var.project_id
#   service = "vpcaccess.googleapis.com"
# }
# resource "google_compute_network" "vpc_network" {
#   name                    = var.vpc_network
#   auto_create_subnetworks = false
# }
# # VPC Connector
# resource "google_vpc_access_connector" "vpc_connector" {
#   name               = "${var.service_name}-connector"
#   region             = var.region
#   network       = google_compute_network.vpc_network.id
#   ip_cidr_range = "10.8.0.0/28"
#   machine_type       = "e2-micro"
#   max_throughput     = 300
#   min_throughput     = 200
#
#   depends_on = [google_project_service.enable_vpc_access_api]
# }