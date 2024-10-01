variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "cluster_uri" {
  description = "Cluster endpoint"
  type = string
}

variable "lambda_auth" {
  description = "Lambda authorizer ARN"
  type = string
}