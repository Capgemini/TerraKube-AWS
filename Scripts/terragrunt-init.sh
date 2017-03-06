#!/bin/bash

cat > .terragrunt <<EOF
# Configure Terragrunt to use DynamoDB for locking
lock = {
  backend = "dynamodb"
  config {
    state_file_id = "TerraKube"
  }
}
# Configure Terragrunt to automatically store tfstate files in S3
remote_state = {
  backend = "s3"
  config {
    encrypt = "true"
    bucket = "${BUCKET}"
    key = "terraform.tfstate"
    region = "${REGION}"
  }
}
EOF

echo "Created optional terragrunt configuration at .terragrunt"
