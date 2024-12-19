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
  default     = "../apps/backend/Dockerfile"
}

variable "dockerfile_frontend" {
  description = "フロントエンドのDockerfileパス"
  type        = string
  default     = "apps/frontend/Dockerfile"
}

variable "service_name" {
  description = "サービス名"
  type        = string
  default     = "next-go"
}

variable "image_repo_frontend" {
  description = "イメージリポジトリ名"
  type        = string
  default     = "next-go-frontend"
}