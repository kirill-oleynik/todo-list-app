# frozen_string_literal: true

RSpec.describe '[GET] /tasks/:id' do
  context 'when task does not exist' do
    before do
      stub_authorization
      get api_task_path(SecureRandom.uuid)
    end

    it 'returns 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
  context 'when task exists but do not belongs to current user' do
    let(:task) { create(:task) }
    before do
      stub_authorization
      get api_task_path(task.id)
    end
    it 'returns 422 status code' do
      expect(response).to have_http_status(422)
    end
  end
  context 'when task exists & belongs to current user' do
    let(:task) { create(:task) }
    before do
      stub_authorization(task.user)
      get api_task_path(task.id)
    end
    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'returns requested task' do
      expect(response).to match_json_schema('entities/task')
      expect(parsed_body['id']).to eq(task.id)
    end
  end
end
