terraform {
    required_version = ">= 1.5"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.17.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "aws" {
  region = var.aws_region
}