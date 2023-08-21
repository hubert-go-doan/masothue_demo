require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "associations" do
    it { should belong_to(:represent) }
    it { should belong_to(:city) }
    it { should belong_to(:district) }
    it { should belong_to(:ward) }
    it { should belong_to(:company_type) }
    it { should belong_to(:business_area).optional }
    it { should belong_to(:status) }
    it { should have_one(:tax_code).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:managed_by) }
    it { should validate_presence_of(:date_start) }
    it { should validate_numericality_of(:phone_number).only_integer }
  end
end
