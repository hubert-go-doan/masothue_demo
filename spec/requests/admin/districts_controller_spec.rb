require 'rails_helper'

RSpec.describe "Admin::DistrictsControllers", type: :request do
  let(:admin_user) { create(:user) }

  before do
    sign_in admin_user
  end

  describe 'GET #districts_by_city' do
    let(:city) { create(:city) }
    let(:district) { create(:district, city:) }

    it 'returns a JSON response with districts for a given city' do
      get admin_districts_by_city_path, params: { city_id: city.id }, as: :json
      expect(response).to have_http_status(200)
    end
    it 'returns an empty JSON response if no districts are found' do
      get admin_districts_by_city_path, params: { city_id: city.id + 1 }, as: :json
      expect(response).to have_http_status(200)
    end
  end
end
