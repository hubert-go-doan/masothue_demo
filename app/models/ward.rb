class Ward < ApplicationRecord
  belongs_to :district
  has_many :companies
  has_many :people
end
