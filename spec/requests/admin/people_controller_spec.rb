require 'rails_helper'

RSpec.describe 'Admin::PeopleControllers', type: :request do
  let(:admin_user) { create(:user) }

  let(:city) { create(:city) }
  let(:district) { create(:district, city:) }
  let(:ward) { create(:ward, district:) }
  let(:status) { create(:status) }
  let(:company_type) { create(:company_type) }
  let(:person) { create(:person) }

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get admin_people_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get new_admin_person_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          person: {
            name:            'Nguyen Doan Bao',
            cmnd:            '88484848484',
            address:         '123 Hà Nội',
            date_start:      Time.zone.today,
            phone_number:    '0192726333',
            managed_by:      'Chi cục thuế Quận 22',
            city_id:         city,
            district_id:     district,
            ward_id:         ward,
            company_type_id: company_type,
            status_id:       status
          }
        }
      end
      it 'returns 302 status' do
        post admin_people_path(valid_params)
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          person: {
            name:            '',
            cmnd:            '88484848484',
            address:         '123 Hà Nội',
            date_start:      Time.zone.today,
            phone_number:    '0192726333',
            managed_by:      'Chi cục thuế Quận 22',
            city_id:         city,
            district_id:     district,
            ward_id:         ward,
            company_type_id: company_type,
            status_id:       status
          }
        }
      end
      it 'returns unprocessable_entity status' do
        post admin_people_path(invalid_params)
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      get edit_admin_person_path(person)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT #update' do
    context 'with valid parameters' do
      it 'redirects to index' do
        new_name = 'Updated Name'
        put admin_person_path(person), params: { person: { name: new_name } }
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable_entity status' do
        put admin_person_path(person), params: { person: { name: '' } }
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get admin_person_path(person)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns a see_other response' do
      delete admin_person_path(person)
      expect(response).to have_http_status(303)
    end
  end

  describe 'GET #search' do
    context 'with valid search query' do
      it 'returns a success response with search results' do
        create(:person, name: 'hubert')
        get search_person_admin_people_path, params: { q: 'hubert' }
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid search query' do
      it 'returns a success response with no search results' do
        get search_person_admin_people_path, params: { q: 'Nonexistent' }
        expect(response).to have_http_status(200)
      end
    end
  end
end
