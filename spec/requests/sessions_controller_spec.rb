require 'rails_helper'

RSpec.describe "SessionsControllers", type: :request do
  describe "GET #new" do
    it 'returns a success response' do
      get new_user_session_path
      expect(response).to have_http_status(200)
    end
  end
end
