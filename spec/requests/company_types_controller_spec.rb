require 'rails_helper'

RSpec.describe 'CompanyTypesControllers', type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get company_types_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #show' do
    let(:company_type) { create(:company_type) }
    it 'returns a success response' do
      get company_type_path(company_type)
      expect(response).to have_http_status(200)
    end
  end
end
