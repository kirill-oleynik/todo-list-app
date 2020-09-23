# frozen_string_literal: true

# Wraps request authorization logic
class AuthorizeRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  rescue ActiveRecord::RecordNotFound
    errors.add(:user, 'Not found')
    nil
  end

  private

  attr_reader :headers

  def unexpied?
    Time.at(decoded_auth_token[:exp]) > Time.now
  rescue NoMethodError, TypeError
    errors.add(:token, 'Invalid')
    false
  end

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return headers[:Authorization].split(' ').last if headers[:Authorization].present?

    errors.add(:auth_header, 'Misssing')
    nil
  end
end
