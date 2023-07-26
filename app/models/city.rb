class City < ApplicationRecord
  has_many :districts
  has_many :companies
  has_many :people
end
