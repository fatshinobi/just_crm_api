FactoryBot.define do
  factory :role do
    name { Faker::Company.profession }
  end
end
