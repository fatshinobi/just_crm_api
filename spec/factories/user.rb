FactoryBot.define do
  #u_email = Faker::Internet.email
  factory :user do
    sequence(:email) {|n| "test_#{n}@test.com"}
    password { Faker::Internet.password }
    provider { "email" }
  end
end