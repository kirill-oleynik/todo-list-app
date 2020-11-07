# frozen_string_literal: true

RSpec.describe CreateComment, type: :command do
  subject(:command) { described_class.new(user, params) }
  before { command.call }
  let(:params) do
    {
      title: title,
      task_id: task_id
    }
  end
  let(:title) { Faker::Lorem.sentence }
  context 'when all params are valid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }

    it 'succeeds' do
      expect(command.success?).to equal(true)
      expect(command.errors).to be_empty
    end
    it 'returns created comment' do
      expect(command.result.title).to eq(title)
      expect(command.result.task.id).to eq(task_id)
    end
  end
  context 'when task does not belong to user' do
    let(:user) { create(:user) }
    let(:task_id) { SecureRandom.uuid }

    it 'does not succeed' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
      expect(command.errors).not_to be_empty
      expect(command.errors[:task]).to include('Not found')
    end
  end
  context 'when title is invalid' do
    let(:task) { create(:task) }
    let(:user) { task.user }
    let(:task_id) { task.id }
    let(:title) { '' }

    it 'does not succeed' do
      expect(command.success?). to equal(false)
      expect(command.result).to equal(nil)
      expect(command.errors).not_to be_empty
      expect(command.errors[:title]).to include('Invalid')
    end
  end
end
