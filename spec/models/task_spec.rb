# frozen_string_literal: true

RSpec.describe Task, type: :model do
  describe 'validations' do
    before { build(:task) }
    it { should validate_presence_of(:title) }
    it { should belong_to(:project) }
  end

  describe 'instance methods' do
    describe '#user_id' do
      let(:task) { create(:task) }

      it 'returns user id' do
        expect(task.user_id).to eq(task.project.user.id)
      end
    end
  end
end
