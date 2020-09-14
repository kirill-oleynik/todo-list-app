# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe 'validations' do
    before { build(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:name) }
    it { validate_uniqueness_of(:email).case_insensitive }
    it { should have_secure_password }
  end
end
