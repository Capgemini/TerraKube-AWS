resource "aws_s3_bucket_object" "kube-apiserver" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "Manifests/kube-apiserver.yml"
  content    = "${data.template_file.kube-apiserver.rendered}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "kube-controllermanager" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "Manifests/kube-controller-manager.yml"
  content    = "${data.template_file.kube-controllermanager.rendered}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "kube-proxy" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "Manifests/kube-proxy.yml"
  content    = "${data.template_file.kube-proxy.rendered}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "kube-scheduler" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "Manifests/kube-scheduler.yml"
  content    = "${data.template_file.kube-scheduler.rendered}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

data "template_file" "kube-apiserver" {
  template = "${file("${path.cwd}/Manifests/kube-apiserver.yml")}"

  vars {
    etcd_memberlist  = "${join(",", concat(formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az1), values(var.etcd_nodes_az1)), formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az2), values(var.etcd_nodes_az2)), formatlist("%s=https://%s:2380", keys(var.etcd_nodes_az3), values(var.etcd_nodes_az3)) ))}"
    serviceiprange   = "${var.service-cluster-ip-range}"
    mastercertobject = "${var.masterpem}"
    masterkeyobject  = "${var.masterkey}"
    cacertobject     = "${var.capem}"
    apiservercount   = "${var.etcd_asg_maxsize_az1 + var.etcd_asg_maxsize_az2 + var.etcd_asg_maxsize_az3 }"
  }
}

data "template_file" "kube-controllermanager" {
  template = "${file("${path.cwd}/Manifests/kube-controller-manager.yml")}"

  vars {
    masterkeyobject = "${var.masterkey}"
    cacertobject    = "${var.capem}"
  }
}

data "template_file" "kube-proxy" {
  template = "${file("${path.cwd}/Manifests/kube-proxy.yml")}"
  vars     = {}
}

data "template_file" "kube-scheduler" {
  template = "${file("${path.cwd}/Manifests/kube-scheduler.yml")}"
  vars     = {}
}
