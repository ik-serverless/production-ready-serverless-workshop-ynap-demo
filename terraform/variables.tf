variable "my_name" {
  description = "The name of the student"
  type        = "string"
}

variable "service_name" {
  description = "The name of the student"
  type        = "string"
  default     = "production-ready-serverless"
}

variable "stage" {
  description = "The name of the stage, e.g. dev, staging, prod"
  type        = "string"
  default     = "dev"
}

variable "version" {
  description = "The version of the deployment"
  type        = "string"
}