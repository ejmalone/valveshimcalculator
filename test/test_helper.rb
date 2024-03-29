# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/autorun'

module ActiveSupport
  class TestCase
    include FactoryBot::Syntax::Methods
    include Devise::Test::IntegrationHelpers

    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
  end
end
