#!/bin/bash

set -ex

# create a vpc connection that is on the db subnets and has security group access to the db & secrets
# aws --profile app_runner apprunner create-vpc-connector --vpc-connector-name shims-connector --subnets subnet-01a96a99c406ad526 subnet-0f055b5760cbe0703 --security-groups sg-0b5e3654beb38ed72

aws --profile app_runner apprunner create-service --cli-input-json file://aws/apprunner.json