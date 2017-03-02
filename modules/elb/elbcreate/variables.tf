variable "name" {}

variable "elb_name" {
  default = "kube-master"
}

variable "health_check_target" {
  default = "HTTP:8080/healthz"
}

variable "subnets" {
  type = "list"
}

variable "security_groups" {}
