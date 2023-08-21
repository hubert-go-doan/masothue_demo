FactoryBot.define do
  factory :company_type do
    type_name { Faker::Company.type }
  end
end
