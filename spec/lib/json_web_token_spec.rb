# frozen_string_literal: true

require 'securerandom'
require './lib/json_web_token.rb'

RSpec.describe JsonWebToken do
  it 'encodes and decodes payload correctly' do
    encoded_token = JsonWebToken.encode({ user_id: 'id' })
    decoded_token = JsonWebToken.decode(encoded_token)
    expect(decoded_token.slice(:user_id)['user_id']).to eq('id')
  end
end
