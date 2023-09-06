require 'rails_helper'

RSpec.describe 'NewlyEstablishedControllers', type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get newly_established_index_path
      expect(response).to have_http_status(200)
    end
  end
end
