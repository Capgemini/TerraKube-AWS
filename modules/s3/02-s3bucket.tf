resource "aws_kms_key" "kubekms" {
  depends_on              = ["null_resource.roledependency", "data.template_file.kmspolicy"]
  description             = "KMS key 1"
  deletion_window_in_days = 7
  policy                  = "${data.template_file.kmspolicy.rendered}"
}

resource "aws_s3_bucket" "kubebucket" {
  depends_on = ["aws_kms_key.kubekms"]

  bucket = "${var.bucketname}"
  acl    = "private"

  tags {
    Name              = "Kubebucket"
    Environment       = "Dev"
    KubernetesCluster = "${ var.name }"
  }
}
