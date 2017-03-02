//
// Module: tf_aws_asg
//

// Output the ID of the Launch Config
output "launch_config_id" {
  value = "${aws_launch_configuration.launch_config.id}"
}

// Output the ID of the Launch Config
output "asg_az1_id" {
  value = "${aws_autoscaling_group.etcd_asg_az1.id}"
}

output "asg_az2_id" {
  value = "${aws_autoscaling_group.etcd_asg_az2.id}"
}

output "asg_az3_id" {
  value = "${aws_autoscaling_group.etcd_asg_az3.id}"
}
