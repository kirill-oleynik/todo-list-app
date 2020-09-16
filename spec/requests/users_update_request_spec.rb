# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  describe 'PUT /users/:id' do
    context 'when user not exists' do
      let(:params) { attributes_for(:user) }
      before { put '/users/invalid', params: params }
      it 'returns 404 response status code' do
        expect(response).to have_http_status(404)
      end
    end
    describe 'when user exists' do
      let!(:user) { create(:user) }
      describe 'and update params are valid' do
        let(:params) { { user: { name: 'new_name' } } }
        before { put api_user_path(user), params: params }
        it 'updates user and returns appropriate response' do
          expect(response).to have_http_status(200)
          expect(parsed_body['name']).to eq(params[:user][:name])
          expect(response).to match_json_schema('entities/user')
        end
      end
      describe 'and email is invalid (has been taken)' do
        let!(:user2) { create(:user) }
        let(:params) { { user: { email: user.email } } }
        before { put api_user_path(user2), params: params }
        it 'does not update user and returns errors via appropriate response' do
          expect(response).to have_http_status(422)
          expect(parsed_body).to have_key('email')
        end
      end
    end
  end
end
