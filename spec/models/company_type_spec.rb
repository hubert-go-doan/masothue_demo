require 'rails_helper'

RSpec.describe CompanyType, type: :model do
  describe 'associations' do
    it { should have_many(:companies).dependent(:nullify) }
    it { should have_many(:people).dependent(:nullify) }
  end
end
