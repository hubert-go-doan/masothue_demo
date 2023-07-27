class Status < ApplicationRecord
  has_many :companies
  has_many :people
end
