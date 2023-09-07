require 'rails_helper'

RSpec.describe 'StatusControllers', type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get status_index_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    let(:status) { create(:status) }
    it 'returns a success response' do
      get status_path(status)
      expect(response).to have_http_status(200)
    end
  end
end
