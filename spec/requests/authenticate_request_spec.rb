# frozen_string_literal: true

RSpec.describe AuthenticationController do
  describe 'POST /authenticate' do
    before { post authenticate_path, params: params }
    context 'when credentials are ok' do
      let!(:user) { create(:user) }
      let(:params) { { user: { email: user.email, password: user.password } } }
      it 'returns 201 status code' do
        expect(response).to have_http_status(201)
      end
      it 'returns access token' do
        expect(parsed_body).to have_key('access')
        expect(parsed_body['access']).to have_key('token')
        expect(parsed_body['access']).to have_key('expire')
      end
      it 'returns refresh token' do
        expect(parsed_body).to have_key('refresh')
        expect(parsed_body['refresh']).to have_key('token')
        expect(parsed_body['refresh']).to have_key('expire')
      end
    end
    context 'when credentials are invalid' do
      let(:params) { { user: attributes_for(:user).slice(:email, :password) } }
      it 'returns 401 status code' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
