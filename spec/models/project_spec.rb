# frozen_string_literal: true

RSpec.describe Project, type: :model do
  describe 'validations' do
    before { build(:project) }
    it { should validate_presence_of(:title) }
    it { should belong_to(:user) }
    it { should have_many(:tasks) }
  end
  describe 'instance methods' do
    describe '#tasks' do
      let(:project) { project_with_tasks(5) }

      it 'returns list of all projects tasks' do
        expect(project.tasks.length).to equal(5)
      end
    end
  end
end
