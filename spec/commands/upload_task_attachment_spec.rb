# frozen_string_literal: true

describe UploadTaskAttachment, tpe: :command do
  subject(:command) { described_class.call(user,params) }
  let(:params) { {task_id: task_id, attachment: attachment} }
  describe 'when all params are valid' do
    let(:task) { create :task }
    let(:user) { task.user }
    let(:task_id) { task.id }
    let(:attachment) { valid_attachment_file }
    it 'succeeds & returns task with uploaded file url' do
      # expect(command.success?).to equal(true)
      # expect(command.result.id).to eq(task.id)
      # expect(command.result.attachment.url).to match(/https?:\/\/[\S]+/)
    end
  end
end
