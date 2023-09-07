require 'rails_helper'

RSpec.describe 'CitiesControllers', type: :request do
  let(:city) { create(:city) }
  let(:district) { create(:district, city:) }
  let(:ward) { create(:ward, district:) }

  describe 'GET #index' do
    it 'returns a success response' do
      get cities_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get city_path(city)
      expect(response).to have_http_status(200)
    end
    it 'redirects to index when city is not found' do
      get city_path('nonexistent_id')
      expect(response).to have_http_status(302)
    end
  end

  describe 'GET #show_district' do
    it 'returns a success response' do
      get district_path(district)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show_ward' do
    it 'returns a success response' do
      get ward_path(ward)
      expect(response).to have_http_status(200)
    end
  end
end
