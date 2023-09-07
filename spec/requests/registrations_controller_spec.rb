require 'rails_helper'

RSpec.describe 'RegistrationsControllers', type: :request do
  describe 'GET #edit' do
    it 'returns 302 status' do
      get edit_user_registration_path
      expect(response).to have_http_status(302)
    end
  end
end
