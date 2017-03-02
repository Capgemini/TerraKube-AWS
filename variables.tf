### Provider
variable "adminregion" {}

variable "adminprofile" {}

variable "key_name" {}

variable "public_key_path" {
  default = "~/.ssh/id_rsa.pub"
}

### VPC module

#VPC Networking
variable "vpc_cidr" {}

# 2 Private CIDRs
variable "private1_cidr" {}

variable "private2_cidr" {}

variable "private3_cidr" {}

# 2 Public CIDRs
variable "public1_cidr" {}

variable "public2_cidr" {}

variable "public3_cidr" {}

# Subnet Availability zones

variable "subnetaz1" {
  type = "map"
}

variable "subnetaz2" {
  type = "map"
}

variable "subnetaz3" {
  type = "map"
}

### security module

variable "iplock" {}

### route53 module

variable "internal-tld" {}

variable "cluster-name" {}

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

variable "etcdproxypem" {}

variable "etcdproxykey" {}

variable "bucketname" {}

## TLS module

variable "k8s-serviceip" {}

## IAM module

variable "master_role_name" {}

variable "worker_role_name" {}

###### Etcd module

## Launch config
variable "etcdlc_name" {}

variable "coresize" {}

variable "ownerid" {}

variable "ami_name" {}

variable "channel" {}

variable "virtualization_type" {}

## Autoscaling groups

variable "etcd_nodes_az1" {
  type = "map"
}

variable "etcd_nodes_az2" {
  type = "map"
}

variable "etcd_nodes_az3" {
  type = "map"
}

variable "etcd_asg_name_az1" {}

variable "etcd_asg_maxsize_az1" {}

variable "etcd_asg_minsize_az1" {}

variable "etcd_asg_normsize_az1" {}

variable "etcd_asg_name_az2" {}

variable "etcd_asg_maxsize_az2" {}

variable "etcd_asg_minsize_az2" {}

variable "etcd_asg_normsize_az2" {}

variable "etcd_asg_name_az3" {}

variable "etcd_asg_maxsize_az3" {}

variable "etcd_asg_minsize_az3" {}

variable "etcd_asg_normsize_az3" {}

## Template variables
variable "cluster-domain" {}

variable "dns-service-ip" {}

variable "hyperkube-image" {}

variable "hyperkube-tag" {}

variable "pod-ip-range" {}

variable "service-cluster-ip-range" {}

#### Kubemaster module

## Launch config
variable "kubemasterlc_name" {}

## Autoscaling groups

variable "kubemaster_asg_name" {}

variable "kubemaster_asg_number_of_instances" {}

variable "kubemaster_asg_minimum_number_of_instances" {}

## Etcd bastion

variable "bastion_asg_minimum_number_of_instances" {}

variable "bastion_asg_number_of_instances" {}

variable "bastion_lc_name" {}

variable "bastion_asg_name" {}

# Kubenode

variable "kubenode_asg_minimum_number_of_instances" {}

variable "kubenode_asg_number_of_instances" {}

variable "kubenode_lc_name" {}

variable "kubenode_asg_name" {}
