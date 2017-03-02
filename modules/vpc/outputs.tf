output "aws_key_pair.auth.id" {
  value = "${aws_key_pair.auth.id}"
}

output "aws_vpc.id" {
  value = "${aws_vpc.vpc.id}"
}

output "aws_subnet.public1.id" {
  value = "${aws_subnet.public1.id}"
}

output "aws_subnet.public2.id" {
  value = "${aws_subnet.public2.id}"
}

output "aws_subnet.public3.id" {
  value = "${aws_subnet.public3.id}"
}

output "aws_subnet.private1.id" {
  value = "${aws_subnet.private1.id}"
}

output "aws_subnet.private2.id" {
  value = "${aws_subnet.private2.id}"
}

output "aws_subnet.private3.id" {
  value = "${aws_subnet.private3.id}"
}

output "dependency" {
  value = "${null_resource.dummy_dependency.id}"
}
