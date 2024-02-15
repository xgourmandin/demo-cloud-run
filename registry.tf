
resource "google_artifact_registry_repository" "default" {
  location      = var.region
  repository_id = "acolad-registry"
  description   = "Docker registry holding Acolad AI Platform services images"
  format        = "DOCKER"
  depends_on    = [google_project_service.default]
}