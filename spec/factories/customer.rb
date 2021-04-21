FactoryBot.define do
  factory :customer do
    name { Faker::Company.bs }
    user { FactoryBot.build(:user) }
    people { [FactoryBot.build(:person), FactoryBot.build(:person)] }

  end
end
