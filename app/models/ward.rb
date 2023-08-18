class Ward < ApplicationRecord
  belongs_to :district
  has_many :companies, dependent: :destroy
  has_many :people, dependent: :destroy
end
