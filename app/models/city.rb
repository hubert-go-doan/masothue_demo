class City < ApplicationRecord
  has_many :districts, dependent: :destroy
  has_many :companies, dependent: :destroy
  has_many :people, dependent: :destroy

  validates :name, presence: true
end
