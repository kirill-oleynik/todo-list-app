# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  describe 'POST /users'
  describe 'when params are valid' do
    let(:params) { { user: attributes_for(:user) } }
    before { post api_users_path, params: params }
    it 'creates new user & returns expected response' do
      expect(User.count).to equal(1)
      expect(response).to have_http_status(201)
      expect(response).to match_json_schema('entities/user')
    end
  end
  describe 'when name is missing in params' do
    let(:params) { { user: attributes_for(:user, name: nil) } }
    before { post api_users_path, params: params }
    it 'does not create new user and returns errors via appropriate response' do
      expect(response).to have_http_status(422)
      expect(parsed_body).to have_key('name')
    end
  end
  describe 'when email already exists' do
    let!(:user) { create(:user) }
    let(:params) { { user: attributes_for(:user, email: user.email) } }
    before { post api_users_path, params: params }
    it 'returns errors via appropriate response' do
      expect(response).to have_http_status(422)
      expect(parsed_body).to have_key('email')
    end
  end
end
