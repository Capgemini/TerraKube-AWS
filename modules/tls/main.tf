resource "null_resource" "dummy_dependency" {
  depends_on = [
    "tls_private_key.kubemaster",
    "tls_private_key.kubenode",
    "tls_private_key.etcd",
    "tls_private_key.kubeadmin",
    "tls_private_key.ca",
  ]
}
