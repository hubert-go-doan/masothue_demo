require 'rails_helper'

RSpec.describe District, type: :model do
  describe 'associations' do
    it { should belong_to(:city) }
    it { should have_many(:wards).dependent(:destroy) }
    it { should have_many(:companies).dependent(:destroy) }
    it { should have_many(:people).dependent(:destroy) }
  end
end
