class District < ApplicationRecord
  belongs_to :city
  has_many :wards, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :people, dependent: :destroy
end
