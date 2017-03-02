resource "null_resource" "dummy_dependency" {
  depends_on = [
    "aws_iam_role.master_role",
    "aws_iam_role_policy.master_policy",
    "aws_iam_role.worker_role",
    "aws_iam_role_policy.worker_policy",
  ]
}
