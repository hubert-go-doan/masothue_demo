class Company < ApplicationRecord
  belongs_to :represent
  belongs_to :city
  belongs_to :district
  belongs_to :ward
  belongs_to :company_type
  belongs_to :business_area
  belongs_to :status
  has_one :tax_code, as: :taxable

  validates :name, :address, :sub_name, 
            :status_id, :managed_by, :date_start, 
            :business_area_id, :represent_id, 
            :company_type_id, :city_id, :district_id, 
            :ward_id, presence: true
  validates :phone_number, numericality: { only_integer: true }
end
