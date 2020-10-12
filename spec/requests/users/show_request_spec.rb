# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  describe 'GET /users/:id' do
    before(:each) { stub_authorization }
    context 'when user not exists' do
      before { get api_user_path('invalid_id') }
      it 'returns 404 response status code' do
        expect(response).to have_http_status(404)
      end
    end
    describe 'when user exists' do
      let!(:user) { create(:user) }
      before { get api_user_url(user) }
      it 'returns requested user via appropriate response' do
        expect(response).to have_http_status(200)
        expect(response).to match_json_schema('entities/user')
      end
    end
  end
end
