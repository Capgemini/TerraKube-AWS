#!/bin/bash
aws sts get-caller-identity --output text --query 'Account'
