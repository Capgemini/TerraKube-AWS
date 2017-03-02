resource "aws_launch_configuration" "launch_config" {
  name_prefix          = "${var.lc_name}"
  image_id             = "${data.aws_ami.coreos_etcd.image_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.key_name}"
  security_groups      = ["${var.security_group}"]
  user_data            = "${data.template_file.kubeetcd.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}
