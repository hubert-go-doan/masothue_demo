require 'rails_helper'

RSpec.describe City, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "associations" do
    it { should have_many(:districts).dependent(:destroy) }
    it { should have_many(:companies) }
    it { should have_many(:people) }
  end
end
