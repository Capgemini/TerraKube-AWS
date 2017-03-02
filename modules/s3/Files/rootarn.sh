#!/bin/bash
aws sts get-caller-identity | jq ".Arn" | tr -d '"' | sed "s/[^0-9]//g"
