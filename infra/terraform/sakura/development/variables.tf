variable "sakuracloud_api_token" {
  description = "API Token for SakuraCloud"
  type        = string
}

variable "sakuracloud_api_secret" {
  description = "API Secret for SakuraCloud"
  type        = string
}


variable "container_registry_users_name" {
  description = "Container Registry User"
  type        = string
}
variable "container_registry_users_password" {
  description = "Container Registry Password"
  type        = string
}

variable container_registry_users {
  type = list(object({
    name       = string
    password   = string
    permission = string
  }))
  default = [
    {
      name       = "registry_user"
      password   = "registry_password"
      permission = "all"
    },
  ]
}

variable "docker_http_server_archive_id" {
  description = "Docker HTTP Server Archive ID"
  type        = string
}