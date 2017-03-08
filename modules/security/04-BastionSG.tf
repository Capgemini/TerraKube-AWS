#EC2 security groups:
# egress = all traffic,
# ingress locked internally to VPC and variable "myip" (default == 0.0.0.0/0 in tfvars)

resource "aws_security_group" "bastion" {
  name        = "TerraKube-Bastion"
  description = "Terrakube bastion security group"
  vpc_id      = "${var.vpcid}"

  ### Inbound rules

  # Allows inbound and outbound traffic from all instances in the VPC.
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    self        = true
    cidr_blocks = ["${var.vpc_cidr}"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.iplock}"]
  }

  #outbound rule, no port restrictions

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # for all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    KubernetesCluster = "${ var.name }"
    Name              = "Bastion-k8s-${ var.name }"
    builtWith         = "terraform"
  }
}
