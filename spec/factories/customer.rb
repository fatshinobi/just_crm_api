FactoryBot.define do
  factory :customer do
    name { Faker::Company.bs }
    user { FactoryBot.build(:user) }

  end
end
