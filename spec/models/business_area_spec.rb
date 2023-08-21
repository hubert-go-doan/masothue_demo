require 'rails_helper'

RSpec.describe BusinessArea, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name).with_message("Please Business Area name cannot be blank") }
    it { should validate_uniqueness_of(:name) }
  end
  describe "associations" do
    it { should have_many(:companies).dependent(:nullify) }
  end
end
