# frozen_string_literal: true

RSpec.describe '[POST] /comments' do
  before do
    stub_authorization(user)
    post api_comments_path, params: params
  end
  let(:params) do
    {
      comment: {
        title: title,
        task_id: task_id
      }
    }
  end
  let(:title) { Faker::Lorem.sentence }
  context 'when all params are valid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }
    it 'returns 201 status code' do
      expect(response).to have_http_status(201)
    end
    it 'returns created comment' do
      expect(response).to match_json_schema('entities/comment')
      expect(parsed_body['title']).to eq(title)
      expect(parsed_body['task_id']).to eq(task_id)
      expect(parsed_body['user_id']).to eq(user.id)
    end
  end
  context 'when task does not belongs to authorized user' do
    let(:user) { create(:user) }
    let(:task_id) { SecureRandom.uuid }

    it 'returns response with 422 status code' do
      expect(response).to have_http_status(422)
    end
    it 'returns error description in response body' do
      expect(parsed_body['task']).to eq('Not found')
    end
  end
  context 'when title is invalid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }
    let(:title) { '' }

    it 'returns response with 422 status code' do
      expect(response).to have_http_status(422)
    end
    it 'returns eror description in response body' do
      expect(parsed_body['title']).to eq('Invalid')
    end
  end
end
