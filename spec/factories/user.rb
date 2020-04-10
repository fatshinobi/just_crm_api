FactoryBot.define do
  u_email = Faker::Internet.email
  factory :user do
    email { u_email }
    password { Faker::Internet.password }
    provider { "email" }
    uid { u_email }

  end
end