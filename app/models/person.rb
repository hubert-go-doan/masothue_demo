class Person < ApplicationRecord
  belongs_to :city
  belongs_to :district
  belongs_to :ward
  belongs_to :company_type
  belongs_to :status
  has_one :tax_code, as: :taxable, dependent: :destroy

  validates :cmnd, uniqueness: true
  validates :name, :address, :managed_by, :date_start, presence: true
  validates :phone_number, numericality: { only_integer: true }
end
