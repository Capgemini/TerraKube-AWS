output "master_elb" {
  value = "${module.elbcreate.elb_dns_name}"
}

output "kubebucket" {
  value = "${module.s3.kube_bucket_id}"
}

output "default_region" {
  value = "${var.adminregion}"
}
