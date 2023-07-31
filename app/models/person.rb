class Person < ApplicationRecord
  belongs_to :city
  belongs_to :district
  belongs_to :ward
  belongs_to :company_type
  belongs_to :status

  has_one :tax_code, as: :taxable, dependent: :destroy
end
