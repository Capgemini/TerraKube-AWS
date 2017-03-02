variable "organization" {
  default = "terrakube"
}

# valid for 1000 days
variable "validity_period_hours" {
  default = 24000
}

variable "early_renewal_hours" {
  default = 720
}

variable "is_ca_certificate" {
  default = true
}

variable "common_name" {
  default = "kube-ca"
}

variable "internal-tld" {}

variable "adminregion" {}

variable "k8s-serviceip" {}

# names of the pem files generated defined when the module is called and the IP settings for CA
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

variable "etcd_nodes_az1" {
  type = "map"
}

variable "etcd_nodes_az2" {
  type = "map"
}

variable "etcd_nodes_az3" {
  type = "map"
}
