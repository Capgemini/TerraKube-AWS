resource "aws_route53_zone" "internal" {
  comment = "Kubernetes cluster DNS (internal)"
  name    = "${ var.internal-tld }"

  tags {
    builtWith         = "terraform"
    KubernetesCluster = "${ var.cluster-name }"
    Name              = "k8s-${ var.cluster-name }"
  }

  vpc_id = "${ var.vpcid }"
}

resource "aws_route53_record" "CNAME-master" {
  name    = "master"
  records = ["etcd.${ var.internal-tld }"]
  ttl     = "300"
  type    = "CNAME"
  zone_id = "${ aws_route53_zone.internal.zone_id }"
}

resource "null_resource" "dummy_dependency" {
  depends_on = [
    "aws_route53_zone.internal",
    "aws_route53_record.CNAME-master",
  ]
}
