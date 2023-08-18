class TaxCode < ApplicationRecord
  belongs_to :taxable, polymorphic: true
  validates :code, uniqueness: true, presence: true
  validates :taxable_type, :taxable_id, presence: true
end
