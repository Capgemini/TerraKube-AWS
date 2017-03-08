variable "vpcid" {
  description = "VPC id to associate with security group"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
}

variable "iplock" {
  default     = "0.0.0.0/0"
  description = "Locks Security group to this CIDR"
}

variable "depends-on" {
  description = "allows module dependency"
}

variable "name" {
  description = "name of Kubernetes cluster for tags"
}
