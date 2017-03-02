output "master_elb" {
  value = "${module.elbcreate.elb_dns_name}"
}
