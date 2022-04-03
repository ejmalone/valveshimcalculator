# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    encrypted_password { Devise::Encryptor.digest(User, 'password') }
  end
end
