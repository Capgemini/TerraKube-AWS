#!/bin/bash

BUCKET=tfstatebucket$(base64 /dev/urandom | tr -d '/+' | dd bs=5 count=1 2>/dev/null)
REGION=$(terraform output default_region)

aws s3api create-bucket --bucket ${BUCKET} --region ${REGION} --create-bucket-configuration LocationConstraint=${REGION}

terraform remote config -backend=S3 \
-backend-config="bucket=${BUCKET}" \
-backend-config="key=terraform.tfvars" \
-backend-config="region=${REGION}" \
-backend-config="encrypt=true"

echo "Pushing remote state to S3 bucket: ${BUCKET}"
terraform remote push


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
