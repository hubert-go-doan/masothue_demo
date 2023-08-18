class Represent < ApplicationRecord
  has_many :companies, dependent: :destroy
  validates :name, presence: true
end
