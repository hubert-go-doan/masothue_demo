require 'rails_helper'

RSpec.describe Represent, type: :model do
  describe 'associations' do
    it { should have_many(:companies).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
