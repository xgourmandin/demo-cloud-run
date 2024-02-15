resource "google_cloud_run_v2_service" "caller" {
  location = var.region
  name     = "caller-api"

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }

  ingress = "INGRESS_TRAFFIC_ALL"

  depends_on = [google_project_service.default]
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "caller_noauth" {
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
      image = "us-docker.pkg.dev/cloudrun/container/hello"
    }
  }

  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  depends_on = [google_project_service.default]
}

resource "google_cloud_run_v2_service_iam_policy" "callee_noauth" {
  location    = google_cloud_run_v2_service.callee.location
  project     = google_cloud_run_v2_service.callee.project
  name        = google_cloud_run_v2_service.callee.name

  policy_data = data.google_iam_policy.noauth.policy_data
}
