locals {
  project_id                 = "next-go-445902"
  region                     = "us-central1"
  zone                       = "us-central1-a"
  domain                     = "yiritani.atlantis.com"
  managed_zone               = "yiritani-atlantis-com"

}

# Enable APIs
resource "google_project_service" "service" {
  for_each                   = local.services
  project                    = local.project_id
  service                    = each.value
  disable_dependent_services = false
  disable_on_destroy         = false
}

# Create a service account and attach the required Cloud Logging permissions to it
resource "google_service_account" "atlantis" {
  account_id   = "atlantis-sa"
  display_name = "Service Account for Atlantis"
  project      = local.project_id
}

resource "google_project_iam_member" "atlantis_log_writer" {
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.atlantis.email}"
  project = local.project_id
}

resource "google_project_iam_member" "atlantis_metric_writer" {
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.atlantis.email}"
  project = local.project_id
}

resource "google_compute_network" "default" {
  name                    = "example-network"
  auto_create_subnetworks = false
  project                 = local.project_id
}

resource "google_compute_subnetwork" "default" {
  name                     = "example-subnetwork"
  ip_cidr_range            = "10.2.0.0/16"
  region                   = local.region
  network                  = google_compute_network.default.id
  project                  = local.project_id
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

# Create a router, which we associate the Cloud NAT too
resource "google_compute_router" "default" {
  name    = "example-router"
  region  = google_compute_subnetwork.default.region
  network = google_compute_network.default.name

  bgp {
    asn = 64514
  }
  project = local.project_id
}

# Create a NAT for outbound internet traffic
resource "google_compute_router_nat" "default" {
  name                               = "example-router-nat"
  router                             = google_compute_router.default.name
  region                             = google_compute_router.default.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  project                            = local.project_id
}

module "atlantis" {
  source     = "bschaatsbergen/atlantis/gce"
  name       = "atlantis"
  network    = google_compute_network.default.name
  subnetwork = google_compute_subnetwork.default.name
  region     = local.region
  zone       = local.zone
  service_account = {
    email  = google_service_account.atlantis.email
    scopes = ["cloud-platform"]
  }
  # Note: environment variables are shown in the Google Cloud UI
  # See the `examples/secure-env-vars` if you want to protect sensitive information
  env_vars = {
    ATLANTIS_ATLANTIS_URL       = "https://${local.domain}"
    ATLANTIS_REPO_ALLOWLIST     = local.github_repo_allow_list
    ATLANTIS_WRITE_GIT_CREDS    = true
    ATLANTIS_REPO_CONFIG_JSON   = jsonencode(yamldecode(file("${path.module}/server-atlantis.yaml")))
    ATLANTIS_GH_APP_ID          = local.github_app_id
    ATLANTIS_GH_INSTALLATION_ID = local.github_app_installation_id
    ATLANTIS_GH_WEBHOOK_SECRET  = local.github_webhook_secret
    ATLANTIS_GH_APP_KEY         = local.github_app_key
  }
  domain  = local.domain
  project = local.project_id
}

resource "google_project_service" "enable_dns" {
  project = local.project_id
  service = "dns.googleapis.com"
}
resource "google_dns_managed_zone" "default" {
  depends_on = [google_project_service.enable_dns]

  name        = local.managed_zone
  dns_name    = "${local.domain}."
  description = "Managed zone for ${local.domain}"
  project     = local.project_id
}

# As your DNS records might be managed at another registrar's site, we create the DNS record outside of the module.
# This record is mandatory in order to provision the managed SSL certificate successfully.
resource "google_dns_record_set" "default" {
  depends_on = [google_project_service.enable_dns]

  name         = "${local.domain}."
  type         = "A"
  ttl          = 60
  managed_zone = google_dns_managed_zone.default.name
  rrdatas = [
    module.atlantis.ip_address
  ]
  project = local.project_id
}

resource "google_compute_ssl_policy" "default" {
  name            = "example-ssl-policy"
  profile         = "RESTRICTED"
  min_tls_version = "TLS_1_2"
  project         = local.project_id
}