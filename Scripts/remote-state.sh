#!/bin/bash

if [ -f Scripts/statebucket.txt ]; then
    echo "Statebucket already exists"
    exit 1
fi



BUCKET=tfstatebucket-$(base64 /dev/urandom |  tr -dc 'a-z0-9' | dd bs=5 count=1 2>/dev/null)
REGION=eu-west-1


aws s3api create-bucket --bucket ${BUCKET} --region ${REGION} --create-bucket-configuration LocationConstraint=${REGION}

terraform remote config -backend=S3 \
-backend-config="bucket=${BUCKET}" \
-backend-config="key=terraform.tfvars" \
-backend-config="region=${REGION}" \
-backend-config="encrypt=true"

echo "Pushing remote state to S3 bucket: ${BUCKET}"

terraform remote push && echo "${BUCKET}" > Scripts/statebucket.txt
