variable "password" { default = "himitsunoString" }

data "sakuracloud_archive" "ubuntu" {
  os_type = "ubuntu2004"
}

resource "sakuracloud_disk" "frontend_disk" {
  name              = "frontend_disk"
  size              = 20
  plan              = "ssd"
  connector         = "virtio"
  source_archive_id = var.docker_http_server_archive_id
  # source_archive_id = data.sakuracloud_archive.ubuntu.id
}

resource "sakuracloud_server" "frontend_srv" {
  depends_on = [sakuracloud_internet.router]
  name        = "frontend_srv"
  disks       = [sakuracloud_disk.frontend_disk.id]
  core        = 1
  memory      = 1
  description = "nextjs"
  tags        = ["tag_1", "tag_2"]

  network_interface {
    upstream = sakuracloud_internet.router.switch_id
    user_ip_address = sakuracloud_internet.router.ip_addresses.3
  }
  disk_edit_parameter {
    hostname = "frontend"
    password = var.password
    disable_pw_auth = false
  }
}

# ルータ+スイッチ
resource "sakuracloud_internet" "router" {
  name = "router"
}

resource "sakuracloud_load_balancer" "lb" {
  name = "next_go_lb"
  plan           = "standard"
  description = "description"
  tags        = ["tag1", "tag2"]

  network_interface {
    switch_id = sakuracloud_internet.router.switch_id
    vrid = 1
    netmask = 24
    ip_addresses = [sakuracloud_internet.router.ip_addresses.1, sakuracloud_internet.router.ip_addresses.2]
  }

  vip {
    vip = sakuracloud_internet.router.ip_addresses.0
    port = 80
    delay_loop = 10
    server {
      ip_address = sakuracloud_server.frontend_srv.ip_address
      protocol = "http"
      path = "/"
      status = 200
    }
  }
}
