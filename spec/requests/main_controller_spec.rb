require 'rails_helper'

RSpec.describe 'MainControllers', type: :request do
  describe 'GET #home' do
    it 'returns a success response' do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #search' do
    context 'when query is not present' do
      it 'returns a success response' do
        get search_path
        expect(response).to have_http_status(200)
      end
    end

    context 'when query is present' do
      it 'returns results and redirects when @results.count == 1' do
        company = create(:company, name: 'HUBERT003')
        get search_path(q: 'HUBERT003')
        expect(response).to redirect_to(info_detail_path(id: company.id, type: 'company'))
      end
    end
  end

  describe 'GET #info_detail' do
    let(:person) { create(:person) }
    let(:company) { create(:company) }

    it 'returns a success response for person' do
      get info_detail_path(type: 'person', id: person.id)
      expect(response).to have_http_status(200)
    end

    it 'returns a success response for company' do
      get info_detail_path(type: 'company', id: company.id)
      expect(response).to have_http_status(200)
    end
  end
end
