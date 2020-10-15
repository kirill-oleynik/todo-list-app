# frozen_string_literal: true

RSpec.describe '[PUT] /tasks/:id' do
  before { stub_authorization(user) }
  let(:params) do
    {
      task: {
        title: 'new_title',
        done: true
      }
    }
  end

  context 'when task does not belong to current user' do
    let(:user) { create(:user) }
    let(:task) { create(:task) }
    before { put api_task_path(task.id), params: params }
    it 'returns 422 status code' do
      expect(response).to have_http_status(422)
    end
  end
  context 'when task belongs to current user' do
    let(:task) { create(:task, done: false) }
    let(:user) { task.user }
    before { put api_task_path(task.id), params: params }
    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end
    it 'returns updated task' do
      expect(response).to match_json_schema('entities/task')
      expect(parsed_body['title']).to eq('new_title')
      expect(parsed_body['done']).to eq(true)
      expect(parsed_body['user_id']).to eq(user.id)
    end
  end
  context 'when task does not exist' do
    let(:user) { create(:user) }
    before { put api_task_path(SecureRandom.uuid), params: params }

    it 'returns 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
end
