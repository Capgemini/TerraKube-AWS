# master
resource "aws_iam_role" "master_role" {
  name               = "${var.master_role_name}"
  path               = "/"
  assume_role_policy = "${file("${path.module}/Files/master-role.json")}"
}

data "template_file" "master_policy" {
  template = "${file("${path.module}/Files/master-policy.json")}"

  vars {
    kubebucket = "${var.kubebucket}"
    hostedzone = "${var.hostedzone}"
  }
}

resource "aws_iam_role_policy" "master_policy" {
  name   = "master_policy"
  role   = "${aws_iam_role.master_role.id}"
  policy = "${data.template_file.master_policy.rendered}"
}

resource "aws_iam_instance_profile" "master_profile" {
  depends_on = ["aws_iam_role.master_role", "aws_iam_role_policy.master_policy"]
  name       = "master_profile"
  roles      = ["${aws_iam_role.master_role.name}"]
}
