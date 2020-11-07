# frozen_string_literal: true

RSpec.describe '[DELETE] /comments' do
  before do
    stub_authorization(user)
    delete api_comment_path(comment_id)
  end
  context 'when comment does not exist' do
    let(:user) { create(:user) }
    let(:comment_id) { SecureRandom.uuid }
    it 'returns response with 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
  context 'when comment exists & belongs to authorized user' do
    let(:comment) { create(:comment) }
    let(:user) { comment.user }
    let(:comment_id) { comment.id }
    it 'returns response with 200 status code' do
      expect(response).to have_http_status(200)
    end
  end
  context 'when comment exists but do not belongs to authorized user' do
    let(:user) { create(:user) }
    let(:comment_id) { create(:comment).id }
    it 'returns response with 422 status code' do
      expect(response).to have_http_status(422)
    end
  end
end
