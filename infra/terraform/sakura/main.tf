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
  zone = "tk1v"
}

variable "password" { default = "himitsunoString" }

data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu2004"
}

resource "sakuracloud_disk" "frontend_disk" {
  name              = "frontend_disk"
  size              = 20
  plan              = "ssd"
  connector         = "virtio"
  source_archive_id = data.sakuracloud_archive.ubuntu.id
}

resource "sakuracloud_server" "frontend_srv" {
  name        = "frontend_srv"
  disks       = [sakuracloud_disk.frontend_disk.id]
  core        = 1
  memory      = 1
  description = "nextjs"
  tags        = ["tag_1", "tag_2"]

  network_interface {
    upstream = "shared"
  }
  disk_edit_parameter {
    hostname = "frontend"
    password = var.password
    disable_pw_auth = true
  }
}