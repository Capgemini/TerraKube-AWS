# outputs
output "master_profile_name" {
  value = "${aws_iam_instance_profile.master_profile.id}"
}

output "worker_profile_name" {
  value = "${aws_iam_instance_profile.worker_profile.id}"
}

output "worker_role_name" {
  value = "${var.worker_role_name}"
}

output "master_role_name" {
  value = "${var.master_role_name}"
}

output "dependency" {
  value = "${null_resource.dummy_dependency.id}"
}
