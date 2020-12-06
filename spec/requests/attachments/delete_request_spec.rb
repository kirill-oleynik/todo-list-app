# frozen_string_literal: true

RSpec.describe '[DELETE] /attachment' do
  before do
    mock_fog_storage
    task.attachment = valid_attachment_file
    stub_authorization(user)
    delete api_attachment_path, params: params
  end

  let(:params) { { attachment: { task_id: task_id } } }

  context 'when all params are valid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }

    it 'returns response eith 200 status code' do
      expect(response).to have_http_status(200)
    end

    it 'returns task without attachment url' do
      expect(response).to match_json_schema('entities/task')
      expect(parsed_body['attachment_url']).to equal(nil)
    end
  end

  context 'when task id is invlaid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { SecureRandom.uuid }

    it 'returns response with 422 status code' do
      expect(response).to have_http_status(422)
    end

    it 'provides errors at response body' do
      expect(parsed_body['task']).to eq('NotFound')
    end
  end
  context 'when user is not a task owner' do
    let(:task) { create(:task) }
    let(:user) { create(:user) }
    let(:task_id) { task.id }

    it 'returns response with 422 status code' do
      expect(response).to have_http_status(422)
    end

    it 'provides expected errors at response body' do
      expect(parsed_body['user']).to eq('NotAuthorized')
    end
  end
end
