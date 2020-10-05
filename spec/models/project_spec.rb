# frozen_string_literal: true

RSpec.describe Project, type: :model do
  describe 'validations' do
    before { build(:project) }
    it { should validate_presence_of(:title) }
    it { should belong_to(:user) }
  end
end
