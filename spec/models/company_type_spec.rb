require 'rails_helper'

RSpec.describe CompanyType, type: :model do
  describe "associations" do
    it { should have_many(:companies) }
    it { should have_many(:people) }
  end
end
