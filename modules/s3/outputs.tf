output "kube_bucket_arn" {
  value = "${aws_s3_bucket.kubebucket.arn}"
}

output "kube_bucket_id" {
  value = "${aws_s3_bucket.kubebucket.id}"
}

output "dependency" {
  value = "${null_resource.roledependency.id}"
}
