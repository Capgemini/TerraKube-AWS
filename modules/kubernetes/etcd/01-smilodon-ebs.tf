## Etcd EBS volumes
resource "aws_ebs_volume" "etcd_volumes_az1" {
  count = "${var.asg_maxsize_az1}"

  availability_zone = "${var.az1}"
  encrypted         = "${var.ebs_encrypted}"
  size              = "${var.ebs_size}"
  type              = "${var.ebs_type}"

  tags {
    Role              = "etcd-data"
    Env               = "${var.environment}"
    KubernetesCluster = "${ var.name }"
    Name              = "${var.environment}-etcd-node${count.index}"
    NodeID            = "${count.index}"
    builtWith         = "terraform"
  }
}

resource "aws_ebs_volume" "etcd_volumes_az2" {
  count = "${var.asg_maxsize_az2}"

  availability_zone = "${var.az2}"
  encrypted         = "${var.ebs_encrypted}"
  size              = "${var.ebs_size}"
  type              = "${var.ebs_type}"

  tags {
    Role              = "etcd-data"
    Env               = "${var.environment}"
    KubernetesCluster = "${ var.name }"
    Name              = "${var.environment}-etcd-node${count.index}"
    NodeID            = "${count.index + aws_ebs_volume.etcd_volumes_az1.count}"
    builtWith         = "terraform"
  }
}

resource "aws_ebs_volume" "etcd_volumes_az3" {
  count = "${var.asg_maxsize_az3}"

  availability_zone = "${var.az3}"
  encrypted         = "${var.ebs_encrypted}"
  size              = "${var.ebs_size}"
  type              = "${var.ebs_type}"

  tags {
    Role              = "etcd-data"
    Env               = "${var.environment}"
    KubernetesCluster = "${ var.name }"
    Name              = "${var.environment}-etcd-node${count.index}"
    NodeID            = "${count.index + aws_ebs_volume.etcd_volumes_az1.count + aws_ebs_volume.etcd_volumes_az2.count}"
    builtWith         = "terraform"
  }
}
