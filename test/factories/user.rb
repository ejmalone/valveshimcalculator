FactoryBot.define do
  factory :user do
    email { 'someguy@mysite.com' }
    password { 'password' }
    encrypted_password { Devise::Encryptor.digest(User, 'password') }
  end
end
