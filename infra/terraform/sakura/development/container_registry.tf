# resource "sakuracloud_container_registry" "next_go" {
#   name            = "next-go"
#   subdomain_label = "nextgob"
#   access_level    = "readwrite"
#
#   description = "description"
#   tags        = ["tag1", "tag2"]
#
#   dynamic "user" {
#     for_each = var.container_registry_users
#     content {
#       name       = user.value.name
#       password   = user.value.password
#       permission = user.value.permission
#     }
#   }
# }