class TaxCode < ApplicationRecord
  belongs_to :taxable, polymorphic: true
  validates :code, uniqueness: true
end
