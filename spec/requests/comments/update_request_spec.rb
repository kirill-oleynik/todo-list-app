# frozen_string_literal: true

RSpec.describe '[PUT] /comments/:id' do
  before do
    stub_authorization(user)
    put api_comment_path(comment_id), params: params
  end

  let(:params) do
    {
      comment: {
        title: title,
      }
    }
  end
  let(:title) { Faker::Lorem.sentence }
  context 'when comment not exists' do
    let(:user) { create(:user) }
    let(:comment_id) { SecureRandom.uuid }

    it 'returns response with 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
  context 'when all params are valid' do
    let(:comment) { create(:comment) }
    let(:user) { comment.user }
    let(:comment_id) { comment.id }

    it 'returns response with 200 status code' do
      expect(response).to have_http_status(200)
    end
    it 'returns updated comment' do
      expect(response).to match_json_schema('entities/comment')
      expect(parsed_body['title']).to eq(title)
      expect(parsed_body['id']).to eq(comment_id)
      expect(parsed_body['user_id']).to eq(user.id)
      expect(parsed_body['task_id']).to eq(comment.task.id)
    end
  end
  context 'when title is invalid' do
    let(:comment) { create(:comment) }
    let(:user) { comment.user }
    let(:comment_id) { comment.id }
    let(:title) { String.new() }

    it 'returns respons with 422 status code' do
      expect(response).to have_http_status(422)
    end

    it 'returns error description as response body' do
      expect(parsed_body['title']).to eq('Invalid')
    end
  end
end
