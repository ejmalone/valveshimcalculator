#!/bin/bash

set -ex

aws --profile app_runner apprunner create-service --cli-input-json file://apprunner.json