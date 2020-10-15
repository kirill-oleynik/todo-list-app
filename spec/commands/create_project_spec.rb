# frozen_string_literal: true

RSpec.describe CreateProject, type: :command do
  describe 'when all params are valid' do
    let(:title) { attributes_for(:project)[:title] }
    let(:user) { create(:user) }
    let(:command) { described_class.new(user, title) }
    before { command.call }
    it 'succeeds' do
      expect(command.success?).to equal(true)
      expect(command.errors).to be_empty
    end

    it 'returns created project as result' do
      expect(command.result.class).to eq(Project)
      expect(command.result.title).to eq(title)
    end
  end
end
