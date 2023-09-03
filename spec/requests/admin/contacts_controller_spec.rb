require 'rails_helper'

RSpec.describe "Admin::ContactsControllers", type: :request do
  let(:admin_user) { create(:user) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get admin_contacts_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    let(:contact) { create(:contact) }

    it 'redirects to the index page' do
      delete admin_contact_path(contact)
      expect(response).to have_http_status(302)
    end
  end
end
