# frozen_string_literal: true

# Wraps  user authentication logic
class AuthenticateUser
  prepend SimpleCommand

  EXPIRE = {
    access: 5.minutes.from_now.to_json,
    refresh: 1.month.from_now.to_json
  }.freeze

  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def call
    return auth_tokens if user

    nil
  end

  private

  attr_reader :email, :password

  def auth_tokens
    {
      access: { token: access_token, expire: EXPIRE[:access] },
      refresh: { token: refresh_token, expire: EXPIRE[:refresh] }
    }
  end

  def access_token
    JsonWebToken.encode(payload, EXPIRE[:access])
  end

  def refresh_token
    JsonWebToken.encode(payload, EXPIRE[:refresh])
  end

  def payload
    return {} unless user

    { user_id: user.id }
  end

  def user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    errors.add :user_authentication, 'Invalid credentials'
    nil
  end
end
