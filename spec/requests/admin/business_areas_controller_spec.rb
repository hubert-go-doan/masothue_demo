require 'rails_helper'

RSpec.describe 'Admin::BusinessAreasControllers', type: :request do
  let(:admin_user) { create(:user) }
  let(:business_area) { create(:business_area) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get admin_business_areas_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_admin_business_area_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #search' do
    let(:business_area_search) { create(:business_area_search, name: 'hubert') }

    it 'returns results when query is present' do
      get search_business_are_admin_business_areas_path(q: 'hubert')
      expect(response).to have_http_status(200)
    end

    it 'renders no_result when query has no matches' do
      get search_business_are_admin_business_areas_path(q: '')
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get edit_admin_business_area_path(business_area)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'updates the business area and redirects to index' do
        new_name = 'Updated Name'
        put admin_business_area_path(business_area), params: { business_area: { name: new_name } }
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable_entity status' do
        put admin_business_area_path(business_area), params: { business_area: { name: '' } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'returns redirects to' do
      delete admin_business_area_path(business_area)
      expect(response).to have_http_status(302)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        { business_area: { name: 'Hubert' } }
      end
      it 'redirects to success' do
        post admin_business_areas_path(valid_params)
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { business_area: { name: '' } }
      end
      it 'returns unprocessable_entity status' do
        post admin_business_areas_path(invalid_params)
        expect(response).to have_http_status(422)
      end
    end
  end
end
