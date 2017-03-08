### Provider
adminregion = "eu-west-1"
adminprofile = "default"
key_name = "terraform"
public_key_path = "~/.ssh/id_rsa.pub"
bucketname = "kubernetes-cert"

### Cluster specifications
cluster-name = "terrakube"
## Template variables
cluster-domain           = "cluster.local"
dns-service-ip           = "10.3.0.10"
kubernetes_image         = "quay.io/coreos/hyperkube:v1.5.2_coreos.0"
pod-ip-range             = "10.2.0.0/16"
service-cluster-ip-range = "10.3.0.0/24"

# AMI info
ownerid = "595879546273"
ami_name = "CoreOS"
channel = "stable"
virtualization_type ="hvm"

# Kubenode and bastion Autoscaling groups
kubenode_ami_size = "t2.micro"
kubenode_asg_name = "kubenode-asg"
kubenode_asg_number_of_instances = "3"
kubenode_asg_minimum_number_of_instances = "3"
kubenode_asg_maximum_number_of_instances = "3"

bastion_ami_size = "t2.micro"
bastion_asg_name = "kubebastion-asg"
bastion_asg_number_of_instances = "1"
bastion_asg_minimum_number_of_instances = "1"
bastion_asg_maximum_number_of_instances = "1"

###### kubenode and bastion modules
# Launch configs
bastion_lc_name = "kubebastion-lc"
kubenode_lc_name = "kubenode-lc"

###### Etcd module

# Launch config
etcdlc_name = "Etcd-lc"

# Node IPs - must always be an odd number of etcd nodes (default 3)
etcd_nodes_az1 = {
  "node0" = "10.0.0.10"
}

etcd_nodes_az2 = {
  "node1" = "10.0.1.10"
}

etcd_nodes_az3 = {
  "node2" = "10.0.2.10"
}

# Autoscaling groups
etcd_ami_size = "t2.micro"
etcd_asg_name_az1 = "Etcd-asg1"
etcd_asg_maxsize_az1 = "1"
etcd_asg_minsize_az1 = "1"
etcd_asg_normsize_az1 = "1"

etcd_asg_name_az2 = "Etcd-asg2"
etcd_asg_maxsize_az2 = "1"
etcd_asg_minsize_az2 = "1"
etcd_asg_normsize_az2 = "1"

etcd_asg_name_az3 = "Etcd-asg3"
etcd_asg_maxsize_az3 = "1"
etcd_asg_minsize_az3 = "1"
etcd_asg_normsize_az3 = "1"


##### Module vpc

#VPC Networking
vpc_cidr = "10.0.0.0/16"

# 2 Private CIDRs
private1_cidr = "10.0.0.0/24"
private2_cidr = "10.0.1.0/24"
private3_cidr = "10.0.2.0/24"


# 2 Public CIDRs
public1_cidr  = "10.0.3.0/24"
public2_cidr  = "10.0.4.0/24"
public3_cidr  = "10.0.5.0/24"


# Subnet Availability zones
subnetaz1 = {
  us-east-1 = "us-east-1a"
  us-east-2 = "us-east-2a"
  us-west-2 = "us-west-2a"
  eu-west-1 = "eu-west-1a"
}

subnetaz2 = {
  us-east-1 = "us-east-1c"
  us-east-2 = "us-east-2b"
  us-west-2 = "us-west-2b"
  eu-west-1 = "eu-west-1b"

}

subnetaz3 = {
  us-east-1 = "us-east-1d"
  us-east-2 = "us-east-2c"
  us-west-2 = "us-west-2c"
  eu-west-1 = "eu-west-1c"

}

### Module security
iplock = "0.0.0.0/0"

### Module route53
internal-tld = "terrakube.com"

### Module tls and s3
capem = "ca.pem"
cakey = "cakey.pem"

etcdpem = "etcd.pem"
etcdkey = "etcdkey.pem"

masterpem = "master.pem"
masterkey = "masterkey.pem"

kubenodepem = "kubenode.pem"
kubenodekey = "kubenodekey.pem"

adminpem = "admin.pem"
adminkey = "adminkey.pem"

etcdproxypem = "etcdproxy.pem"
etcdproxykey = "etcdproxykey.pem"

## Route53 module
#Empty for now

## IAM module
master_role_name = "master_role"
worker_role_name = "worker_role"
