require 'rails_helper'

RSpec.describe "ContactsControllers", type: :request do
  describe 'GET #new' do
    it 'returns a success response' do
      get contacts_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) do
        {
          contact: {
            name:    'Hubert',
            email:   'Hubert@gmail.com',
            content: 'Say Hi.'
          }
        }
      end
      it 'redirects to contacts_path with a success notice' do
        post contacts_path(valid_params)
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) do
        {
          contact: {
            name:    '',
            email:   '',
            content: ''
          }
        }
      end
      it 'renders unprocessable_entity status' do
        post contacts_path(invalid_params)
        expect(response).to have_http_status(422)
      end
    end
  end
end
