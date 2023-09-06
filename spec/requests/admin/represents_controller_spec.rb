require 'rails_helper'

RSpec.describe 'Admin::RepresentsControllers', type: :request do
  let(:admin_user) { create(:user) }

  before do
    sign_in admin_user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_admin_represent_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        { represent: { name: 'Hubert' } }
      end
      it 'redirects to success' do
        post admin_represents_path(valid_params)
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        { represent: { name: '' } }
      end
      it 'returns unprocessable_entity status' do
        post admin_represents_path(invalid_params)
        expect(response).to have_http_status(422)
      end
    end
  end
end
