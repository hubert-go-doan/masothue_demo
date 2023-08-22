require 'rails_helper'

RSpec.describe TaxCode, type: :model do
  describe "associations" do
    it { should belong_to(:taxable) }
  end
  describe "validations" do
    let(:person) { build_stubbed(:person) }

    subject { build(:tax_code, taxable: person) }

    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:taxable_type) }
    it { should validate_presence_of(:taxable_id) }
  end
end
