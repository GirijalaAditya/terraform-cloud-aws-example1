locals {
  business_division = var.business_division
  environment = var.environment
  prefix = "${var.business_division}-${var.environment}"
  common_tags = {
    Environment = local.environment
    "Business_Division" = local.business_division
  }
}