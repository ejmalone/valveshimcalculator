# Docs at https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws.html
namespace :aws do

  # --------------------------------------------------------------
  desc "Uploads new image for AppRunner, which then deploys automatically (SKIP_UPLOAD to skip image)"
  task deploy_site: :upload_image do
    runner = Aws::AppRunner::Client.new(region: 'us-west-2')
    service = runner.list_services.service_summary_list.detect { |s| s.service_name == "shimsproduction" }
    response = runner.start_deployment(service_arn: service.service_arn)

    if response.successful?
      logger "Deployment started"
    else
      logger "Deployment failed"
    end
  end

  # --------------------------------------------------------------
  # TODO: figure out how to better update the service since this deletes the service, needs to wait until it's exited, then start anew
  desc "Deploy site config (and new deployment) to update AppRunner"
  task deploy_apprunner_config: :upload_image do
    runner = Aws::AppRunner::Client.new(region: 'us-west-2')
    service = runner.list_services.service_summary_list.detect { |s| s.service_name == "shimsproduction" }

    if service.present?
      logger "Needs to first delete service #{ service.service_arn }"
      response = runner.delete_service(service_arn: service.service_arn)

      if response.successful?
        logger "Successfully deleted existing service"
      end
    end

    config = YAML.load_file(Rails.root + 'config' + 'aws' + 'apprunner.yml').deep_symbolize_keys
    response = runner.create_service(config)

    logger "Response was successful? #{ response.successful? }"
  rescue => e
    logger "Errors occurred #{ e }"
  end

  # --------------------------------------------------------------
  desc "Deploy Sidekiq to ECS cluster (SKIP_UPLOAD to skip image)"
  task deploy_sidekiq: :upload_image do
    ecs = Aws::ECS::Client.new(region: 'us-west-2')
    config = YAML.load_file(Rails.root + 'config' + 'aws' + 'sidekiq.yml').deep_symbolize_keys
    ecs.register_task_definition(config)
    ecs.update_service(cluster: "shims-cluster", service: "shimsweb", task_definition: "shimsweb")
    logger "Sidekiq updated"
  end

  # --------------------------------------------------------------
  desc "Upload new Docker image for Site or Sidekiq"
  task upload_image: :environment do
    unless ENV['SKIP_UPLOAD'].present?
      system("aws ecr get-login-password --region us-west-2 --profile app_runner | docker login --username AWS --password-stdin 952598771041.dkr.ecr.us-west-2.amazonaws.com")

      logger "Building docker image"
      system("docker build -t \"motorcycleshims/web:production\" -f Dockerfile.production --secret id=master_key,src=config/credentials/production.key .")

      logger "Tagging image"
      system("docker tag motorcycleshims/web:production 952598771041.dkr.ecr.us-west-2.amazonaws.com/motorcycleshims/web:production")

      logger "Pushing image to AWS"
      system("docker push 952598771041.dkr.ecr.us-west-2.amazonaws.com/motorcycleshims/web:production")
    else
      logger "Skipping docker image upload"
    end
  end

  # --------------------------------------------------------------
  def logger message
    Rails.logger.info message
    puts message
  end
end
