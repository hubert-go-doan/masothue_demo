class Contact < ApplicationRecord
  validates :name, :email, :content, presence: true
end
