terraform {
  required_providers {
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "2.16.2"
    }
  }
}

provider "sakuracloud" {
  token  = var.sakuracloud_api_token
  secret = var.sakuracloud_api_secret
  zone = "is1b"
  # zone = "tk1v"
}
