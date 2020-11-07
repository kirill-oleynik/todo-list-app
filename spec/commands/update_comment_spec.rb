# frozen_string_literal: true

RSpec.describe UpdateComment, type: :command do
  subject(:command) { described_class.new(user, comment, params) }
  before { command.call }
  let(:comment) { create(:comment) }
  let(:user) { comment.user }
  let(:params) { { title: title } }
  let(:title) { Faker::Lorem.sentence }

  context 'when all params are valid' do
    it 'succeeds' do
      expect(command.success?).to equal(true)
      expect(command.errors).to be_empty
    end
    it 'returns updated comment' do
      expect(command.result).to be_a_kind_of(Comment)
      expect(command.result.id).to eq(comment.id)
      expect(command.result.title).to eq(title)
    end
  end
  context 'when title is invlaid' do
    let(:title) { '' }
    it 'fails' do
      expect(command.success?).to equal(false)
    end
    it 'returns expected error' do
      expect(command.errors).not_to be_empty
      expect(command.errors[:title]).to include('Invalid')
    end
  end
end
