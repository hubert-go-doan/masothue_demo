class Company < ApplicationRecord
  belongs_to :represent
  belongs_to :city
  belongs_to :district
  belongs_to :ward
  belongs_to :company_type
  belongs_to :business_area, optional: true
  belongs_to :status
  has_one :tax_code, as: :taxable, dependent: :destroy

  validates :name, :address, :managed_by, :date_start, presence: true
  validates :phone_number, numericality: { only_integer: true }
  validate :presence_of_foreign_keys

  after_create_commit -> { broadcast_prepend_to "companies", partial: "admin/companies/company", locals: { company: self }, target: "companies" }
  after_update_commit -> { broadcast_replace_to "companies", partial: "admin/companies/company" }
  after_destroy_commit -> { broadcast_remove_to "companies" }

  private

  def presence_of_foreign_keys
    foreign_keys = %i[represent_id city_id district_id ward_id company_type_id status_id]

    foreign_keys.each do |foreign_key|
      errors.add(foreign_key, "must be selected") if self[foreign_key].blank?
    end
  end
end
