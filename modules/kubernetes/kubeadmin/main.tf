data "template_file" "kubeconfig" {
  template = <<EOF
kubectl config set-cluster cluster-${ var.name } \
  --embed-certs=true \
  --server=https://${ var.master-elb } \
  --certificate-authority=${ var.ca-pem }
kubectl config set-credentials admin-${ var.name } \
  --embed-certs=true \
  --certificate-authority=${ var.ca-pem } \
  --client-key=${ var.admin-key-pem } \
  --client-certificate=${ var.admin-pem }
kubectl config set-context ${ var.name } \
  --cluster=cluster-${ var.name } \
  --user=admin-${ var.name }
kubectl config use-context ${ var.name }
# Run this command to configure your kubeconfig:
# ./kubeconfig.sh or eval $(terraform output kubeconfig)
EOF
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = <<LOCAL_EXEC
mkdir -p ./kubeconfig && cat <<'__USERDATA__' > ./kubeconfig/kubeconfig.sh && chmod +x ./kubeconfig/kubeconfig.sh
${data.template_file.kubeconfig.rendered}
__USERDATA__
LOCAL_EXEC
  }

  provisioner "local-exec" {
    command = <<LOCAL_EXEC
kubectl config set-cluster cluster-${ var.name } \
  --server=https://${ var.master-elb } \
  --certificate-authority=${ var.ca-pem } &&\
kubectl config set-credentials admin-${ var.name } \
  --certificate-authority=${ var.ca-pem } \
  --client-key=${ var.admin-key-pem } \
  --client-certificate=${ var.admin-pem } &&\
kubectl config set-context ${ var.name } \
  --cluster=cluster-${ var.name } \
  --user=admin-${ var.name } &&\
kubectl config use-context ${ var.name }
LOCAL_EXEC
  }
}
