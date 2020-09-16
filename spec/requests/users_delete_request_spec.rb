# frozen_string_literal: true

RSpec.describe 'Users', type: :request do
  describe 'DELETE /users/:id' do
    context 'when user can not be find' do
      before { delete api_user_path('iinvalid_id') }
      it 'returns 404 response status code' do
        expect(response).to have_http_status(404)
      end
    end
    describe 'when user exists' do
      let!(:user) { create(:user) }
      before { delete api_user_path(user.id) }
      it 'delets user & returns 204 status code' do
        expect(response).to have_http_status(204)
        expect(User.exists?(user.id)).to equal(false)
      end
    end
  end
end
