variable "project_id" {
  type        = string
}

variable "region" {
  description = "GCPのリージョン"
  type        = string
  default     = "us-central1"
}