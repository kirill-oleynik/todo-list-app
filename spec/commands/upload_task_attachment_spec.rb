# frozen_string_literal: true

describe UploadTaskAttachment, tpe: :command do
  subject(:command) { described_class.new(user, params) }
  before do
    mock_fog_storage
    command.call
  end
  let(:params) { { task_id: task_id, attachment: attachment } }
  let(:task) { create(:task) }
  let(:user) { task.user }
  let(:task_id) { task.id }
  let(:attachment) { valid_attachment_file }
  context 'when all params are valid' do
    it 'succeeds' do
      expect(command.success?).to equal(true)
    end
    it 'returns task with uploaded attachment url' do
      expect(command.result).to eq(task)
      expect(command.result.attachment.file.exists?).to equal(true)
      expect(command.result.attachment_url).to match(%r{https?://[\S]+})
    end
  end
  context 'when task id is invalid' do
    let(:task_id) { SecureRandom.uuid }
    let(:user) { create(:user) }
    let(:attachment) { valid_attachment_file }
    it 'does not succeeds' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
    end

    it 'provides expected errors' do
      expect(command.errors.length).to equal(1)
      expect(command.errors[:task]).to include('NotFound')
    end
  end
  context 'when task does not belongs to provided user' do
    let(:task) { create(:task) }
    let(:task_id) { task.id }
    let(:user) { create(:user) }
    let(:attachment) { valid_attachment_file }

    it 'does not succeeds' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
    end

    it 'provides expected errrors' do
      expect(command.errors[:user]).to include('NotAuthorized')
    end
  end
  context 'when file type is not supported' do
    let(:attachment) { invalid_attachment_file }
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }

    it 'does not succeed' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
    end

    it 'provides expected errors' do
      expect(command.errors).not_to be_empty
      expect(command.errors[:file]).to include('NotSupported')
    end
  end
end
