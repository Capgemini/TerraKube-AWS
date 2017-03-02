resource "aws_autoscaling_group" "etcd_asg_az1" {
  depends_on = ["aws_launch_configuration.launch_config"]
  name       = "${var.asg_name_az1}"

  availability_zones  = ["${var.az1}"]
  vpc_zone_identifier = ["${var.subnet_in_az1}"]

  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_maxsize_az1}"
  min_size                  = "${var.asg_minsize_az1}"
  desired_capacity          = "${var.asg_normsize_az1}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  load_balancers            = ["${var.master_elb}"]

  tag {
    key                 = "Name"
    value               = "etcd-cluster-az1"
    propagate_at_launch = true
  }

  tag {
    key                 = "KubernetesCluster"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "etcd_asg_az2" {
  depends_on = ["aws_launch_configuration.launch_config"]
  name       = "${var.asg_name_az2}"

  availability_zones  = ["${var.az2}"]
  vpc_zone_identifier = ["${var.subnet_in_az2}"]

  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_maxsize_az2}"
  min_size                  = "${var.asg_minsize_az2}"
  desired_capacity          = "${var.asg_normsize_az2}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  load_balancers            = ["${var.master_elb}"]

  tag {
    key                 = "Name"
    value               = "etcd-cluster-az2"
    propagate_at_launch = true
  }

  tag {
    key                 = "KubernetesCluster"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "etcd_asg_az3" {
  depends_on = ["aws_launch_configuration.launch_config"]
  name       = "${var.asg_name_az3}"

  availability_zones  = ["${var.az3}"]
  vpc_zone_identifier = ["${var.subnet_in_az3}"]

  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size                  = "${var.asg_maxsize_az3}"
  min_size                  = "${var.asg_minsize_az3}"
  desired_capacity          = "${var.asg_normsize_az3}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  load_balancers            = ["${var.master_elb}"]

  tag {
    key                 = "Name"
    value               = "etcd-cluster-az3"
    propagate_at_launch = true
  }

  tag {
    key                 = "KubernetesCluster"
    value               = "${var.name}"
    propagate_at_launch = true
  }
}
