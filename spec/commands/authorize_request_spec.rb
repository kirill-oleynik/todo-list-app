# frozen_string_literal: true

RSpec.describe AuthorizeRequest, type: :command do
  describe 'when no auth header does not contain token' do
    let(:headers) { { foo: 'bar' } }
    let(:command) { described_class.new(headers) }
    before { command.call }
    it 'returns nil and sets errors' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
      expect(command.errors).not_to be_empty
      expect(command.errors).to have_key(:token)
      expect(command.errors).to have_key(:auth_header)
      expect(command.errors[:auth_header]).to include('Misssing')
    end
  end
  describe 'when token is invalid' do
    let(:headers) { { 'Authorization': 'Base invalid_token' } }
    let(:command) { described_class.new(headers) }
    before { command.call }
    it 'returns nil and sets errors' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
      expect(command.errors).not_to be_empty
      expect(command.errors).to have_key(:token)
      expect(command.errors[:token]).to include('Invalid')
    end
  end
  describe 'when token is valid & not expired' do
    let!(:user) { create(:user) }
    let(:payload) { { user_id: user.id } }
    let(:token) { JsonWebToken.encode(payload) }
    let(:headers) { { 'Authorization': "Base #{token}" } }
    let(:command) { described_class.new(headers) }
    before { command.call }
    it 'returns current user without errors' do
      expect(command.success?).to equal(true)
      expect(command.result).to be_an_instance_of(User)
      expect(command.result.id).to eq(user.id)
      expect(command.errors).to be_empty
    end
  end
  describe 'when token is avlid & not expired but user not exists' do
    let(:payload) { { user_id: SecureRandom.uuid } }
    let(:token) { JsonWebToken.encode(payload) }
    let(:headers) { { 'Authorization': "Base #{token}" } }
    let(:command) { described_class.new(headers) }
    before { command.call }
    it 'returns nil and sets errors' do
      expect(command.result).to equal(nil)
      expect(command.success?).to equal(false)
      expect(command.errors).not_to be_empty
      expect(command.errors).to have_key(:user)
      expect(command.errors[:user]).to include('Not found')
    end
  end
  describe 'when token user exists but token is expired' do
    let!(:user) { create(:user) }
    let(:payload) { { user_id: user.id } }
    let(:token) { JsonWebToken.encode(payload, 1.day.ago) }
    let(:headers) { { 'Authorization': "Base #{token}" } }
    let(:command) { described_class.new(headers) }
    before { command.call }
    it 'returns nil and sets errors' do
      expect(command.success?).to equal(false)
      expect(command.result).to equal(nil)
      expect(command.errors).not_to be_empty
      expect(command.errors).to have_key(:token)
      expect(command.errors[:token]).to include('Invalid')
    end
  end
end
