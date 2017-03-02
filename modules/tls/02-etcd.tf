resource "tls_private_key" "etcd" {
  algorithm = "RSA"
}

resource "tls_cert_request" "etcd" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.etcd.private_key_pem}"

  dns_names = [
    "localhost",
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster.local",
    "etcd.${var.internal-tld}",
    "etcd1.${var.internal-tld}",
    "etcd2.${var.internal-tld}",
    "etcd3.${var.internal-tld}",
  ]

  ip_addresses = [
    "${values(var.etcd_nodes_az1)}",
    "${values(var.etcd_nodes_az2)}",
    "${values(var.etcd_nodes_az3)}",
    "${var.k8s-serviceip}",
    "127.0.0.1",
  ]

  subject {
    common_name  = "*"
    organization = "etcd"
  }
}

resource "tls_locally_signed_cert" "etcd" {
  cert_request_pem      = "${tls_cert_request.etcd.cert_request_pem}"
  ca_key_algorithm      = "RSA"
  ca_private_key_pem    = "${tls_private_key.ca.private_key_pem}"
  ca_cert_pem           = "${tls_self_signed_cert.ca.cert_pem}"
  validity_period_hours = "${var.validity_period_hours}"
  early_renewal_hours   = "${var.early_renewal_hours}"

  allowed_uses = [
    "key_encipherment",
    "server_auth",
    "client_auth",
  ]
}

resource "null_resource" "etcdkey" {
  depends_on = ["tls_private_key.etcd"]

  provisioner "local-exec" {
    command = "echo '${tls_private_key.etcd.private_key_pem}' > ${path.cwd}/Certs/${var.etcdkey} && chmod 600 ${path.cwd}/Certs/${var.etcdkey}"
  }
}

resource "null_resource" "etcdpem" {
  depends_on = ["tls_locally_signed_cert.etcd"]

  provisioner "local-exec" {
    command = "echo '${tls_locally_signed_cert.etcd.cert_pem}' > ${path.cwd}/Certs/${var.etcdpem} && chmod 600 ${path.cwd}/Certs/${var.etcdpem}"
  }
}
