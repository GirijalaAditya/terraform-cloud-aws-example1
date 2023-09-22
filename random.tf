resource "random_string" "random_data" {
  length = 6
  lower = true
  upper = false
  special = false
  numeric = false
}