data "aws_caller_identity" "current" {}

data "template_file" "kmspolicy" {
  depends_on = ["data.aws_caller_identity.current"]
  template   = "${file("${path.module}/Files/kmspolicy.json.tpl")}"

  vars {
    arn       = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/worker_role"
    masterarn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/master_role"
    rootarn   = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
  }
}
