FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    cmnd { Faker::IDNumber.unique.valid }
    address { Faker::Address.street_address }
    date_start { Faker::Date.backward(days: 365) }
    phone_number { rand(100_000_000..999_999_999).to_s }
    managed_by { Faker::Name.name }
    association :city
    association :district
    association :ward
    association :company_type
    association :status
  end
end
