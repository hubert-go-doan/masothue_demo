class CompanyType < ApplicationRecord
  has_many :companies
  has_many :people
end
