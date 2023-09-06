class BusinessArea < ApplicationRecord
  has_many :companies, dependent: :nullify
  validates :name, presence: { message: "Please Business Area name cannot be blank" }, uniqueness: true
  after_create_commit -> { broadcast_prepend_to "business-areas", partial: "admin/business_areas/business_area", locals: { business_area: self }, target: "business-areas" }
  after_update_commit -> { broadcast_replace_to "business-areas", partial: "admin/business_areas/business_area" }
  after_destroy_commit -> { broadcast_remove_to "business-areas" }
end
