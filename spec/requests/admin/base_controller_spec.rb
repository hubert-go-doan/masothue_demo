require 'rails_helper'

RSpec.describe "Admin::BaseControllers", type: :request do
  let(:admin_user) { create(:user) }

  context 'when user is authenticated' do
    before do
      sign_in admin_user
    end

    describe 'GET #index' do
      it 'renders the index template' do
        get admin_root_path
        expect(response).to have_http_status(200)
      end
    end
  end

  context 'when user is not authenticated' do
    describe 'GET #index' do
      it 'redirects to new_user_session_path' do
        get admin_root_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
