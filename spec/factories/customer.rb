FactoryBot.define do
  factory :customer do
    name { Faker::Company.name }
    about { Faker::Company.catch_phrase }
    phone { Faker::Company.duns_number }
    web { Faker::Internet.domain_name }
    #user { FactoryBot.build(:user) }
    association :user, factory: :user
    people { [FactoryBot.build(:person), FactoryBot.build(:person)] }
  end
end
