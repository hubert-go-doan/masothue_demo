class Company < ApplicationRecord
  belongs_to :represent
  belongs_to :city
  belongs_to :district
  belongs_to :ward
  belongs_to :company_type
  belongs_to :business_area
  belongs_to :status
  
  has_one :tax_code, as: :taxable
end
