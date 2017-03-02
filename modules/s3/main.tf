resource "null_resource" "roledependency" {
  provisioner "local-exec" {
    command = "echo ${var.depends-on} has been created"
  }
}
