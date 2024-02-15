resource "google_service_account" "default" {
  account_id = "${local.ressource_prefix}-sa"
}

locals {
  authorized_repo = [for r in var.github_repositories : "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.default.name}/attribute.repository/acoladgroup/${r}"]
}

resource "google_service_account_iam_binding" "default" {
  members            = local.authorized_repo
  role               = "roles/iam.workloadIdentityUser"
  service_account_id = google_service_account.default.name
}

resource "google_project_iam_binding" "default" {
  members = [
    "serviceAccount:${google_service_account.default.email}",
  ]
  role    = "roles/editor"
  project = var.gcp_project_id
}
