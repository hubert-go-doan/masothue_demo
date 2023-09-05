FactoryBot.define do
  factory :company do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    date_start { Faker::Date.backward(days: 365) }
    phone_number { rand(100_000_000..999_999_999).to_s }
    managed_by { Faker::Name.name }
    association :city
    association :district
    association :ward
    association :company_type
    association :business_area
    association :represent
    association :status
  end
end
