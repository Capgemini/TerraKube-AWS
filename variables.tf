### Provider
variable "adminregion" {
  description = "The region to deploy the kubernetes cluster"
}

variable "adminprofile" {
  description = "The local AWS-CLI profile to be used for AWS api credentials"
}

variable "key_name" {
  description = "The name of the SSH key to be created in AWS for access to the bastion"
}

variable "public_key_path" {
  description = "The path to the SSH key locally"
  default     = "~/.ssh/id_rsa.pub"
}

variable "bucketname" {
  description = "The name of the S3 Bucket to store KMS encrypted TLS certs and Kube static pod manifests"
}

### Cluster specifications

variable "cluster-name" {
  description = "The name of the Kubernetes cluster used in tags"
}

## Template variables
variable "cluster-domain" {
  description = "The internal kubernetes cluster-domain"
  default     = "cluster.local"
}

variable "dns-service-ip" {
  description = "The VIP (Virtual IP) address of the cluster DNS service"
  default     = "10.3.0.10"
}

variable "service-cluster-ip-range" {
  description = "The CIDR network to use for service cluster VIPs (Virtual IPs)"
  default     = "10.3.0.0/24"
}

variable "k8s-service-ip" {
  description = "The VIP (Virtual IP) address of the Kubernetes API Service. This must be set to the first IP in service-cluster range"
  default     = "10.3.0.1"
}

variable "kubernetes_image" {
  description = "The docker kubernetes image we are using"
  default     = "quay.io/coreos/hyperkube:v1.5.2_coreos.0"
}

variable "pod-ip-range" {
  description = "The CIDR network to use for pod IPs"
}

# AMI info

variable "ownerid" {
  description = "The AMI owner to be used for AMI lookup via data source"
  default     = "595879546273"
}

variable "ami_name" {
  description = "The name of the AMI"
  default     = "CoreOS"
}

variable "channel" {
  description = "The AMI release version e.g. Beta / Stable"
  default     = "Stable"
}

variable "virtualization_type" {
  description = "The type of hypervisor used in AWS"
  default     = "HVM"
}

# Kubenode and bastion Autoscaling groups

variable "kubenode_ami_size" {
  description = "The AMI size of the kubenode instances"
  default     = "t2.micro"
}

variable "kubenode_asg_name" {
  description = "The name of the kubenodes autoscaling groups"
}

variable "kubenode_asg_number_of_instances" {
  description = "The autoscaling groups normal number of instances of kubenodes"
}

variable "kubenode_asg_minimum_number_of_instances" {
  description = "The autoscaling groups minimum number of instances of kubenodes"
}

variable "kubenode_asg_maximum_number_of_instances" {
  description = "The autoscaling groups maximum number of instances of kubenodes"
}

variable "bastion_ami_size" {
  description = "The AMI size of the kubenode instances"
  default     = "t2.micro"
}

variable "bastion_asg_name" {
  description = "The name of the bastions autoscaling groups"
}

variable "bastion_asg_number_of_instances" {
  description = "The autoscaling groups normal number of instances of bastions"
}

variable "bastion_asg_minimum_number_of_instances" {
  description = "The autoscaling groups minimum number of instances of bastions"
}

variable "bastion_asg_maximum_number_of_instances" {
  description = "The autoscaling groups maximum number of instances of bastions"
}

#### Kubenode and bastion modules

## Launch configs

variable "kubenode_lc_name" {
  description = "The name of the kubenode launch config"
}

variable "bastion_lc_name" {
  description = "The name of the etcd launch config"
}

###### Etcd module

## Launch config

variable "etcdlc_name" {
  description = "The name of the etcd launch config"
}

## Autoscaling group

variable "etcd_ami_size" {
  description = "The AMI size of the kubenode instances"
  default     = "t2.micro"
}

variable "etcd_nodes_az1" {
  description = "The IPs of the ENIs smilodon attaches to the etcd nodes in AZ1"
  type        = "map"
}

variable "etcd_nodes_az2" {
  description = "The IPs of the ENIs smilodon attaches to the etcd nodes in AZ2"
  type        = "map"
}

