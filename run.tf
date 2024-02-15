resource "google_cloud_run_v2_service" "caller" {
  location = var.region
  name     = "caller-api"

  template {
    containers {
      image = "europe-west1-docker.pkg.dev/${var.project_id}/perso-registry/caller-api"
    }
  }

  ingress = "INGRESS_TRAFFIC_ALL"

}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "noauth" {
  location    = google_cloud_run_v2_service.caller.location
  project     = google_cloud_run_v2_service.caller.project
  name        = google_cloud_run_v2_service.caller.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_cloud_run_v2_service" "callee" {
  location = var.region
  name     = "callee-api"

  template {
    containers {
      image = "europe-west1-docker.pkg.dev/${var.project_id}/perso-registry/callee-api"
    }
  }

  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"
}

resource "google_cloud_run_v2_service_iam_policy" "noauth" {
  location    = google_cloud_run_v2_service.callee.location
  project     = google_cloud_run_v2_service.callee.project
  name        = google_cloud_run_v2_service.callee.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
