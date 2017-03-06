# TerraKube - Formerly Prototype-X

## This repo is currently in Beta.

Welcome to Terrakube, a project of mine brought from personal passion and frustration with current Kubernetes offerings on AWS.

This repo is designed to equip you with everything you require to provision a Highly Available Kubernetes Cluster on AWS.
TerraKube is completely provisioned through Terraform, cloud-config systemd units and local-exec commands. Certs are generated via Terraform TLS provider.

TerraKube is also of the few examples of a Kubernetes cluster running with Masters in an autoscaling group as well as Nodes. (for self-healing purposes - This drew inspiration from the Home Office DSP (Digital Services Platform) and tooling (smilodon. kmsctl).


## To use:
```
1. Install Terraform, jq and AWS cli.
2. Change the values in terraform.tfvars as required - change bucketname to something unique.
3. To create cluster - make all. (This may take some time.)
7. To see cluster-info - make info
8. To bring up dashboard - make dashboard
9. To destroy - make destroy, please ensure you kubectl delete any services (ELB) prior to this.
```

## To push state to remote S3 and generate a Terragrunt config file:

```
'make create-remote' && 'make terragrunt'

To delete remote state bucket: 'make delete-remote'
```

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

## To run a quick kubedemo upon creating cluster:

```
'make demo'

This will be further documented later. Demo includes use of Traefik as Ingress controller. Future plans to include DroneCI.
```

## Todo:

- Document how each module works and the general structure
- Clean up the variables, and add optional cool lambda, OpenVPN and other addon modules.

------------------------

Kubernetes setup complete - undergoing QA and testing. Future plans will include Packer testing - however it is debatable on the amount one should bake into an AMI if at all in this case.

----------------------

### Inspiration:

UKHomeOffice/smilodon

Capgemini/kubeform/

kz8s/tack

gambol99/kmsctl

vaijab

CoreOS official documentation

This repo was formerly github.com/arehmandev/TerraKube-AWS/
