# frozen_string_literal: true

RSpec.describe Task, type: :model do
  describe 'validations' do
    before { build(:task) }
    it { should validate_presence_of(:title) }
    it { should belong_to(:project) }
    it { should have_many(:comments) }
  end

  describe 'instance methods' do
    describe '#user_id' do
      let(:task) { create(:task) }

      it 'returns user id' do
        expect(task.user_id).to eq(task.project.user.id)
      end
    end
    describe '#user' do
      let(:task) { create(:task) }

      it 'returns expected user' do
        expect(task.user).to eq(task.project.user)
      end
    end
  end
end
