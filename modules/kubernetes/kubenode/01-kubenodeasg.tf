data "template_file" "kubenode" {
  template = "${file("${path.module}/${var.userdata}")}"

  vars {
    region              = "${var.adminregion}"
    internal-tld        = "${ var.internal-tld }"
    region              = "${ var.adminregion }"
    bucket              = "${ var.bucketname }"
    cacertobject        = "${var.capem}"
    kubenodecertobject  = "${var.kubenodepem}"
    kubenodekeyobject   = "${var.kubenodekey}"
    etcdcertobject      = "${var.etcdpem}"
    etcdkeyobject       = "${var.etcdkey}"
    etcdproxycertobject = "${var.etcdproxypem}"
    etcdproxykeyobject  = "${var.etcdproxykey}"
    etcd_memberlist     = "${join(",", concat(formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az1), values(var.etcd_nodes_az1)), formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az2), values(var.etcd_nodes_az2)), formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az3), values(var.etcd_nodes_az3)) ))}"
    kubernetes_image    = "${element(split(":", var.kubernetes_image), 0)}"
    kubernetes_version  = "${element(split(":", var.kubernetes_image), 1)}"
    master-elb-dns      = "${var.master_elb_dns}"
  }
}

data "aws_ami" "coreos_kubenode" {
  most_recent = true

  owners = ["${var.ownerid}"]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["${var.virtualization_type}"]
  }

  filter {
    name   = "name"
    values = ["${var.ami_name}-${var.channel}-*"]
  }
}

resource "aws_launch_configuration" "launch_config" {
  name_prefix          = "${var.lc_name}"
  image_id             = "${data.aws_ami.coreos_kubenode.image_id}"
  instance_type        = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name             = "${var.key_name}"
  security_groups      = ["${var.security_group}"]
  user_data            = "${data.template_file.kubenode.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "kubenode" {
  depends_on = ["aws_launch_configuration.launch_config"]
  name       = "${var.asg_name}"

  availability_zones  = ["${var.azs}"]
  vpc_zone_identifier = ["${var.subnet_azs}"]

  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_number_of_instances}"
  min_size                  = "${var.asg_minimum_number_of_instances}"
  desired_capacity          = "${var.asg_number_of_instances}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"

  tag {
    key                 = "Name"
    value               = "kubenode"
    propagate_at_launch = true
  }

  tag {
    key                 = "KubernetesCluster"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}
