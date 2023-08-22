class BusinessArea < ApplicationRecord
  has_many :companies, dependent: :nullify
  validates :name, presence: { message: "Please Business Area name cannot be blank" }, uniqueness: true
end
