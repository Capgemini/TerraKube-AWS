resource "tls_private_key" "ca" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "ca" {
  key_algorithm   = "RSA"
  private_key_pem = "${tls_private_key.ca.private_key_pem}"

  subject {
    common_name  = "${var.common_name}"
    organization = "${var.organization}"
  }

  allowed_uses = [
    "key_encipherment",
    "cert_signing",
    "server_auth",
    "client_auth",
  ]

  validity_period_hours = "${var.validity_period_hours}"
  early_renewal_hours   = "${var.early_renewal_hours}"
  is_ca_certificate     = "${var.is_ca_certificate}"
}

resource "null_resource" "cakey" {
  depends_on = ["tls_private_key.ca"]

  provisioner "local-exec" {
    command = "echo '${tls_private_key.ca.private_key_pem}' > ${path.cwd}/Certs/${var.cakey} && chmod 600 ${path.cwd}/Certs/${var.cakey}"
  }
}

resource "null_resource" "capem" {
  depends_on = ["tls_self_signed_cert.ca"]

  provisioner "local-exec" {
    command = "echo '${tls_self_signed_cert.ca.cert_pem}' > ${path.cwd}/Certs/${var.capem} && chmod 600 ${path.cwd}/Certs/${var.capem}"
  }
}
