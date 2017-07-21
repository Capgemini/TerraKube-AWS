#!/bin/bash -eu

ELB=$(terraform output master_elb)

_retry() {
  [ -z "${2}" ] && return 1
  echo -n ${1}
  until printf "." && "${@:2}" &>/dev/null; do sleep 5.2; done; echo "✓"
}

echo "❤ Polling for cluster life - this could take a minute or more"

_retry "❤ Waiting for DNS to resolve for ${ELB}" ping -c1 "${ELB}"
_retry "❤ Curling apiserver external elb (this takes a while)" curl --insecure --silent "https://${ELB}"
sleep 15
_retry "❤ Trying to connect to cluster with kubectl" kubectl cluster-info

kubectl cluster-info
