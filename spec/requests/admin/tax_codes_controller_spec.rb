require 'rails_helper'

RSpec.describe 'Admin::TaxCodesControllers', type: :request do
  let(:admin_user) { create(:user) }
  let(:tax_code) { create(:tax_code) }

  before do
    sign_in admin_user
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_admin_tax_code_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns a see_other response' do
      delete admin_tax_code_path(tax_code)
      expect(response).to have_http_status(303)
    end
  end
end
