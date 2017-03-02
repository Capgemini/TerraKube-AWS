resource "tls_private_key" "kubenode" {
  algorithm = "RSA"
}

resource "tls_cert_request" "kubenode" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.kubenode.private_key_pem}"

  dns_names = [
    "kubernetes",
    "kubernetes.default",
    "kubernetes.default.svc",
    "kubernetes.default.svc.cluster.local",
    "*.*.compute.internal,*.ec2.internal",
    "master.${var.internal-tld}",
    "*.${var.adminregion}.elb.amazonaws.com",
    "localhost",
  ]

  ip_addresses = [
    "0.0.0.0",
  ]

  subject {
    common_name  = "*"
    organization = "kubenode"
  }
}

resource "tls_locally_signed_cert" "kubenode" {
  cert_request_pem      = "${tls_cert_request.kubenode.cert_request_pem}"
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

resource "null_resource" "kubenodekey" {
  depends_on = ["tls_private_key.kubenode"]

  provisioner "local-exec" {
    command = "echo '${tls_private_key.kubenode.private_key_pem}' > ${path.cwd}/Certs/${var.kubenodekey} && chmod 600 ${path.cwd}/Certs/${var.kubenodekey}"
  }
}

resource "null_resource" "kubenodepem" {
  depends_on = ["tls_locally_signed_cert.kubenode"]

  provisioner "local-exec" {
    command = "echo '${tls_locally_signed_cert.kubenode.cert_pem}' > ${path.cwd}/Certs/${var.kubenodepem} && chmod 600 ${path.cwd}/Certs/${var.kubenodepem}"
  }
}
