resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name              = "TerraKubeVPC"
    KubernetesCluster = "${ var.name }"
  }
}

#Internet gateway for public access/internet access
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name              = "TerraKubeInternetGateway"
    KubernetesCluster = "${ var.name }"
  }
}

# Create Elastic IPs for the natgateways
resource "aws_eip" "nat1" {
  vpc        = true
  depends_on = ["aws_internet_gateway.internet-gateway"]
}

resource "aws_eip" "nat2" {
  vpc        = true
  depends_on = ["aws_internet_gateway.internet-gateway"]
}

resource "aws_eip" "nat3" {
  vpc        = true
  depends_on = ["aws_internet_gateway.internet-gateway"]
}

#Create NAT gateways for each AZ and it will depend on the internet gateway creation
resource "aws_nat_gateway" "nat1" {
  allocation_id = "${aws_eip.nat1.id}"
  subnet_id     = "${aws_subnet.public1.id}"
  depends_on    = ["aws_internet_gateway.internet-gateway"]
}

resource "aws_nat_gateway" "nat2" {
  allocation_id = "${aws_eip.nat2.id}"
  subnet_id     = "${aws_subnet.public2.id}"
  depends_on    = ["aws_internet_gateway.internet-gateway"]
}

resource "aws_nat_gateway" "nat3" {
  allocation_id = "${aws_eip.nat3.id}"
  subnet_id     = "${aws_subnet.public3.id}"
  depends_on    = ["aws_internet_gateway.internet-gateway"]
}
