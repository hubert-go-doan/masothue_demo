FactoryBot.define do
  factory :district do
    name { Faker::Address.state }
    city
  end
end
