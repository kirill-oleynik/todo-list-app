# frozen_string_literal: true

RSpec.describe CreateTask, type: :command do
  subject(:command) { described_class.new(user, params) }
  context 'when project does not exist' do
    let(:user) { create(:user) }
    let(:params) { nil }
    before { command.call }

    it 'does not succeed' do
      expect(command.success?).to equal(false)
    end
    it 'returns nil' do
      expect(command.result).to equal(nil)
    end
    it 'provides errros' do
      expect(command.errors).not_to be_empty
      expect(command.errors).to have_key(:project)
      expect(command.errors[:project]).to include('Not found')
    end
  end
  context 'when project exists' do
    let(:project) { create(:project) }
    let(:user) { project.user }
    context 'and all task attributes given' do
      let(:params) do
        {
          project_id: project.id,
          title: 'task_title',
          done: true
        }
      end
      before { command.call }

      it 'succeds' do
        expect(command.success?).to equal(true)
      end
      it 'does not set errors' do
        expect(command.errors).to be_empty
      end
      it 'returns created task with given attributes' do
        expect(command.result.class).to equal(Task)
        expect(command.result.title).to eq('task_title')
        expect(command.result.done).to equal(true)
      end
    end
    context 'and task attributes are missing' do
      let(:params) { { project_id: project.id } }
      before { command.call }
      it 'succeeds' do
        expect(command.success?).to equal(true)
      end
      it 'does not set errors' do
        expect(command.errors).to be_empty
      end
      it 'returns a new task with defualt attributes' do
        expect(command.result.class).to equal(Task)
        expect(command.result.title).to eq('')
        expect(command.result.done).to eq(false)
      end
    end
  end
end
