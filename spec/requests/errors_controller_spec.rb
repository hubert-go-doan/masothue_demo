require 'rails_helper'

RSpec.describe "ErrorsControllers", type: :request do
  describe 'GET #not_found' do
    it 'returns a not_found response' do
      get not_found_path
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #internal_server_error' do
    it 'returns an internal_server_error response' do
      get internal_server_error_path
      expect(response).to have_http_status(:internal_server_error)
    end
  end
end
