require 'rails_helper'

RSpec.describe 'Admin::CompanyTypesControllers', type: :request do
  let(:admin_user) { create(:user) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get admin_company_types_path
      expect(response).to have_http_status(200)
    end
  end
end
