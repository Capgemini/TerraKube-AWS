# Create the public route tables
resource "aws_route_table" "public1_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name              = "TerraKube Public1 route table"
    KubernetesCluster = "${ var.name }"
  }
}

resource "aws_route_table" "public2_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name              = "TerraKube Public2 route table"
    KubernetesCluster = "${ var.name }"
  }
}

resource "aws_route_table" "public3_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name              = "TerraKube Public3 route table"
    KubernetesCluster = "${ var.name }"
  }
}

#Create public routes - links to internet gateway for internet access
resource "aws_route" "public1_route" {
  route_table_id         = "${aws_route_table.public1_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet-gateway.id}"
}

resource "aws_route" "public2_route" {
  route_table_id         = "${aws_route_table.public2_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet-gateway.id}"
}

resource "aws_route" "public3_route" {
  route_table_id         = "${aws_route_table.public3_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.internet-gateway.id}"
}

# Create the private route tables
resource "aws_route_table" "private1_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name              = "TerraKube Private1 route table"
    KubernetesCluster = "${ var.name }"
  }
}

resource "aws_route_table" "private2_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name              = "TerraKube Private2 route table"
    KubernetesCluster = "${ var.name }"
  }
}

resource "aws_route_table" "private3_route_table" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name              = "TerraKube Private3 route table"
    KubernetesCluster = "${ var.name }"
  }
}

# Create private routes - links to NAT gateway for 1 way internet access
resource "aws_route" "private1_route" {
  route_table_id         = "${aws_route_table.private1_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat1.id}"
}

resource "aws_route" "private2_route" {
  route_table_id         = "${aws_route_table.private2_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat2.id}"
}

resource "aws_route" "private3_route" {
  route_table_id         = "${aws_route_table.private3_route_table.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat3.id}"
}
