resource "null_resource" "dummy_dependency" {
  depends_on = [
    "aws_vpc.vpc",
    "aws_subnet.public1",
    "aws_subnet.public2",
    "aws_subnet.private1",
    "aws_subnet.private2",
  ]
}
