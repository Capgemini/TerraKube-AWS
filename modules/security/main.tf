resource "null_resource" "dummy_dependency" {
  depends_on = [
    "aws_security_group.kubemaster",
    "aws_security_group.kubenode",
    "aws_security_group.elb",
    "aws_security_group.bastion",
  ]
}
