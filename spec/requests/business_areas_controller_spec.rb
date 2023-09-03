require 'rails_helper'

RSpec.describe "BusinessAreasControllers", type: :request do
  describe "GET #index" do
    it 'returns a success response' do
      get business_areas_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    let(:business_area) { create(:business_area) }
    it 'returns a success response' do
      get business_area_path(business_area)
      expect(response).to have_http_status(200)
    end
  end
end
