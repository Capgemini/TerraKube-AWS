#!/bin/bash

BUCKET=$(cat Scripts/statebucket.txt)
REGION=$(terraform output default_region)

aws s3api delete-object --bucket ${BUCKET} --key terraform.tfvars

aws s3api delete-bucket --bucket ${BUCKET} --region ${REGION} \
&& echo "Successfully deleted remote tfstate bucket"

rm -rf Scripts/statebucket.txt
