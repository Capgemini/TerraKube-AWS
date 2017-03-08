#EC2 security groups:
# egress = all traffic,
# ingress locked internally to VPC and variable "myip" (default == 0.0.0.0/0 in tfvars)

resource "aws_security_group" "elb" {
  name        = "TerraKube-ELB"
  description = "Terrakube ELB security group"
  vpc_id      = "${var.vpcid}"

  ### Inbound rules

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${var.iplock}"]
  }
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${var.iplock}"]
  }

  #outbound rule, no port restrictions

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"                                    # for all protocols
    security_groups = ["${aws_security_group.kubemaster.id}"]
  }
  tags {
    KubernetesCluster = "${ var.name }"
    Name              = "ELB-k8s-${ var.name }"
    builtWith         = "terraform"
  }
}
