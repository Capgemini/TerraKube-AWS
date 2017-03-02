# TerraKube - Formerly Prototype-X

## This repo is currently being tested and cleaned up.

Welcome to Terrakube, a project of mine brought from personal passion and frustration with current Kubernetes offerings on AWS.

This repo is designed to equip you with everything you require to provision a Highly Available Kubernetes Cluster on AWS.
TerraKube is completely provisioned through Terraform, cloud-config systemd units and local-exec commands. Certs are generated via Terraform TLS provider.

TerraKube is also of the few examples of a Kubernetes cluster running with Masters in an autoscaling group as well as Nodes. (for self-healing purposes - This drew inspiration from the Home Office DSP (Digital Services Platform) and tooling (smilodon. kmsctl).

## General structure - in depth will be done later:

### VPC module:

Spread over 3 AZs, 3 private and public subnets, 3 NAT gateways (for true HA) and related elastic IPs. Each subnet with own route table and associated route. Also added keypair creation here as I felt it'd slot nicely in here rather than other modules.

### ELB module:

ELB creation with attachment to the Masters (Only via port 443)

### Kubernetes modules:

Etcd/Master - Currently the etcd cluster is being hosted on the master as per Google recommendation however this can easily be isolated if required. The Master nodes all run Smilodon for EBS and ENI attachment (following the EBS per IP recommendation).
Bastion - This is configured to allow you to SSH in and run "sudo etcdctl cluster-health" (etcd proxy). An OpenVPN module will be added soon.
Kubenodes - Probably the most basic of the bunch, cloud-config similar to the bastion but with the kubelet-wrapper installed.

### Route53 module:

This module is not necessary however has been added in case of later integration usage. Fairly straightforward, create a HostedZone for your usage.

### S3 module:

This module creates a KMS encryption key, the relevant keypolicy and adds the IAM roles of the masters & nodes to them. Then it uploads the Manifests and TLS certs as encrypted objects ready to be downloaded via kmsctl.

### Security module:

Creation of security groups - this will be modified and cleaned up soon however for functional purposes it is working as intended as of now.

### TLS module:

A module that ended up being rather simple after figuring out the complexities of Master autoscaling groups. SANs can be further restricted but as of now it is functioning as intended

### IAM module:

Creates Master and Node roles, associates policies to these roles and creates instance profiles.

## To use:
```
1. Install Terraform, jq and AWS cli.
2. Clone this repo and run the commands below
3. terraform fmt && terraform get && terraform plan
4. terraform apply
5. bash Scripts/cluster-test.sh - this will notify you once the cluster ready"
6. Now wait, and once the clusters ready, "kubectl get nodes" can be run
7. kubectl apply -f Addons
8. bash Scripts/dashboard.sh - brings up the kubernetes dashboard via kube proxy
```

## Todo:

- The above will be made into a nice Makefile once some final adjustments have been made 
- Document how each module works and the general structure
- Clean up the variables, and add optional cool lambda, OpenVPN and other addon modules.


To run a quick demo run:

kubectl apply -f Kubedemo/Traefik-demo

This will be further documented later.

-------------------------

### Plan for dev:

1. Etcd - smilodon ENI creation *complete*

2. Etcd - smilodon EBS creation *complete*

3. Etcd - data Template *complete*

4. Kube master completion of static pods *complete*

5. with ELB attachment *complete*

6. Kube admin local exec module *complete* (can now do kubectl get nodes)

7. Kube node seperate module *in progress - complete*

8. Addons included *complete* - optional, create makefile

Kubernetes setup complete - undergoing QA and testing

----------------------

### Inspiration:

UKHomeOffice/smilodon

kz8s/tack

gambol99/kmsctl

vaijab

CoreOS official documentation

This repo was formerly github.com/arehmandev/TerraKube-AWS/ 
