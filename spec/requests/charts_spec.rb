require 'rails_helper'

RSpec.describe 'Charts', type: :request do
  describe 'GET /index' do
    it 'returns a success response' do
      get charts_path
      expect(response).to have_http_status(200)
    end
  end
end
