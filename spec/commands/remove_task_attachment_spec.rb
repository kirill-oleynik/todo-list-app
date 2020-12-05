# frozen_string_literal: true

describe RemoveTaskAttachment, tpe: :command do
  subject(:command) { described_class.new(user, task_id) }
  before do
    mock_fog_storage
    command.call
  end
  let(:attachment) { valid_attachment_file }
  before { task.attachment = attachment }
  context 'when all params are valid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }

    it 'succeeds and returns task wthout attachment' do
      expect(command.success?).to equal(true)
      expect(command.result).to eq(task)
      expect(command.result.attachment_url).to equal(nil)
      expect(command.result.attachment.file).to equal(nil)
    end
  end
  context 'when task id is not valid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { SecureRandom.uuid }

    it 'does not succeed' do
      expect(command.success?).to equal(false)
      expect(command.result).to eq(nil)
    end

    it 'provides expected errors' do
      expect(command.errors).not_to be_empty
      expect(command.errors[:task]).to include('NotFound')
    end
  end
  context 'when user is not a task owner' do
    let(:task) { create(:task) }
    let(:task_id) { task.id }
    let(:user) { create(:user) }

    it 'does not succeeds' do
      expect(command.success?).to equal(false)
      expect(command.result).to eq(nil)
    end

    it 'provides expected errors' do
      expect(command.errors).not_to be_empty
      expect(command.errors[:user]).to include('NotAuthorized')
    end
  end
end
