class CompanyType < ApplicationRecord
  has_many :companies, dependent: :nullify
  has_many :people, dependent: :nullify
end
