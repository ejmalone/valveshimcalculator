# Docs at https://docs.aws.amazon.com/sdk-for-ruby/v3/api/Aws.html
namespace :aws do
  # --------------------------------------------------------------
  desc "Deploy site to AppRunner"
  task deploy_site: :upload_image do
    runner = Aws::AppRunner::Client.new(region: 'us-west-2')
    service = runner.list_services.service_summary_list.detect { |s| s.service_name == "shimsproduction" }

    if service.present?
      Rails.logger.info "Needs to first delete service #{ service.service_arn }"
      response = runner.delete_service(service_arn: service.service_arn)

      if response.successful?
        Rails.logger.info "Successfully deleted existing service"
      end
    end

    config = YAML.load_file(Rails.root + 'config' + 'aws' + 'apprunner.yml').deep_symbolize_keys
    response = runner.create_service(config)

    Rails.logger.info "Response was successful? #{ response.successful? }"
  rescue => e
    Rails.logger.info "Errors occurred #{ e }"
  end

  # --------------------------------------------------------------
  desc "Deploy Sidekiq to ECS cluster"
  task deploy_sidekiq: :upload_image do
    ecs = Aws::ECS::Client.new(region: 'us-west-2')
    config = YAML.load_file(Rails.root + 'config' + 'aws' + 'sidekiq.yml').deep_symbolize_keys
    ecs.register_task_definition(config)
    ecs.update_service(cluster: "shims-cluster", service: "shimsweb", task_definition: "shimsweb")
    Rails.logger.info "Sidekiq updated"
  end

  # --------------------------------------------------------------
  desc "Upload new Docker image for Site or Sidekiq"
  task upload_image: :environment do
    unless ENV['SKIP_UPLOAD'].present?
      Rails.logger.info "Building docker image"
      system("docker build -t \"motorcycleshims/web:production\" -f Dockerfile.production --secret id=master_key,src=config/credentials/production.key .")

      Rails.logger.info "Tagging image"
      system("docker tag motorcycleshims/web:production 952598771041.dkr.ecr.us-west-2.amazonaws.com/motorcycleshims/web:production")

      Rails.logger.info "Pushing image to AWS"
      system("docker push 952598771041.dkr.ecr.us-west-2.amazonaws.com/motorcycleshims/web:production")
    else
      Rails.logger.info "Skipping docker image upload"
    end
  end

end
