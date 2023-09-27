require 'rails_helper'

RSpec.describe Person, type: :model do
  describe 'associations' do
    it { should belong_to(:city) }
    it { should belong_to(:district) }
    it { should belong_to(:ward) }
    it { should belong_to(:company_type) }
    it { should belong_to(:status) }
    it { should have_one(:tax_code).dependent(:destroy) }
  end

  describe 'validations' do
    let(:city) { create(:city) }
    let(:district) { create(:district, city:) }
    let(:ward) { create(:ward, district:) }
    let(:company_type) { create(:company_type) }
    let(:status) { create(:status) }

    subject { build(:person, city:, district:, ward:, company_type:, status:) }

    # it { should validate_uniqueness_of(:cmnd).scoped_to(:cmnd).ignoring_case_sensitivity }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:managed_by) }
    it { should validate_presence_of(:date_start) }
  end
end
