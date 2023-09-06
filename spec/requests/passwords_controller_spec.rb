require 'rails_helper'

RSpec.describe 'PasswordsControllers', type: :request do
  describe 'GET #new' do
    it 'returns a success response' do
      get new_user_password_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #edit' do
    it 'returns 302 status' do
      get edit_user_password_path
      expect(response).to have_http_status(302)
    end
  end
end
