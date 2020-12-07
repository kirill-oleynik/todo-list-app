# frozen_string_literal: true

RSpec.describe '[POST] /attachment' do
  before do
    mock_fog_storage
    stub_authorization(user)
    post api_create_attachment_path, params: params
  end

  let(:params) { { attachment: { task_id: task_id, attachment: attachment } } }

  context 'when all params are valid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }
    let(:attachment) { valid_attachment_file }

    it 'returns response with status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns task with uploaded attachment url & attachment filename' do
      expect(response).to match_json_schema('entities/task')
      expect(parsed_body['id']).to eq(task_id)
      expect(parsed_body['attachment_url']).to match(%r{https?://[\S]+})
      expect(parsed_body['attachment_filename']).to eq('upload_example_file.txt')
    end
  end

  context 'when task id is not valid' do
    let(:user) { create(:user) }
    let(:task_id) { SecureRandom.uuid }
    let(:attachment) { valid_attachment_file }

    it 'returns response with status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'provides expected errors at response body' do
      expect(parsed_body['task']).to eq('NotFound')
    end
  end

  context 'when user is not a task owner' do
    let(:attachment) { valid_attachment_file }
    let(:task) { create(:task) }
    let(:user) { create(:user) }
    let(:task_id) { task.id }

    it 'returns response with status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns expected errrors at response body' do
      expect(parsed_body['user']).to eq('NotAuthorized')
    end
  end

  context 'when file type is not supported' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }
    let(:attachment) { invalid_attachment_file }

    it 'returns response with status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns expected errors at response body' do
      expect(parsed_body['file']).to eq('NotSupported')
    end
  end
end
