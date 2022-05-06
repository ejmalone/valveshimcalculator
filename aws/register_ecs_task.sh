#!/bin/bash

set -ex 

aws --profile app_runner ecs register-task-definition --cli-input-json file://ecs_task.json

aws --profile app_runner ecs update-service --cluster "shims-cluster" --service "shimsweb" --task-definition "shimsweb"
