# local 定義
locals {
  github_repository           = "yiritani/next-go"
  project_id                  = "next-go-445113"
  region                      = "us-central1"
  terraform_service_account   = "terraform-sa@next-go-445113.iam.gserviceaccount.com"

  # api 有効化用
  services = toset([                         # Workload Identity 連携用
    "iam.googleapis.com",                  # IAM
    "cloudresourcemanager.googleapis.com", # Resource Manager
    "iamcredentials.googleapis.com",       # Service Account Credentials
    "sts.googleapis.com"                   # Security Token Service API
  ])
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
resource "google_iam_workload_identity_pool" "mypool" {
  provider                  = google-beta
  project                   = local.project_id
  workload_identity_pool_id = "mypool"
  display_name              = "mypool"
  description               = "GitHub Actions で使用"
}

# Workload Identity Provider 設定
resource "google_iam_workload_identity_pool_provider" "myprovider" {
  provider                           = google-beta
  project                            = local.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.mypool.workload_identity_pool_id
  workload_identity_pool_provider_id = "myprovider"
  display_name                       = "myprovider"
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

# GitHub Actions が借用するサービスアカウント
data "google_service_account" "terraform_sa" {
  account_id = local.terraform_service_account
}

# サービスアカウントの IAM Policy 設定と GitHub リポジトリの指定
resource "google_service_account_iam_member" "terraform_sa" {
  service_account_id = data.google_service_account.terraform_sa.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.mypool.name}/attribute.repository/${local.github_repository}"
}