#!/bin/bash

set -ex 

docker build -t "motorcycleshims/web:production" -f Dockerfile.production --secret id=master_key,src=config/credentials/production.key .

aws ecr get-login-password --region us-west-2 --profile app_runner | docker login --username AWS --password-stdin 952598771041.dkr.ecr.us-west-2.amazonaws.com

docker tag motorcycleshims/web:production 952598771041.dkr.ecr.us-west-2.amazonaws.com/motorcycleshims/web:production

docker push 952598771041.dkr.ecr.us-west-2.amazonaws.com/motorcycleshims/web:production

aws --profile app_runner ecs register-task-definition --cli-input-json file://$PWD/aws/ecs_task.json

aws --profile app_runner ecs update-service --cluster "shims-cluster" --service "shimsweb" --task-definition "shimsweb"
