resource "github_actions_variable" "workload_identity_provider" {
  for_each      = toset(var.github_repositories)
  repository    = each.value
  variable_name = "workload_id_provider"
  value         = google_iam_workload_identity_pool_provider.default.name
}

resource "github_actions_variable" "sa_email" {
  for_each      = toset(var.github_repositories)
  repository    = each.value
  variable_name = "service_account_email"
  value         = google_service_account.default.email
}
