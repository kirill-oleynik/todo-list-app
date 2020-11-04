# frozen_string_literal: true

RSpec.describe Comment, type: :model do
  describe 'validations' do
    before { build(:comment) }
    it { should validate_presence_of(:title) }
    it { should belong_to(:task) }
  end

  describe 'instance methods' do
    describe '#user_id' do
      let(:comment) { create(:comment) }

      it 'returns user id' do
        expect(comment.user_id).to eq(comment.task.project.user.id)
      end
    end
    describe '#user' do
      let(:comment) { create(:comment) }

      it 'returns expected user' do
        expect(comment.user).to eq(comment.task.project.user)
      end
    end
  end
end
