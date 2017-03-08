data "template_file" "kubearn" {
  template = "${file("${path.module}/Files/workerarn.sh")}"

  vars {
    worker-role = "${var.worker-role}"
  }
}

data "aws_caller_identity" "current" {}

output "account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

data "template_file" "kmspolicy" {
  depends_on = ["data.aws_caller_identity.current"]
  template   = "${file("${path.module}/Files/kmspolicy.json.tpl")}"

  vars {
    arn       = "arn:aws:iam::${data.aws_caller_identity.current}:role/worker_role"
    masterarn = "arn:aws:iam::${data.aws_caller_identity.current}:role/master_role"
    rootarn   = "arn:aws:iam::${data.aws_caller_identity.current}:root"
  }
}
