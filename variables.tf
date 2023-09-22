variable "aws_region" {
  description = "AWS Region"
  type = string
  default = "us-east-1"
}

variable "business_division" {
  description = "Business Division"
  type = string
  default = "devops"
}

variable "environment" {
  description = "Environment"
  type = string
  default = "prod"
}