require 'rails_helper'

RSpec.describe 'Admin::WardsControllers', type: :request do
  let(:admin_user) { create(:user) }
  let(:district) { create(:district) }
  let(:ward) { create(:ward, district:) }
  before do
    sign_in admin_user
  end

  describe 'GET #wards_by_district' do
    it 'returns a JSON response with wards for a given district' do
      get admin_wards_by_district_path, params: { district_id: district.id }, as: :json
      expect(response).to have_http_status(200)
    end
    it 'returns an empty JSON response if no wards are found' do
      get admin_wards_by_district_path, params: { district_id: district.id + 1 }, as: :json
      expect(response).to have_http_status(200)
    end
  end
end