variable "etcd_nodes_az3" {
  description = "The IPs of the ENIs smilodon attaches to the etcd nodes in AZ3"
  type        = "map"
}

variable "etcd_asg_name_az1" {
  description = "The name of the etcd autoscaling group in AZ1"
}

variable "etcd_asg_maxsize_az1" {
  description = "The autoscaling groups maximum etcd nodes in AZ1"
}

variable "etcd_asg_minsize_az1" {
  description = "The autoscaling groups minimum etcd nodes in AZ1"
}

variable "etcd_asg_normsize_az1" {
  description = "The autoscaling groups normal amount of etcd nodes in AZ1"
}

variable "etcd_asg_name_az2" {
  description = "The name of the etcd autoscaling group in AZ2"
}

variable "etcd_asg_maxsize_az2" {
  description = "The autoscaling groups maximum etcd nodes in AZ2"
}

variable "etcd_asg_minsize_az2" {
  description = "The autoscaling groups maximum etcd nodes in AZ2"
}

variable "etcd_asg_normsize_az2" {
  description = "The autoscaling groups normal amount of etcd nodes in AZ2"
}

variable "etcd_asg_name_az3" {
  description = "The name of the etcd autoscaling group in AZ3"
}

variable "etcd_asg_maxsize_az3" {
  description = "The autoscaling groups maximum etcd nodes in AZ3"
}

variable "etcd_asg_minsize_az3" {
  description = "The autoscaling groups minumum etcd nodes in AZ3"
}

variable "etcd_asg_normsize_az3" {
  description = "The autoscaling groups normal amount of etcd nodes in AZ3"
}

### VPC module

#VPC Networking
variable "vpc_cidr" {
  description = "The VPC CIDR"
}

# 2 Private CIDRs
variable "private1_cidr" {
  description = "The CIDR for private subnet 1"
}

variable "private2_cidr" {
  description = "The CIDR for private subnet 2"
}

variable "private3_cidr" {
  description = "The CIDR for private subnet 3"
}

# 2 Public CIDRs
variable "public1_cidr" {
  description = "The CIDR for public subnet 1"
}

variable "public2_cidr" {
  description = "The CIDR for public subnet 2"
}

variable "public3_cidr" {
  description = "The CIDR for public subnet 3"
}

# Subnet Availability zones

variable "subnetaz1" {
  description = "The Availability Zone for public and private subnet 1"
  type        = "map"
}

variable "subnetaz2" {
  description = "The Availability Zone for public and private subnet 2"
  type        = "map"
}

variable "subnetaz3" {
  description = "The Availability Zone for public and private subnet 3"
  type        = "map"
}

### security module

variable "iplock" {
  description = "The CIDR to lock SSH access to via security groups"
}

### route53 module

variable "internal-tld" {
  description = "The internal domain to be used in route53 Private Hosted Zone"
}

# names of the pem files generated defined when the module is called and the IP settings for CA

variable "capem" {
  description = "The name of the CA cert generated"
}

variable "cakey" {
  description = "The name of the CA private key generated"
}

variable "etcdpem" {
  description = "The name of the etcd cert generated"
}

variable "etcdkey" {
  description = "The name of the etcd private key generated"
}

variable "masterpem" {
  description = "The name of the master cert generated"
}

variable "masterkey" {
  description = "The name of the master private key generated"
}

variable "kubenodepem" {
  description = "The name of the kubenode cert generated"
}

variable "kubenodekey" {
  description = "The name of the kubenode private key generated"
}

variable "adminpem" {
  description = "The name of the local administration cert generated"
}

variable "adminkey" {
  description = "The name of the local administration private key generated"
}

variable "etcdproxypem" {
  description = "The name of the etcdproxy cert generated"
}

variable "etcdproxykey" {
  description = "The name of the etcdproxy private key generated"
}

## IAM module

variable "master_role_name" {
  description = "The name of the kubemaster role"
}

variable "worker_role_name" {
  description = "The name of the kubenode role"
}
