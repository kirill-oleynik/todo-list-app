# frozen_string_literal: true

RSpec.describe '[GET] /comments/:id' do
  context 'when comment does not exist' do
    before do
      stub_authorization
      get api_comment_path(SecureRandom.uuid)
    end

    it 'returns 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
  context 'when comment exists but do not belongs to current user' do
    let(:comment) { create(:comment) }
    before do
      stub_authorization
      get api_comment_path(comment.id)
    end
    it 'returns 422 status code' do
      expect(response).to have_http_status(422)
    end
  end
  context 'when comment exists & belongs to current user' do
    let(:comment) { create(:comment) }
    before do
      stub_authorization(comment.user)
      get api_comment_path(comment.id)
    end
    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'returns requested comment' do
      expect(response).to match_json_schema('entities/comment')
      expect(parsed_body['id']).to eq(comment.id)
    end
  end
end
