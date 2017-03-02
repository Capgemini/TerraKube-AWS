### S3 bucket

variable "name" {}

variable "bucketname" {}

variable "worker-role" {}

### Bucket objects

variable "capem" {}

variable "cakey" {}

variable "etcdpem" {}

variable "etcdkey" {}

variable "masterpem" {}

variable "masterkey" {}

variable "kubenodepem" {}

variable "kubenodekey" {}

variable "adminpem" {}

variable "adminkey" {}

variable "etcdproxykey" {}

variable "etcdproxypem" {}

variable "depends-on" {
  description = "allows module dependency"
}

variable "service-cluster-ip-range" {}

variable "etcd_nodes_az1" {
  type = "map"
}

variable "etcd_nodes_az2" {
  type = "map"
}

variable "etcd_nodes_az3" {
  type = "map"
}

variable "etcd_asg_maxsize_az1" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "etcd_asg_maxsize_az2" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}

variable "etcd_asg_maxsize_az3" {
  description = "The minimum number of instances the ASG should maintain"
  default     = 1
}
