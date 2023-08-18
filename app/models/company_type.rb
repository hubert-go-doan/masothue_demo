class CompanyType < ApplicationRecord
  has_many :companies, dependent: :destroy
  has_many :people, dependent: :destroy
end
