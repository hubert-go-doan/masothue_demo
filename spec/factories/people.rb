FactoryBot.define do
  factory :person do
    name { Faker::Name.name }
    cmnd { Faker::IDNumber.unique.valid }
    address { Faker::Address.street_address }
    date_start { Faker::Date.backward(days: 365) }
    phone_number { Faker::PhoneNumber.cell_phone }
    managed_by { Faker::Name.name }
    association :city
    association :district
    association :ward
    association :company_type
    association :status
    city_id { city.id }
    district_id { district.id }
    ward_id { ward.id }
    company_type_id { company_type.id }
    status_id { status.id }
  end
end
