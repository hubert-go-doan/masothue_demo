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
  validate :presence_of_foreign_keys

  private
  def presence_of_foreign_keys
    foreign_keys = %i[city_id district_id ward_id company_type_id status_id]

    foreign_keys.each do |foreign_key|
      if self[foreign_key].blank?
        errors.add(foreign_key, "must be selected")
      end
    end
  end
end
