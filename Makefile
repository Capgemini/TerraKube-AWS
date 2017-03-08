SHELL += -eu

BLUE := \033[0;34m
GREEN := \033[0;32m
RED := \033[0;31m
NC := \033[0m

.addons:
	kubectl create -f Addons
	@echo "${GREEN}✓ Kubernetes addons deployed ${NC}\n"

all: prereqs plan apply
	@echo "${GREEN}✓ terraform portion of 'make all' has completed ${NC}\n"
	@echo "${GREEN}✓ waiting for cluster to become active (be patient) ${NC}\n"
	@$(MAKE) wait-for-cluster
	@echo "${GREEN}✓ deploying addons (kubectl create -f Addons) ${NC}\n"
	@$(MAKE) .addons
	@$(MAKE) test-deployment
	@echo "${GREEN}✓ Launched test busybox deployment ${NC}\n"
	@$(MAKE) info
	@echo "${GREEN}✓ Terrakube deployment complete, to see kube dashboard - 'make dashboard'  ${NC}\n"
	@echo "${GREEN}✓ To delete the TerraKube cluster - 'make destroy' ${NC}\n"

apply:
	terraform apply

dashboard:
	bash Scripts/dashboard.sh

demo:
	kubectl create -f Kubedemo/Traefik-demo
	kubectl create -f Kubedemo/Traefik-demo/weave
	@echo "${GREEN}✓ Demo has been successfully deployed ${NC}\n"


destroy:
	@-pkill -f "kubectl proxy" ||:
	terraform destroy
	@-rm -rf .terraform ||:
	@-rm -rf .terragrunt ||:
	@-rm -f Certs/*
	@echo "${BLUE}❤ Kubernetes cluster has been deleted ${NC}"

info:
	kubectl get no
	kubectl get po --namespace=kube-system
	kubectl get po
	kubectl cluster-info

metrics:
	kubectl create -f Kubedemo/Metrics
	@echo "${GREEN}❤ Heapster, InfluxDB and Grafana have been configured ${NC}"

plan:
	terraform fmt
	@echo
	terraform get
	@echo
	terraform plan

prereqs:
	aws --version
	@echo
	jq --version
	@echo
	kubectl version --client
	@echo
	terraform --version

test-deployment:
	kubectl create -f Kubedemo/Busybox

test-dns:
	kubectl exec busybox -- nslookup kubernetes

wait-for-cluster:
	bash Scripts/cluster-test.sh


#### For remote state and terragrunt

create-remote:
	@echo "${GREEN}✓ Creating remote state bucket ${NC}\n"
	bash Scripts/remote-state.sh
	@echo "${GREEN}✓ Success! Note: Upon external changes, run terraform remote pull ${NC}\n"

delete-remote:
	@echo "${GREEN}✓ Deleting remote state bucket ${NC}\n"
	bash Scripts/delete-statebucket.sh
	@echo "${GREEN}✓ Success! Remote state bucket deleted. Note: AWS has a delay for cross-region bucket namespacing ${NC}\n"

terragrunt:
	bash Scripts/terragrunt-init.sh
	@echo "${GREEN}✓ First install terragrunt before proceeding ${NC}\n"
	terragrunt -v
	@echo "${GREEN}✓ Looks like terragrunts configured, try terragrunt plan ${NC}\n"
	@echo "${GREEN}✓ For more info: github.com/gruntwork-io/terragrunt  ${NC}\n"
