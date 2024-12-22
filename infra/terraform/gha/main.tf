# local 定義
locals {
  github_repository           = "yiritani/next-go"
  project_id                  = "next-go-445113"
  region                      = "us-central1"

  # api 有効化用
  services = toset([                         # Workload Identity 連携用
    "iam.googleapis.com",                  # IAM
    "cloudresourcemanager.googleapis.com", # Resource Manager
    "iamcredentials.googleapis.com",       # Service Account Credentials
    "sts.googleapis.com"                   # Security Token Service API
  ])
}

resource "google_project_service" "enable_iam_credentials_api" {
  project = local.project_id
  service = "iamcredentials.googleapis.com"
}

# provider 設定
terraform {
  required_providers {
    google  = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
  required_version = ">= 1.3.0"
}

## API の有効化(Workload Identity 用)
resource "google_project_service" "enable_api" {
  for_each                   = local.services
  project                    = local.project_id
  service                    = each.value
  disable_dependent_services = true
}

# Workload Identity Pool 設定
resource "google_iam_workload_identity_pool" "gha-pool" {
  provider                  = google-beta
  project                   = local.project_id
  workload_identity_pool_id = "gha-pool"
  display_name              = "gha-pool"
  description               = "GitHub Actions で使用"
}

# Workload Identity Provider 設定
resource "google_iam_workload_identity_pool_provider" "gha-provider" {
  provider                           = google-beta
  project                            = local.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.gha-pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "gha-provider"
  display_name                       = "gha-provider"
  description                        = "GitHub Actions で使用"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_condition = "attribute.repository == '${local.github_repository}'"
}

resource "google_service_account" "terraform_sa" {
  project      = local.project_id
  account_id   = "terraform-sa"
  display_name = "terraform-sa"
}

# GitHub Actions が借用するサービスアカウント
data "google_service_account" "terraform_sa" {
  project    = local.project_id
  account_id = google_service_account.terraform_sa.account_id
}

# サービスアカウントの IAM Policy 設定と GitHub リポジトリの指定
resource "google_service_account_iam_member" "terraform_sa" {
  service_account_id = data.google_service_account.terraform_sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.gha-pool.name}/attribute.repository/${local.github_repository}"
}