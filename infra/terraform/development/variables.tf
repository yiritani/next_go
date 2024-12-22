variable "project_id" {
  description = "next-go-445113"
  type        = string
  default     = "next-go-445113"
}

variable "region" {
  description = "GCPのリージョン"
  type        = string
  default     = "us-central1"
}

variable "dockerfile_backend" {
  description = "バックエンドのDockerfileパス"
  type        = string
  default     = "apps/backend/Dockerfile"
}

variable "dockerfile_frontend" {
  description = "フロントエンドのDockerfileパス"
  type        = string
  default     = "apps/frontend/Dockerfile"
}

variable "dockerfile_job" {
  description = "jobのDockerfileパス"
  type        = string
  default     = "apps/job/Dockerfile"
}

variable "service_name" {
  description = "サービス名"
  type        = string
  default     = "next-go"
}

variable "image_repo" {
  description = "イメージリポジトリ名"
  type        = string
  default     = "next-go"
}

# variable "app_db_user_password" {
#   type = string
# }