locals {
  project_id                 = "next-go-445902"
  region                     = "us-central1"
  zone                       = "us-central1-a"
  domain                     = "yiritani.atlantis.com"
  managed_zone               = "yiritani-atlantis-com"

  github_repo_allow_list     = "github.com/yiritani/next_go"
  github_app_id              = "1096658"
  github_app_installation_id = "Iv23liLGsHqVWQHTYRfb"
  github_webhook_secret      = "Zn2XLZdJ96WgDzuBz4gPRgxm"
  github_app_key             = <<-EOT
    -----BEGIN RSA PRIVATE KEY-----
    MIIEogIBAAKCAQEAss8mFnNM0wJ8t9qklI8mt/RxiQ59dTB9akEnWWm8iAcIRcpl
    hyoLbTvauKAiNY86Mwr073k1Z4MHDA+jHyiDfnsNQMpWEanQDVce61tkOXDS6sT3
    KZYTBionYm9LZVBkkCRHBHOUnv0EfN9VYDB9QMbnts6cpXtb+CwTSF2dEOg1lql+
    /spuvLuKYAUqywsqow7mLQDI5BiEsxR5bM1jXWuWMhEKdnYgOX0Q6lH0qJrEX5Cc
    pNVfPwzT8txWWh5exMalfwbT3fQVN678INDEgDuCf5l3vw338Es+SEDsPww/28LB
    fXKUg8xT5ew3BHxF4wZmXyWw3NUoIqWiVW9QbQIDAQABAoIBAA2RdHVtqF22qZoV
    6Dkxp6F71gWtaM20sT+X1BGP2XOE/Ra2pf+crCNM0GsEE7R2utbWtQFa9Dd3lNhQ
    c3NQ0rGNStMox2EtvpDUlI8Nb0yAiDCyY4LvVWA5YKWyhkkY0ZiyeAUZdCSgVG/Z
    TpQu+cIplbmkcfSIqNDrH0d1ew6mP40enlB7o2774XIARV5RQ2/yCVZaDdR771lw
    64dLguFRxNFDi/rs/cC+RoXyNQN65C2Kqn5TU8+Zx5sDoZXi9+8Skng6bUIMCq4u
    ONqXNJW9rw35Ya5oXvlcTU5g+bNeufQYUWr/MRxDbCnJjUcnfZkeQznbJGDrCbuo
    HTQMDSECgYEA7XtA7NbNR/QYBx7q8o9Up1y8+g+5RWsk2UlcOtoDDL6ZoO+32i2W
    f7fhFAjOeCKQKgSj7uDMXGeUvTXU/7On2OZtX2jr+NF3ogeuUvo8cT/RlufiMl2+
    e5KaX1aJWas0ieVntCKLVEx/tq2SAwmtwDU4porZMIQat3c20MRmfykCgYEAwMCk
    4XqCsI7qbWHbZcLPY6gNY/ySGIZmUdJpfBQZ3OI5D7eYsys5REV7SRu/xOrxcqSz
    VJs47hmJUsW3XL/dVWz32XpjrAZldA0bBATbt1PbzNOP9abNllMfqyx9jYPPnLIi
    JIEEYcGX2l17jrL0k8Cm3aECACnPdgoBfJFu46UCgYAGqfG9c52ZCkluUbjIC6uV
    cq2+2pgZUZNcIYncAOgbAHIxKOjgz2ysss03EbQxfM7MzwqGlnpFkYaD9LHAZxsr
    o/OnvLr6ZW5U9qA2pdzyVJceA+29+hFxSEDasgPypzI3OF+7l0iPmgHvb1lsimX8
    wcGQMs87ZEmXolnAa/JwWQKBgBG0oHCl1ENrnVUW3BRo5Kv+z9wTY0glcFirv0zK
    e+WyUhODhd9PZR9EUqLQjbkE69DgGCj5aS1V4ytbRhCa/zXNoKa1e1pd7AvQ+F5S
    I+yfI12ZQWwLOm9Ii2wp1g6dwQBfzIsV3tUr90rzs1nUTmsUEz/gflKNhKUPHjvX
    EByRAoGABG+6Uf/SUlg5se8SrVspp276KDPRogMWzT/bGXMVSfR6vMK6I4mkkIRp
    dp5JqmT5lVrjBl0fOwt2yeQuNwflyly3dSGEFMY7Roxev98KyYLsU2fNoVMbPIEH
    1/LkLqsqP4Az0Q7tvtcrAM6dz0ffj7aPa/kJhr3/i2Bww4W36Ug=
    -----END RSA PRIVATE KEY-----
  EOT
  services = toset([
    "compute.googleapis.com",
  ])
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

resource "google_dns_managed_zone" "default" {
  name        = local.managed_zone
  dns_name    = "${local.domain}."
  description = "Managed zone for ${local.domain}"
  project     = local.project_id
}

# As your DNS records might be managed at another registrar's site, we create the DNS record outside of the module.
# This record is mandatory in order to provision the managed SSL certificate successfully.
resource "google_project_service" "enable_dns" {
  project = local.project_id
  service = "dns.googleapis.com"
}
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