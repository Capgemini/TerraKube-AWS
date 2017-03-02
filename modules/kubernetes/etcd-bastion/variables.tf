### Module etcd bastion

# template variables
variable "internal-tld" {}

variable "bucketname" {}

variable "capem" {}

variable "etcdpem" {}

variable "etcdkey" {}

variable "etcdproxykey" {}

variable "etcdproxypem" {}

variable "adminregion" {}

variable "lc_name" {}

variable "instance_type" {}

variable "iam_instance_profile" {}

variable "userdata" {}

variable "key_name" {}

variable "ownerid" {}

variable "ami_name" {}

variable "channel" {}

variable "virtualization_type" {}

variable "security_group" {
  description = "The security group the instances to use"
}

variable "asg_name" {}

variable "asg_number_of_instances" {
  description = "The number of instances we want in the ASG"
}

variable "asg_minimum_number_of_instances" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default     = 300
}

variable "health_check_type" {
  default = "EC2"
}

variable "subnet_azs" {
  description = "The VPC subnet IDs"
  type        = "list"

  // comma separated list
}

variable "azs" {
  description = "Availability Zones"
  type        = "list"

  // comma separated list
}

variable "etcd_nodes_az1" {
  type = "map"
}

variable "etcd_nodes_az2" {
  type = "map"
}

variable "etcd_nodes_az3" {
  type = "map"
}
