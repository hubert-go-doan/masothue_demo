require 'rails_helper'

RSpec.describe Ward, type: :model do
  describe 'associations' do
    it { should belong_to(:district) }
    it { should have_many(:companies).dependent(:destroy) }
    it { should have_many(:people).dependent(:destroy) }
  end
end
