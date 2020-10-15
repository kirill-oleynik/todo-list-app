# frozen_string_literal: true

RSpec.describe AuthenticateUser, type: :command do
  describe 'when user exists and credentials are valid' do
    let!(:user) { create(:user) }
    let(:command) { described_class.new(email: user.email, password: user.password) }
    before { command.call }
    it 'returns hash with access & refresh tokens sith epiration time' do
      expect(command.success?).to equal(true)
      expect(command.errors).to be_empty
      expect(command.result.class).to equal(Hash)
      expect(command.result).to have_key(:access)
      expect(command.result[:access]).to have_key(:token)
      expect(command.result[:access]).to have_key(:expire)
      expect(command.result).to have_key(:refresh)
      expect(command.result[:refresh]).to have_key(:token)
      expect(command.result[:refresh]).to have_key(:expire)
    end
  end
  describe 'when user does not exist' do
    let(:args) { attributes_for(:user).slice(:email, :password) }
    let(:command) { described_class.new(**args) }
    before { command.call }
    it 'returns nil & sets errors' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
      expect(command.errors).not_to be_empty
      expect(command.errors).to have_key(:user_authentication)
      expect(command.errors[:user_authentication]).to include('Invalid credentials')
    end
  end
  describe 'when user exists but credentials are invalid' do
    let(:args) { attributes_for(:user).slice(:email, :password) }
    let(:command) { described_class.new(**args) }
    before do
      create(:user)
      command.call
    end
    it 'returns nil & sets errors' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
      expect(command.errors).not_to be_empty
      expect(command.errors).to have_key(:user_authentication)
      expect(command.errors[:user_authentication]).to include('Invalid credentials')
    end
  end
end
