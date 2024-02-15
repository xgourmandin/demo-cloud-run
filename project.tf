resource "google_project_service" "default" {
  for_each = toset(var.services)
  service = each.value
}