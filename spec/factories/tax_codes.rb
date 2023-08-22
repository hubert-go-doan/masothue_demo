FactoryBot.define do
  factory :tax_code do
    code { Faker::Code.nric }
    taxable_type { 'Person' }
    association :taxable, factory: :person
  end
end
