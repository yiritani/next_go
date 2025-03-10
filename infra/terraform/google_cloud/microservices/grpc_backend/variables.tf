variable "project_id" {
  type        = string
}

variable "region" {
  description = "GCPのリージョン"
  type        = string
  default     = "us-central1"
}

variable "dockerfile_backend_grpc" {
  description = "バックエンド_grpcのDockerfileパス"
  type        = string
  default     = "apps/backend_grpc/Dockerfile"
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

variable "image_repo" {
  description = "イメージリポジトリ名"
  type        = string
  default     = "next-go"
}