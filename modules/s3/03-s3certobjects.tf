resource "aws_s3_bucket_object" "capem" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.capem}"
  source     = "${path.cwd}/Certs/${var.capem}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "cakey" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.cakey}"
  source     = "${path.cwd}/Certs/${var.cakey}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "etcdpem" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.etcdpem}"
  source     = "${path.cwd}/Certs/${var.etcdpem}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "etcdkey" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.etcdkey}"
  source     = "${path.cwd}/Certs/${var.etcdkey}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "masterpem" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.masterpem}"
  source     = "${path.cwd}/Certs/${var.masterpem}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "masterkey" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.masterkey}"
  source     = "${path.cwd}/Certs/${var.masterkey}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "kubenodepem" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.kubenodepem}"
  source     = "${path.cwd}/Certs/${var.kubenodepem}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "kubenodekey" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.kubenodekey}"
  source     = "${path.cwd}/Certs/${var.kubenodekey}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "adminpem" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.adminpem}"
  source     = "${path.cwd}/Certs/${var.adminpem}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "adminkey" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.adminkey}"
  source     = "${path.cwd}/Certs/${var.adminkey}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "etcdproxypem" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.etcdproxypem}"
  source     = "${path.cwd}/Certs/${var.etcdproxypem}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}

resource "aws_s3_bucket_object" "etcdproxykey" {
  depends_on = ["aws_s3_bucket.kubebucket", "aws_kms_key.kubekms"]
  bucket     = "${aws_s3_bucket.kubebucket.bucket}"
  key        = "${var.etcdproxykey}"
  source     = "${path.cwd}/Certs/${var.etcdproxykey}"
  kms_key_id = "${aws_kms_key.kubekms.arn}"
}
