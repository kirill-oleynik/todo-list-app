# frozen_string_literal: true

RSpec.describe '[DELETE \tasks\:id]' do
  before { stub_authorization(user) }
  context 'when task exists & belongs to current user' do
    let(:task) { create(:task) }
    let(:user) { task.user }

    before { delete api_task_path(task.id) }
    it 'deletes task' do
      expect(Task.exists?(task.id)).to equal(false)
    end
    it 'returns 200 status code' do
      expect(response).to have_http_status(200)
    end
  end
  context 'when task exists but do not belongs to current user' do
    let(:user) { create(:user) }
    let(:task) { create(:task) }
    before { delete api_task_path(task.id) }
    it 'does not delete task' do
      expect(Task.exists?(task.id)).to equal(true)
    end
    it 'returns 422 status code' do
      expect(response).to have_http_status(422)
    end
  end
  context 'when task does not exist' do
    let(:user) { create(:user) }
    before { delete api_task_path(SecureRandom.uuid) }
    it 'returns 404 status code' do
      expect(response).to have_http_status(404)
    end
  end
end
