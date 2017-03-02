# outputs
output "elb_id" {
  value = "${aws_elb.kube_master.id}"
}

output "elb_name" {
  value = "${aws_elb.kube_master.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.kube_master.dns_name}"
}
