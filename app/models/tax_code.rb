class TaxCode < ApplicationRecord
  belongs_to :taxable, polymorphic: true
end
