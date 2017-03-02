data "template_file" "kubeetcd" {
  template = "${file("${path.module}/${var.userdata}")}"

  vars {
    internal-tld         = "${ var.internal-tld }"
    region               = "${ var.adminregion }"
    bucket               = "${ var.bucketname }"
    cacertobject         = "${var.capem}"
    etcdcertobject       = "${var.etcdpem}"
    etcdkeyobject        = "${var.etcdkey}"
    mastercertobject     = "${var.masterpem}"
    masterkeyobject      = "${var.masterkey}"
    etcdproxycertobject  = "${var.etcdproxypem}"
    etcdproxykeyobject   = "${var.etcdproxykey}"
    etcd_memberlist      = "${join(",", concat(formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az1), values(var.etcd_nodes_az1)), formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az2), values(var.etcd_nodes_az2)), formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az3), values(var.etcd_nodes_az3)) ))}"
    smilodon_release_md5 = "${var.smilodon_release_md5}"
    smilodon_release_url = "${var.smilodon_release_url}"
    environment          = "${var.environment}"
    zonename             = "${var.zonename}"
    kubernetes_image     = "${element(split(":", var.kubernetes_image), 0)}"
    kubernetes_version   = "${element(split(":", var.kubernetes_image), 1)}"
    flannel_cidr         = "${var.flannel_cidr}"
    serviceiprange       = "${var.service-cluster-ip-range}"
  }
}

# Was used to test output of interpolation
#resource "null_resource" "test" {
#  provisioner "local-exec" {
#    command = "echo '${join(",", concat(formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az1), values(var.etcd_nodes_az1)), formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az2), values(var.etcd_nodes_az2)), formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az3), values(var.etcd_nodes_az3)) ))}' > ${path.module}/generatedlist.txt"
#  }
#}

data "aws_ami" "coreos_etcd" {
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
