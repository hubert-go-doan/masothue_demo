require 'rails_helper'

RSpec.describe 'TaxCodePersonalControllers', type: :request do
  describe 'GET #index' do
    it 'returns a success response' do
      get tax_code_personal_index_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #search' do
    it 'returns results when query is present' do
      person = create(:person, cmnd: '12345678', tax_code: create(:tax_code, code: '98765'))
      get search_person_tax_code_personal_index_path(q: '12345678')
      expect(response).to redirect_to(info_detail_path(id: [person.id], type: 'person'))
    end

    it 'renders no_result when query has no matches' do
      get search_person_tax_code_personal_index_path(q: 'nonexistent')
      expect(response).to have_http_status(200)
    end
  end
end
