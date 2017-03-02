data "template_file" "kubearn" {
  template = "${file("${path.module}/Files/workerarn.sh")}"

  vars {
    worker-role = "${var.worker-role}"
  }
}

resource "null_resource" "kubearn" {
  depends_on = ["null_resource.roledependency"]

  provisioner "local-exec" {
    command = "echo arn:aws:iam::$(bash ${path.module}/Files/workerarn.sh):role/worker_role > ${path.module}/Files/worker_role_arn.txt"
  }
}

resource "null_resource" "kubearn2" {
  depends_on = ["null_resource.roledependency"]

  provisioner "local-exec" {
    command = "echo arn:aws:iam::$(bash ${path.module}/Files/workerarn.sh):role/master_role > ${path.module}/Files/master_role_arn.txt"
  }
}

resource "null_resource" "arn" {
  depends_on = ["null_resource.roledependency"]

  provisioner "local-exec" {
    command = "echo arn:aws:iam::$(bash ${path.module}/Files/rootarn.sh):root > ${path.module}/Files/root_arn.txt"
  }
}

data "template_file" "kmspolicy" {
  depends_on = ["null_resource.arn", "null_resource.kubearn", "null_resource.kubearn2"]
  template   = "${file("${path.module}/Files/kmspolicy.json.tpl")}"

  vars {
    arn       = "${replace(file("${path.module}/Files/worker_role_arn.txt"), "\n", "")}"
    masterarn = "${replace(file("${path.module}/Files/master_role_arn.txt"), "\n", "")}"
    rootarn   = "${replace(file("${path.module}/Files/root_arn.txt"), "\n", "")}"
  }
}
